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

      it 'redirects to the created Event' do
        post events_url, params: { event: valid_attributes }
        expect(response).to redirect_to(events_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Event' do
        expect do
          post events_url, params: { event: invalid_attributes }
        end.to change(Event, :count).by(0)
      end

      it 'returns a status 422 (the posted data is invalid)' do
        post events_url, params: { event: invalid_attributes }
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PATCH /update' do
    include_context :devise_login do
      let(:passed_in_user) { test_user }
    end

    context 'with valid parameters' do
      let!(:event) { Event.create! valid_attributes }
      let!(:new_valid_attributes) { { title: 'My New Title' } }

      before do
        patch event_url(event), params: { event: new_valid_attributes }
        event.reload
      end

      it 'updates the requested Event' do
        expect(event.title).to eq 'My New Title'
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(events_url)
      end
    end

    context 'with invalid parameters' do
      let!(:event) { Event.create! valid_attributes }
      let!(:new_invalid_attributes) { { title: '' } }

      before do
        patch event_url(event), params: { event: new_invalid_attributes }
        event.reload
      end

      it 'returns an "unprocessable entity" response' do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'DELETE /destroy' do
    include_context :devise_login do
      let(:passed_in_user) { test_user }
    end

    it 'destroys the requested Event' do
      event = Event.create! valid_attributes
      expect do
        delete event_url(event)
      end.to change(Event, :count).by(-1)
    end

    it 'redirects to events_url' do
      event = Event.create! valid_attributes
      delete event_url(event)
      expect(response).to redirect_to(events_url)
    end
  end
end
