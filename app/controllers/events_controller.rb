class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build

    # @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      respond_to do |format|
        format.html { redirect_to events_path, notice: 'Your event was created successfully!' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      respond_to do |format|
        format.html { redirect_to events_path, notice: 'Your event was updated successfully!' }
        format.turbo_stream
      end

      # redirect_to events_path, notice: 'Your event was updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.destroy(params[:id])

    respond_to do |format|
      format.html { redirect_to events_path, notice: 'Event was successfully removed.' }
      format.turbo_stream
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_date, :description, :creator_id)
  end
end
