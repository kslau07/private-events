class EventsController < ApplicationController
  # before_action :authenticate_user!

  # bar = foo.build_bar  # (has_one or belongs_to)
  # bar = foo.bars.build # (has_many, habtm or has_many :through)
  def new
    @event = Event.new
  end

  def create
    @user = User.find(current_user.id)
    
    # We need the user object here, not use the id
    @event = @user.build_event(event_params)
    redirect_to event_path(@event)
  end

  private
  def event_params
    params.require(:event).permit(:description, :event_date)
  end
end
