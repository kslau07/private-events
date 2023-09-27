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
end
