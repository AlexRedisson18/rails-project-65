# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :find_category, only: %i[edit update destroy]

  def index
    @categories = Category.order(name: :desc)
  end

  def new
    @category = Category.build
  end

  def edit; end

  def create
    @category = Category.build(category_params)

    if @category.save
      flash[:notice] = t('admin.categories.create.flash.notice')
      redirect_to admin_categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = t('admin.categories.update.flash.notice')
      redirect_to admin_categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = t('admin.categories.destroy.flash.notice')
      redirect_to admin_categories_path
    else
      render :edit, status: :unprocessable_entity, notice: t('admin.categories.destroy.flash.alert')
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
