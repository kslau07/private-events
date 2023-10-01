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
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(email: 'test@example.com', password: 'password123')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: '', password: 'password123')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to eq ['can\'t be blank']
    end

    it 'is not valid if email is not unique' do
      User.create(email: 'test@example.com', password: 'password123')
      user = User.new(email: 'test@example.com', password: 'password123')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to eq ['has already been taken']
    end

    it 'is not valid if password is blank' do
      user = User.create(email: 'test@example.com', password: '')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to eq ['can\'t be blank']
    end

    it 'is not valid if password is less than 6 characters long' do
      user = User.create(email: 'test@example.com', password: '12345')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to eq ["is too short (minimum is 6 characters)"]
    end
  end
end
