# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User log in', type: :system do
  describe 'logging in with valid credentials through the root path' do
    before :each do
      @user = create(:user)
      visit events_path
      click_link 'log in'
    end

    it 'redirects the user to the root path' do
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: 'password123'
      click_button 'Log in'
      expect(page).to have_content('sign out')
    end
  end

  describe 'logging in with an invalid password, error message appears' do
    before :each do
      @user = create(:user)
      visit new_user_session_path
    end

    it "tells user on page 'Invalid Email or password'" do
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: 'wrongpassword'
      click_button 'Log in'
      expect(page).to have_text('Invalid Email or password')
    end
  end
end
