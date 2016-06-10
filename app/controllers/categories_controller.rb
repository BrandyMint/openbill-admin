class CategoriesController < ApplicationController
  def index
    render locals: { categories: categories }
  end

  def new
    render locals: { category: CategoryForm.new }
  end

  def show
    redirect_to accounts_path(philtre: { category_id: params[:id] })
  end

  def edit
    category_form = CategoryForm.new category
    render :edit, locals: { category: category_form }
  end

  def create
    category_form = CategoryForm.new permitted_params

    if category_form.valid?
      categories.insert category_form.to_hash
      redirect_to categories_path
    else
      render :new, locals: { category: category_form }
    end

  rescue => err
    flash.now[:error] = err.message
    render :new, locals: { category: category_form }
  end

  def update
    category_form = CategoryForm.new({ **permitted_params.symbolize_keys, id: category.id })

    if category_form.valid?
      category.update category_form.to_hash
      redirect_to categories_path
    else
      render :edit, locals: { category: category_form }
    end

  rescue => err
    flash.now[:error] = err.message
    render :edit, locals: { category: category_form }
  end

  def destroy
    category.delete
    redirect_to :back
  rescue => err
    redirect_to :back, flash: { error: err.message }
  end

  private

  def category
    categories.first! id: params[:id]
  end

  def permitted_params
    params.require(:category).permit(:name, :parent_id)
  end

  def categories
    @_categories ||= Openbill.service.categories
  end
end
