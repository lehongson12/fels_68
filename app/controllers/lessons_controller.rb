class LessonsController < ApplicationController
  before_action :init_lesson, only: [:edit,:show, :update]
  before_action :init_category, only: [:create,:show, :update]
  before_action :logged_in_user
  
  def create
    @lesson = Lesson.new category_id: @category.id, user_id: current_user.id
    if @lesson.save
      flash[:success] = t "lesson.create.success"
      redirect_to edit_category_lesson_path(@category, @lesson)
    else
      flash[:danger] = t "lesson.create.fail"
      redirect_to categories_path
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson.update.success"
      redirect_to lesson_results_path(@lesson)
    else
      flash[:danger] = t "lesson.update.fail"
      redirect_to categories_path
    end
  end

  private
  def init_lesson
    @lesson = Lesson.find params[:id]
  end

  def init_category
    @category = Category.find params[:category_id]
  end

  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :word_id, :answer_id]
  end
end
