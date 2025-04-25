class AnswersController < ApplicationController
  before_action :find_question, only: :create
  before_action :authenticate_user!, only: :create

  def create
    answer = @question.answers.new(answer_params)

    if answer.save
      redirect_to @question
    else
      # тут получился костыль, т.к. приходится рендерить шаблон другого контроллера
      # плюс приходится в этот шаблон передавать question и answer, пока не придумал как по другому написать
      render "questions/show",  locals: { question: @question, answer: answer }, status: :unprocessable_entity
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
