class EventsController < ApplicationController
  include Utils::TurboStreamAttendances::TurboStreamActions
  include Utils::TurboStreamEvents::TurboStreamActions

  before_action :authenticate_user!, except: %i[index]

  def show
    @event = event
    @attendees = @event.attendees.order!('created_at DESC')
  end

  def index
    @events = Event.all.includes(:creator)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      respond_to { |format| update_events_list(format, @event) }
    else
      respond_to do |format|
        format.html { render :new, notice: 'Event was not created.' }
      end
    end
  end

  def attend
    event_to_attend = EventAttendee.new
    event_to_attend.attendee = current_user
    event_to_attend.attended_event = event

    if event_to_attend.save
      respond_to { |format| add_attendee_to_this_event(format, @event) }
    else
      flash[:notice] = 'Event was not attended.'
      render :show
    end
  end

  def unattend
    @event = event

    if event_to_unattend.destroy
      respond_to { |format| remove_attendee_from_this_event(format, @event) }
    else
      flash[:notice] = 'Event was not unattended.'
      render :show
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end

  def event
    Event.find(params[:id])
  end

  def event_to_unattend
    EventAttendee.find_by(
      'attendee_id=? AND attended_event_id=?',
      current_user.id,
      @event.id
    )
  end
end
