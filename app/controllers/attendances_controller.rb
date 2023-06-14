class AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @event.attendees << current_user

    redirect_to events_path, notice: 'You joined an event!.'
  end

  def destroy
    @event = Event.find(params[:event_id])
    @event.attendees.delete(current_user)

    redirect_to events_path, notice: 'You unjoined an event.'
  end
end
