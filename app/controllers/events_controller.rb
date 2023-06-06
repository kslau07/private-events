class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def new
    @current_user = User.find(current_user.id)
    @event = @current_user.events.build

    # @event = Event.new
  end

  def create
    @current_user = User.find(current_user.id)
    # @current_user = current_user                      # convenience method
    @event = @current_user.events.create(event_params)

    if @event.save
      redirect_to events_path, notice: 'Your event was created sucessfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_date, :description)
  end
end
