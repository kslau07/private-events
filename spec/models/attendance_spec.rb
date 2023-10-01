# == Schema Information
#
# Table name: attendances
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  attended_event_id :integer          not null
#  attendee_id       :integer          not null
#
# Indexes
#
#  index_attendances_on_attendee_id_and_attended_event_id  (attendee_id,attended_event_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event)
  end

  it 'is valid when both attendee and attended_event (Event) are unique' do
    attendance = Attendance.new(attendee_id: @user.id, attended_event_id: @event.id)
    expect(attendance).to be_valid
  end

  it 'is not valid when attendee has already been invited' do
    Attendance.create(attendee_id: @user.id, attended_event_id: @event.id)
    attendance = Attendance.new(attendee_id: @user.id, attended_event_id: @event.id)
    expect(attendance).not_to be_valid
    expect(attendance.errors[:attendee_id]).to eq ['Attendee and Event combination should be unique.']
  end
end
