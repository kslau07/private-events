class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :attendances

  validates :event_date, presence: true
  validates :description, presence: true
  
  scope :past, -> { where('event_date < ?', Time.now) }
  scope :future, -> { where('event_date > ?', Time.now) }

  # def self.past
  #   where('event_date < ?', Time.now)
  # end

  # def self.future
  #   where('event_date > ?', Time.now)
  # end

end
