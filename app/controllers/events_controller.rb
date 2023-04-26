class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.creator = current_user

    byebug

    if event.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end
end
