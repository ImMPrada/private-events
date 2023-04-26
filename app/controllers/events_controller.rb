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

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
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
end
