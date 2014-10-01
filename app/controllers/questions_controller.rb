class QuestionsController < ApplicationController
  def index
    @questions = Question.order(:created_at).page(params[:page])
  end

  def new
    @question = Question.new
  end

  def create
    Question.create!(params.require(:question).permit(:question, :answer, :distractors))
    redirect_to questions_path
  end
end
