class Attendance < ApplicationRecord
  # Set foreign keys for each 'class_name' class
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'
end
