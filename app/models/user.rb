class User < ApplicationRecord

  # fix this example rails.md             delete me

  has_many :events, foreign_key: :creator_id

  has_many :event_attendings, foreign_key: :attendee_id
  has_many :attended_events, through: :event_attendings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

<<~NOTES

  We will create a has_many :through association

  3 models:

    event (same name)
    attendee (class_name: User)
    attended_event (new model)




NOTES
