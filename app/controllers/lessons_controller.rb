class LessonsController < ApplicationController
  before_action :init_lesson, only: [:edit, :update]
  before_action :set_category

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

  def set_category
    @category = Category.find params[:category_id]
  end

  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :word_id, :answer_id]
  end
end
