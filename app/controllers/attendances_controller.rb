class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    event_to_attendee
    @event.attendees.push(current_user)

    # @event = current_user.created_events.build(event_params)

    # if @event.save
    #   respond_to { |format| update_events_list(format) }
    # else
    #   respond_to do |format|
    #     format.html { render :new, notice: 'Event was not created.' }
    #   end
    # end
  end

  private

  def event_to_attendee
    @event = Event.find(params[:event_id])
  end

  # def event_params
  #   params.require(:event).permit(:title, :description, :start_date, :end_date)
  # end

  # def update_events_list(format)
  #   format.turbo_stream do
  #     render turbo_stream: [
  #       turbo_stream.prepend(:events_list,
  #                            partial: 'partials/events/card',
  #                            locals: { event: @event }),
  #       turbo_stream.update(:new_event_form, '')
  #     ]
  #   end
  #   format.html { redirect_to events_path, notice: 'Event was successfully created.' }
  # end
end
