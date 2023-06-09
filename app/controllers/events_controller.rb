class EventsController < ApplicationController
  include TurboStreamActions::Events

  before_action :authenticate_user!, except: %i[index]

  def show
    @event = event
    @attendees = @event.attendees.order(created_at: :desc)
  end

  def index
    @events = Event.all.includes(:creator)
    @future_events = @events.active
    @past_events = @events.expired
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      respond_to { |format| update_events_list(format, @event) }
    else
      render :new, notice: 'Event was not created.'
    end
  end

  def destroy
    return redirect_to(event_path(event), alert: 'Event was not deleted.') unless event.creator == current_user

    if event.destroy
      redirect_to(events_path, notice: 'Event was deleted.')
    else
      render(:show, alert: 'Event was not deleted.')
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end

  def event
    Event.find(params[:id])
  end
end
