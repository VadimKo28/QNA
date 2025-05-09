class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  scope :sort_by_best, -> { order(by_best: :desc) }

  def mark_as_best
    transaction do
      self.class.where(question_id: self.question_id).update_all(by_best: false)
      self.update_columns(by_best: true)
    end
  end
end
