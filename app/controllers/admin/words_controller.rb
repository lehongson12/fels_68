class Admin::WordsController < ApplicationController

  before_filter :find_category

  def index
    @words = @category.words.paginate page: params[:page], per_page: Settings.length.page
  end

  def new
    @word = Word.new
    @word.answers.build
  end

  def create
    @word = @category.words.build words_params
    if @word.save
      flash[:success] = t"word.create.success"
      redirect_to [:admin, :category, :words]
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
  def words_params
    params.require(:word).permit :content, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def find_category
    @category = Category.find params[:category_id]
  end
  
end
