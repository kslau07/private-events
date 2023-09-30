require 'rails_helper'

RSpec.feature 'Creating a user', type: :system do
  feature 'Signing up with valid inputs through the root path' do
    before do
      visit events_path
      click_link 'sign up'
    end

    scenario 'redirects the user back to the root path after sign up' do
      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'password123'
      click_button 'Sign up'
      expect(page).to have_content('sign out')
    end
  end

  feature 'Signing up with incorrect inputs through the root path' do
    before do
      visit events_path
      click_link 'sign up'
    end

    scenario 'shows the user an error message when signing up with a short password' do
      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_password', with: 'abc'
      click_button 'Sign up'
      expect(page).to have_content('Password is too short')
    end
  end
end
