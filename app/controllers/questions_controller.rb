class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
  end

  def create
    @question = Question.new(questions_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if question.update(questions_params)
      redirect_to question
    else
      render :edit
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path
  end

  private

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  helper_method :question

  def questions_params
    params.require(:question).permit(:title, :body)
  end
end
