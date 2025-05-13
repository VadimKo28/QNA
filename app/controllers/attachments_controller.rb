class AttachmentsController < ApplicationController
  def destroy
    ActiveStorage::Attachment.find(params[:id]).purge

    question = Question.find(params[:question_id])

    redirect_to question
  end
end
