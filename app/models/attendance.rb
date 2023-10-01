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
class Attendance < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'
  validates :attendee_id, uniqueness: { scope: :attended_event_id,
                                        message: 'Attendee and Event combination should be unique.' }
end
