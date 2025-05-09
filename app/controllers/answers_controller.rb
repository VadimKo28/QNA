class AnswersController < ApplicationController
  before_action :find_question, only: :create
  before_action :find_answer, only: %i[update destroy mark_best]
  before_action :authenticate_user!, only: %i[create destroy edit update]

  def create
    @answer = @question.answers.new(answer_params)

    @answer.user = current_user

    @answer.save

    respond_to do |format|
      format.html do
        redirect_to @question
      end

      format.turbo_stream
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer.update(answer_params)

    if @answer.save
      respond_to do |format|
        format.html do
          redirect_to @question
        end

        format.turbo_stream
      end
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    question = @answer.question
    @answer.destroy

    redirect_to question
  end

  def mark_best
    @answer.mark_as_best

    redirect_to @answer.question
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
