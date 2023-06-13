class AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @event.attendees << current_user
  end
end
