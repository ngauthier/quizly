class QuestionsController < ApplicationController
  def index
    @questions = Question.order(:created_at).page(params[:page])
  end
end
