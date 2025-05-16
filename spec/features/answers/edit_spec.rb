require 'rails_helper'

feature 'User can edit his answer' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit answer'
  end

  describe 'Authenticate user' do
    background do
      sign_in user
      visit question_path(question)
      click_on 'Edit answer'
    end

    # scenario 'edits his answer' do
    #   within '.answers' do
    #     fill_in 'Body', with: 'Edited answer'
    #     click_on 'Save'

    #     expect(page).to_not have_content answer.body
    #     expect(page).to have_content 'Edited answer'
    #     expect(page).to_not have_selector 'textarea'
    #   end

    # end

    scenario "Edit attached file answer" do
      attach_file "File", [ "#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb" ]
      click_on "Save"

      visit question_path(question)

      expect(page).to have_content "rails_helper.rb"
      expect(page).to have_content "spec_helper.rb"
    end
  end
end
