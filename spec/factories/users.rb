# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  #  NOTE: delete me
  # sequence :email do |n|
  #   "user#{n}@example.com"
  # end

  factory :user do
    email { Faker::Internet.email }
    # email { generate(:email) }
    password { 'password123' }
  end
end


# FactoryBot.define do
#   sequence :email do |n|
#     "user#{n}@example.com"
#   end
#
#   factory :user do
#     email { generate(:email) }
#     password { 'password123' }
#   end
#
#   trait :faker do
#     email { Faker::Internet.email }
#   end
# end