require 'rails_helper'

feature "User can sign out" do
  given(:user) { create(:user) }

  scenario "Login user tries to sign out" do
    sign_in(user)

    visit destroy_user_session_path

    expect(page).to have_content "Signed out successfully."
  end
end
