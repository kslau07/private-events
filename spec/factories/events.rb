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
  factory :event do
    title { "#{Faker::Restaurant.name} Grand Opening" }
    location { "#{Faker::Address.city}, #{Faker::Address.state}" }
    event_date { Time.zone.now }
    description { 'The much anticipated grand opening of...' }
    creator { FactoryBot.create(:user) }
  end
end
