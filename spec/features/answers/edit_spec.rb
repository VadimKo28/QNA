require 'rails_helper'

feature 'User can edit his answer' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticate user' do
    scenario 'edits his answer' do
      sign_in user
      visit question_path(question)

      click_on 'Edit'

      # expect(page).to have_css('.answers')
      # within '.answers' do
      #   fill_in 'Body', with: 'Edited answer'
      #   click_on 'Save'

      #   expect(page).to_not have_content answer.body
      #   expect(page).to have_content 'Edited answer'
      #   expect(page).to_not have_selector 'textarea'
      # end

    end
  end
end
