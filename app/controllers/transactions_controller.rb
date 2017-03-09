class TransactionsController < ApplicationController
  helper_method :filter

  def index
    render locals: {
      transactions: transactions.eager(*transaction_eager).paginate(page, per_page).all,
      transactions_count: transactions.count
    }
  end

  def pending_webhooks
    render locals: {
      transactions: pending_webhooks_transactions.eager(*transaction_eager).paginate(page, per_page).all,
      transactions_count: transactions.count
    }
  end

  def new
    if reverse_transaction.present?
      transaction_form.amount_cents = reverse_transaction.amount.to_f
      transaction_form.amount_currency = reverse_transaction.amount_currency
      transaction_form.from_account_id = reverse_transaction.to_account_id
      transaction_form.to_account_id = reverse_transaction.from_account_id
      transaction_form.key = reverse_transaction.key + '-reverse'
      transaction_form.date = reverse_transaction.date
      transaction_form.details = "Reverse of #{reverse_transaction.details}"
    end
    render locals: { transaction: transaction_form }
  end

  def edit
    transaction_form = TransactionForm.new transaction
    transaction_form.amount_cents = transaction.amount.to_f
    render :new, locals: { transaction: transaction_form }
  end

  def create
    if transaction_form.valid?
      transactions.insert transaction_form.to_hash
      redirect_to transactions_path
    else
      render :new, locals: { transaction: transaction_form }
    end

  rescue => err
    flash.now[:error] = err.message
    render :new, locals: { transaction: transaction_form }
  end

  def update
    transaction_form = TransactionForm.new({ **permitted_params.symbolize_keys, id: transaction.id, date: date })
    if transaction_form.valid?
      transaction.update transaction_form.to_hash
      redirect_to transactions_path
    else
      render :new, locals: { transaction: transaction_form }
    end

  rescue => err
    flash.now[:error] = err.message
    render :new, locals: { transaction: transaction_form }
  end

  def notify
    flash[:success] = "Transaction #{transaction.id} is notified"
    Openbill.service.notify_transaction transaction
    redirect_to :back
  end

  def show
    render locals: { transaction: transaction }
  end

  def destroy
    transaction.delete
    redirect_to transactions_path
  rescue => err
    redirect_to transactions_path, flash: { error: err.message }
  end

  def export
    content = TransactionsSpreadsheet.new(transactions).to_csv
    send_data(
        content,
        disposition: 'attachment; filename=transactions.csv',
        type: 'text/csv'
    )
  end

  private

  def transaction_form
    @_transaction_form ||= TransactionForm.new({
      **permitted_params.symbolize_keys,
      date: date
    })
  end

  def date
    return unless params.key?(:transaction)
    TransactionDate.parse permitted_params
  end

  def transaction_eager
    if Features.has_goods?
      [:good, :from_account, :to_account, :last_webhook_log]
    else
      [:from_account, :to_account, :last_webhook_log]
    end
  end

  def reverse_transaction
    return nil unless permitted_params[:reverse_transaction_id].present?
    Openbill.service.get_transaction permitted_params[:reverse_transaction_id]
  end

  def transaction
    Openbill.service.get_transaction(params[:id]) || fail(NotFound)
  end

  def transactions
    scope = Openbill.service.transactions.reverse_order(:created_at)
    if params.key?(:custom_filter) && params[:custom_filter].key?(:account_id)
      scope = scope.where('from_account_id = ? OR to_account_id = ?', params[:custom_filter][:account_id], params[:custom_filter][:account_id])
    end
    filter.apply(scope)
  end

  def pending_webhooks_transactions
    filter.apply(Openbill.service.get_pending_webhooks_transactions)
  end

  def permitted_params
    return {} unless params[:transaction].present?
    # Allow any parameters
    params.require(:transaction).permit!
  end
end
