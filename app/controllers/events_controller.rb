class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.json { render json: @events, status: :ok }
    end
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @event, status: :ok }
    end
  end

  def new
    @event = current_user.events.build
  end

  def edit
    @event = Event.find(params[:id])
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

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      respond_to do |format|
        format.html { redirect_to events_path, notice: 'Your event was updated successfully!' }
        format.turbo_stream
      end
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
    params.require(:event).permit(:event_date, :title, :location, :description, :creator_id)
  end
end
