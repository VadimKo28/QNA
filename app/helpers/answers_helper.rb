module AnswersHelper
  def is_author?(resource)
    user_signed_in? && (resource.user_id == current_user.id)
  end
end
