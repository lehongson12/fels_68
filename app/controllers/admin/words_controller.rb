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
    @word = Word.find params[:id]
  end

  def update
    @word = Word.find params[:id]
    if @word.update_attributes words_params
      flash[:success] = t "word.update.success"
      redirect_to [:admin, :category, :words]
    else
      flash[:danger] = t "word.update.error"
      render :edit
    end
  end

  def destroy
    @word = Word.find params[:id]
    if @word.destroy
      flash[:success] = t "word.delete.success"
      redirect_to [:admin, :category, :words]
    else
      flash[:danger] = t "word.delete.error"
      redirect_to [:admin, :category, :words]
    end
  end

  private
  def words_params
    params.require(:word).permit :content, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def find_category
    @category = Category.find params[:category_id]
  end
  
end
