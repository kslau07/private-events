class AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @user = User.find(params[:format]) # why is our user id passed in as format?
    @event.attendees << @user
    redirect_to events_path, notice: 'You joined an event!.'
  end

  def destroy
    @event = Event.find(params[:event_id])
    @event.attendees.delete(current_user)

    redirect_to events_path, notice: 'You unjoined an event.'
  end
end
