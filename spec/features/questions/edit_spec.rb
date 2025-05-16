require "rails_helper"

feature "User can edit his answer attaged files" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario "Edit question  with attached files" do
    sign_in user
    visit questions_path

    click_on 'Edit'

    attach_file "File", [ "#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb" ]
    click_on "Save"

    visit question_path(question)

    expect(page).to have_content "rails_helper.rb"
    expect(page).to have_content "spec_helper.rb"
  end
end
