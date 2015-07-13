class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.length.page 
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.create.success"
      redirect_to [:admin, :categories]
    else
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update category_params
      flash[:success] = t "category.update.success"
      redirect_to [:admin, :categories]
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy
      flash[:success] = t "category.delete"
      redirect_to [:admin, :categories]
    else
      flash[:danger] = t "category.delete_error"
      redirect_to [:admin, :categories]
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :picture
  end
end
