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
      fill_in 'event_title', with: 'My Awesome Event'
      fill_in 'event_location', with: 'Clubhouse'
      fill_in 'event_event_date', with: '06/06/2023'
      fill_in 'event_description', with: 'Expect fun times at the clubhouse'

      expect do
        click_button 'create event'
        expect(page).to have_css('.event-compact__title', wait: 5)
      end.to change(Event, :count).to be 1
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
      fill_in 'event_location', with: 'Bob\'s House'
      fill_in 'event_event_date', with: '06/06/2023'
      fill_in 'event_description', with: 'Bob is hosting a thing at his house'
      click_button 'create event'
      expect(page).to have_text('Title can\'t be blank')
    end

    scenario 'When date is left blank user receives warning about blank date' do
      visit root_path
      click_link 'add an event'
      fill_in 'event_title', with: 'Joe\'s Backyard BBQ'
      fill_in 'event_location', with: 'Joe\'s backyard'
      # Do not fill out date
      fill_in 'event_description', with: 'Joe\'s having a bbq in his backyard'
      click_button 'create event'
      expect(page).to have_text('Event date can\'t be blank')
    end
  end
end
