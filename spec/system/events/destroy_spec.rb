# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Destroy an event', type: :system do
  feature 'User clicks on foo' do
    let!(:user) { FactoryBot.create(:user) }

    before do
      login_as(user, scope: :user)
    end

    scenario 'Clicking on delete event decreases Event.count by one' do
      create_event_manually
      expect(page).to have_css('.event-compact', wait: 5)
      expect do
        first('#delete-event').click
        expect(page).not_to have_css('.event-compact', wait: 5)
      end.to change(user.events, :count).by(-1)
    end
  end

  def create_event_manually
    visit root_path
    click_link 'add an event'
    fill_in 'event_title', with: 'Manual\'s Event Title'
    fill_in 'event_location', with: 'Place'
    fill_in 'event_event_date', with: '09/09/2023'
    fill_in 'event_description', with: 'Descriptive sentence'
    click_button 'create event'
  end
end
