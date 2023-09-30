require 'rails_helper'

describe Event, type: :model do
  it 'is valid if title and description fields have value', skip: true do
    expect do
      event = Event.new(title: 'test', description: 'test')
      event.save
    end.to change { Event.count }.by(1)
  end
end
