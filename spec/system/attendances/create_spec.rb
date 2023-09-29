# frozen_string_literal: true

# Can we incorporate this?
# subject(:flight_generator) { described_class.new(tomorrow) }

require 'rails_helper'

RSpec.feature 'Create an attendance (invitation)', type: :system do
  context 'User creates an event and clicks "invite people" button from root path' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:multiple_users) { FactoryBot.create_list(:user, 5) }
    let!(:event) { FactoryBot.create(:event, creator: user) } # Unable to get this event to show up in view

    before do
      # driven_by(:rack_test)
      login_as(user, scope: :user)
      create_event_manually
    end

    scenario 'User selects another user to invite from the list' do
      visit root_path
      click_link 'invite people!'
      sleep 4

      within('.content-container') do
        expect(page).to have_content('text content when invite is successful')
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
end
