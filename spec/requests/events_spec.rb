# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/events', type: :request do
  let(:test_user) { create(:user) }

  let(:valid_attributes) do
    { creator: test_user,
      title: "#{Faker::DcComics.hero} vs. #{Faker::DcComics.villain} movie screening",
      location: Faker::Address.full_address,
      event_date: Faker::Date.between(from: Time.zone.today, to: Time.zone.today + 60.days),
      description: 'An early screening of the 8th installment of this epic DC series' }
  end

  let(:invalid_attributes) do
    { title: '',
      location: '',
      event_date: '',
      description: '' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Event.create! valid_attributes
      get events_url
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /show' do
    include_context :devise_login do
      let(:passed_in_user) { test_user }
    end

    it 'renders a successful response' do
      event = Event.create! valid_attributes
      get event_url(event)
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /new' do
    include_context :devise_login do
      let(:passed_in_user) { test_user }
    end

    it 'renders a successful response' do
      get new_event_url
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /edit' do
    include_context :devise_login do
      let(:passed_in_user) { test_user }
    end

    it 'renders a successful response' do
      event = Event.create! valid_attributes
      get edit_event_url(event)
      expect(response).to have_http_status :ok
    end
  end

  describe 'POST /create' do
    include_context :devise_login do
      let(:passed_in_user) { test_user }
    end

    context 'with valid parameters' do
      it 'creates a new Event' do
        expect do
          post events_url, params: { event: valid_attributes }
        end.to change(Event, :count).by(1)
      end
    end
  end
end
