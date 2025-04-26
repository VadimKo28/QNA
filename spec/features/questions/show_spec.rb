require "rails_helper"

feature "User can show question and answers", %q(
  As an unauthenticated user
  I'd like to be able view question
  I'd like to be able view answer to question
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, title: "Title1", body: "Body1", user: user) }
  given!(:first_answer) { create(:answer, body: "Test first answer", question_id: question.id) }
  given!(:second_answer) { create(:answer, body: "Test second answer", question_id: question.id) }

  describe "Unauthenticate user" do
    background do
      visit question_path(question)
    end

    scenario "can view the question" do
      expect(page).to have_content "#{question.title}"
      expect(page).to have_content "#{question.body}"
    end

    scenario "can view answers the question" do
      expect(page).to have_content "#{first_answer.body}"
      expect(page).to have_content "#{second_answer.body}"
    end
  end
end
