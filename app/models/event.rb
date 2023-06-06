class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  
  validates :event_date, presence: true
  validates :description, presence: true
end
