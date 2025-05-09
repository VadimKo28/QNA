class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = current_user.questions.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      respond_to do |format|
        format.html do
          redirect_to @question, notice: "Your question successfully created."
        end

        format.turbo_stream
      end
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      respond_to do |format|
          format.html do
            redirect_to questions_path
          end

         format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    respond_to do |format|
      format.html do
        redirect_to questions_path
      end

      format.turbo_stream
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
