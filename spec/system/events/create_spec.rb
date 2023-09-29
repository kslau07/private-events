# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Creating an event', type: :system do
  feature 'User creates an event with valid inputs' do
    before :each do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
    end

    scenario 'Event.count goes up by one after event is created' do
      visit root_path
      click_link 'add an event'
      fill_in 'event_title', with: 'My awesome event'
      fill_in 'event_location', with: 'clubhouse'
      # HACK: couldn't use normal methods to find date
      find('input[type=date]').send_keys(:arrow_up, :tab, :arrow_up, :tab, :arrow_up)
      fill_in 'event_description', with: 'Expect fun times.'
      initial_count = Event.count
      click_button 'create event'
      sleep 1 # HACK: test fails otherwise
      final_count = Event.count
      difference = 1
      expect(final_count - initial_count).to eq(difference)
    end
  end

  feature 'User fills out event form incompletely and generates errors' do
    before :each do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
    end

    scenario 'When title is left blank user receives warning about blank title' do
      visit root_path
      click_link 'add an event'
      fill_in 'event_title', with: ''
      fill_in 'event_location', with: 'Bob\'s house'
      find('input[type=date]').send_keys(:arrow_up, :tab, :arrow_up, :tab, :arrow_up)
      fill_in 'event_description', with: 'This will be a cool event because...'
      click_button 'create event'
      expect(page).to have_text('Title can\'t be blank')
    end

    scenario 'When date is left blank user receives warning about blank date' do
      visit root_path
      click_link 'add an event'
      fill_in 'event_title', with: 'Another rad event'
      fill_in 'event_location', with: 'Joe\'s backyard'
      # Do not fill out date
      fill_in 'event_description', with: 'Joe\'s having a bbq'
      click_button 'create event'
      expect(page).to have_text('Event date can\'t be blank')
    end
  end
end
