class AttendancesController < ApplicationController
  include TurboStreamActions::Attendances

  before_action :authenticate_user!

  def create
    event_attendee = current_user.event_attendees.build(attended_event: event)

    if event_attendee.save
      render turbo_stream: new_attendee_response(event, current_user)
    else
      flash[:alert] = 'Event was not attended.'
      redirect_to event_path(event)
    end
  end

  def destroy
    if event_attendee.destroy
      render turbo_stream: remove_attendee_response(event, current_user)
    else
      flash[:alert] = 'Event was not attended.'
      redirect_to event_path(event)
    end
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end

  def event_attendee
    @event_attendee ||= EventAttendee.find_by(attendee: current_user, attended_event_id: params[:event_id])
  end

  def event_attendee_params
    { attendee: current_user, attended_event: event }
  end
end
