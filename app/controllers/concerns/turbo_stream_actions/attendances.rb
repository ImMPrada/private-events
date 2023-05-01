module TurboStreamActions
  module Attendances
    def new_attendee_response(event, attendee)
      [
        add_attendee_to_list(event, attendee),
        update_attendance_buttons(event)
      ]
    end

    def remove_attendee_response(event, attendee)
      [
        remove_attendee_from_list(attendee),
        update_attendance_buttons(event)
      ]
    end

    private

    def add_attendee_to_list(event, attendee)
      turbo_stream.prepend(
        "event_#{event.id}_attendees".to_sym,
        partial: 'partials/attendees/card',
        locals: { attendee: }
      )
    end

    def update_attendance_buttons(event)
      turbo_stream.update(
        "event_#{event.id}_attendance_buttons".to_sym,
        partial: 'partials/buttons/attendance_buttons',
        locals: { event: }
      )
    end

    def remove_attendee_from_list(attendee)
      turbo_stream.remove("user_#{attendee.id}_attendee_card".to_sym)
    end
  end
end
