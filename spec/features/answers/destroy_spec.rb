require "rails_helper"

feature "User can destroy answer" do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, body: "Body1", user: author, question: question) }

  context "Author answer" do
    scenario "tried destroy his question" do
      sign_in(author)
      visit question_path(question)

      click_on "Destroy answer"

      expect(page).to_not have_content "Body1"
    end
  end

  context "Non author answer" do
    scenario "tried destroy his question" do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_content "Destroy answer"
    end
  end
end
