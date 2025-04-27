require "rails_helper"

feature "User can destroy question" do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, title: "Title1", body: "Body1", user: author) }

  context "Author question" do
    scenario "tried destroy his question" do
      sign_in(author)
      visit question_path(question)

      click_on "Destroy question"

      expect(page).to_not have_content "Title1"
    end
  end

  context "Non author question" do
    scenario "tried destroy his question" do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_content "Destroy question"
    end
  end
end
