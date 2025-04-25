require "rails_helper"

feature "User can show question list", %q(
  As an unauthenticated user
  I'd like to be able to view question list
) do
  given!(:question_first) { create(:question, title: 'Title1', body: 'Body1') }
  given!(:question_second) { create(:question, title: 'Title2', body: 'Body2') }


  describe "Unauthenticate user" do
    scenario "can view the list of questions" do
      visit questions_path

      expect(page).to have_content "All questions"
      expect(page).to have_content "#{question_first.title}"
      expect(page).to have_content "#{question_second.title}"
      expect(page).to have_content "#{question_first.body}"
      expect(page).to have_content "#{question_second.body}"
    end
  end
end
