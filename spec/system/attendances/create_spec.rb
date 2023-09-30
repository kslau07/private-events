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
      visit root_path
      click_link 'invite people!'
    end

    scenario 'User navigates to "invite people" page and sees "send invite" buttons' do
      within('.invite') do
        expect(page).to have_content('invite people!')
        expect(page).to have_content('send invite')
      end
    end

    scenario 'User clicks "send invite" button and attendance count goes up by 1' do
      expect do
        click_button('send invite', match: :first)
      end.to change(Attendance, :count).by(1)
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
