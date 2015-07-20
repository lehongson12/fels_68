class ResultsController < ApplicationController
  def index
    @lesson = Lesson.find params[:lesson_id]
  end
end
