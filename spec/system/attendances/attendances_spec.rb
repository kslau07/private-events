# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Create an attendance (invitation)' do
  before do
    visit '/'          # NOTE: delete me
  end

  context 'change me' do
    # NOTE: delete me -> let is available in top context, or in 'context' blocks
    # NOTE: delete me -> 'before' blocks are available in top context, or in 'context' blocks
    # NOTE: delete me -> let and before are the same in that regard
    # Use this example in our testing
    # within(".content-container") do
    #   expect(page).to have_content("Example Name")
    # end
    # Can we incorporate this?
    # subject(:flight_generator) { described_class.new(tomorrow) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event, creator: user) }

    before do
      visit '/'
    end

    # Create attendance
    scenario 'pass in collaborator to factorybot' do
      expect(event).to eq 1
    end
  end
end
