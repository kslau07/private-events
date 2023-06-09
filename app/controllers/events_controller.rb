class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new                # For turbo-frames

    #@current_user = User.find(current_user.id)
    #@event = @current_user.events.build
  end

  def create
    @current_user = User.find(current_user.id)          # or just = current_user
    @event = @current_user.events.create(event_params)

    if @event.save
      # redirect_to events_path, notice: 'Your event was created sucessfully!'
      respond_to do |format|
        format.html { redirect_to events_path, notice: 'Your event was created sucessfully!' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.destroy(params[:id])
    # @event.destroy

    respond_to do |format|
      format.html { redirect_to events_path, notice: 'Event was successfully removed.' }
      format.turbo_stream
    end
  end

  private
  
  def event_params
    params.require(:event).permit(:event_date, :description)
  end
end
