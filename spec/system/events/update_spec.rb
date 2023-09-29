# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Updating an event', type: :system do
  feature 'User updates an existing event by changing input fields' do
    before :each do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
    end

    scenario 'Event has a new title after updating record' do
      event = FactoryBot.create(:event)
      visit edit_event_path(event)
      fill_in 'event_title', with: 'My New Title'
      click_button 'update event'
      expect(page).to have_css('.event-compact__title', wait: 5)
      event.reload
      expect(event.title).to eq 'My New Title'
    end

    scenario 'Event has a new date after updating record' do
      event = FactoryBot.create(:event)
      visit edit_event_path(event)
      fill_in 'event_event_date', with: '06/06/2024'
      click_button 'update event'
      expect(page).to have_css('.event-compact__date', wait: 5)
      event.reload
      expect(event.event_date.strftime('%d/%m/%Y')).to eq '06/06/2024'
      #                                     *or use*      Date.new(2024, 6, 6)
    end
  end
end
