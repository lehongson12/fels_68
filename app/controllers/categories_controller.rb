class CategoriesController < ApplicationController
  before_action :logged_in_user
  def index
    @categories = Category.paginate(page: params[:page], per_page: Settings.length.page).order :name   
  end

  def show
    @category = Category.find params[:id]
    @words = Word.filter_category(params[:category_id]).paginate page: params[:page], per_page: Settings.length.page
  end

end
