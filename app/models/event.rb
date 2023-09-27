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
class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :attendances

  validates :event_date, presence: true
  validates :description, presence: true
  validates :location, presence: true

  scope :past, -> { where('event_date < ?', Time.now) }
  scope :future, -> { where('event_date > ?', Time.now) }
end
