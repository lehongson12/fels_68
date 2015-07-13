class WordsController < ApplicationController
  def index
    @words = Word.paginate page: params[:page], per_page: Settings.length.page
  end
end
