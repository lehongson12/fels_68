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
      flash[:success] = t"category.create.success"
      redirect_to [:admin, :categories]
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private
  def category_params
    params.require(:category).permit :name, :picture
  end
end
