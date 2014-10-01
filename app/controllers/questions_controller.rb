class QuestionsController < ApplicationController
  def index
    @questions = Question.order(:created_at).page(params[:page])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params.require(:question).permit(:question, :answer, :distractors))
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end
end
