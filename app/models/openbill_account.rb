class OpenbillAccount < ApplicationRecord
  belongs_to :category, class_name: 'OpenbillCategory'

  scope :ordered, -> { order :id }

  monetize :amount_cents

  def amount_by_period(period)
    plus = OpenbillTransaction
      .where(to_account_id: id)
      .by_period(period)
      .sum(:amount_cents) || 0

    minus = OpenbillTransaction
      .where(from_account_id: id)
      .by_period(period)
      .sum(:amount_cents) || 0

    Money.new plus - minus, amount_currency
  end

  def all_transactions
    OpenbillTransaction.by_any_account_id id
  end

  def name
    key.presence || id.to_s
  end

  def url
    meta['url']
  end
end
