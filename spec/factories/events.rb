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
FactoryBot.define do
  # sequence :foo do |n|
  #   "foo#{n}"
  # end

  factory :event do
    # Let's have 2 different Event factories:
    # 1) (easier) Associated User object is created by the Event factory itself
    # 2) (after above is achieved) Associated User object is passed in by a test
    title { "#{Faker::Restaurant.name} Grand Opening" }
    location { "#{Faker::Address.city}, #{Faker::Address.state}" }
    event_date { Time.zone.now }
    description { 'The much anticipated grand opening of...' }
    creator { FactoryBot.create(:user) }

    # NOTE: delete me
    #=> ["Creator must exist", "Title can't be blank", "Location can't be blank", "Event date can't be blank", "Description can't be blank"]
  end
end
