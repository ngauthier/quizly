class QuestionsController < ApplicationController
  def index
    @questions = Question.
      sort(params[:sort]).
      filter(params[:filter]).
      search(params[:query]).
      page(params[:page])

    if params[:partial]
      render partial: 'results'
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    @question.assign_attributes(question_params)
    if @question.save
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    Question.destroy params[:id]
    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:question, :answer, :distractors)
  end
end
