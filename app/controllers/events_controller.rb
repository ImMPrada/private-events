class EventsController < ApplicationController
  def index
    @events = Event.all.includes(:creator)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      respond_to { |format| update_events_list(format) }
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
      byebug
    end
  end

  def unattend
    @event = event

    if event_to_unattend.destroy
      respond_to { |format| call_card(format) }
    else
      flash[:notice] = 'Event was not unattended.'
    end
  end

  def card
    @event = event
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end

  def event
    @event ||= Event.find(params[:id])
  end

  def update_events_list(format)
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.prepend(:events_list,
                             partial: 'partials/events/card',
                             locals: { event: @event }),
        turbo_stream.update(:new_event_form, '')
      ]
    end
    format.html { redirect_to events_path, notice: 'Event was successfully created.' }
  end

  def event_to_unattend
    EventAttendee.find_by(
      'attendee_id=? AND attended_event_id=?',
      current_user.id,
      @event.id
    )
  end

  def call_card(format)
    format.html { redirect_to card_event_path(@event), notice: 'Event was successfully created.' }
  end
end
