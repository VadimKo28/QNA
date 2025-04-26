require "rails_helper"

feature "User can create answer to question", %q(
  As an authenticated user
  I'd like to be able to create answer to question
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, title: "Title1", body: "Body1", user: user) }

  describe "Authenticate user" do
    background do
      sign_in(user)
      visit question_path(question)
    end

    context "With valid attributd" do
      scenario "create answer to question" do
        fill_in "Body", with: "Answer1"
        click_on "Create answer"

        expect(page).to have_content "Answer1"
      end
    end

    context "With invalid attributd" do
      scenario "display answer error" do
        click_on "Create answer"

        expect(page).to have_content "Body can't be blank"
      end
    end
  end

  describe "Unauthenticate user" do
    scenario "Unuthenticated user tries create answer to question" do
      visit question_path(question)
      click_on "Create answer"

      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end
end
