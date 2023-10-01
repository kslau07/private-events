# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  event_date  :date             not null
#  location    :string           not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer          not null
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'is valid with valid attributes' do
    event = @user.events.create(title: 'test', location: 'test', event_date: Time.zone.now, description: 'test')
    expect(event).to be_valid
  end

  it 'is not valid if title is blank' do
    event = @user.events.create(title: '', location: 'test', event_date: Time.zone.now, description: 'test')
    expect(event).not_to be_valid
    expect(event.errors[:title]).to eq ['can\'t be blank']
  end

  it 'is not valid if location is blank' do
    event = @user.events.create(title: 'test', location: '', event_date: Time.zone.now, description: 'test')
    expect(event).not_to be_valid
    expect(event.errors[:location]).to eq ['can\'t be blank']
  end

  it 'is not valid if event_date is blank' do
    event = @user.events.create(title: 'test', location: 'test', event_date: '', description: 'test')
    expect(event).not_to be_valid
    expect(event.errors[:event_date]).to eq ['can\'t be blank']
  end

  it 'is not valid if description is blank' do
    event = @user.events.create(title: 'test', location: 'test', event_date: Time.zone.now, description: '')
    expect(event).not_to be_valid
    expect(event.errors[:description]).to eq ['can\'t be blank']
  end
end
