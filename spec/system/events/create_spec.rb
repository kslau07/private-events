# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Creating an event', type: :system do
  feature 'foo' do
    before :each do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
    end

    scenario 'foo' do
      visit root_path
      click_link 'add an event'
      fill_in 'event_title', with: 'My awesome event'
      fill_in 'event_location', with: 'clubhouse'
      # HACK: couldn't use normal methods to find date
      find('input[type=date]').send_keys(:arrow_up, :tab, :arrow_up, :tab, :arrow_up)
      fill_in 'event_description', with: 'Expect fun times.'
      click_button 'create event'
      sleep 5
      expect(page).to have_content('foo')
    end
  end
end
