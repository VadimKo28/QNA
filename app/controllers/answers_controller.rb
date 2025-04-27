class AnswersController < ApplicationController
  before_action :find_question, only: :create
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @answer = @question.answers.new(answer_params)

    @answer.user = current_user

    flash[:error] = @answer.errors.full_messages unless @answer.save

    redirect_to @question
  end

  def destroy
    answer = Answer.find(params[:id])
    question = answer.question
    answer.destroy

    redirect_to question
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
