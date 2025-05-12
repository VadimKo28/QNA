class AttachmentsController < ApplicationController
  def destroy
    ActiveStorage::Blob.find(params[:id]).delete
    ActiveStorage::Attachment.find(params[:id]).delete

    question = Question.find(params[:question_id])

    redirect_to question
  end
end
