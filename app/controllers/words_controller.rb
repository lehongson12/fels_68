class WordsController < ApplicationController
  
  def index
    @categories = Category.all
    @words = if params[:search].present? || params[:filter_state].present?
      Word.filter_category(params[:category_id]).search(params[:search])
      .paginate(page: params[:page], per_page: Settings.length.page)
      .send params[:filter_state], current_user
    else
      Word.paginate page: params[:page], per_page: Settings.length.page
    end
  end
end
