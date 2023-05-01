module Utils
  module TurboStreamAttendances
    module TurboStreamActions
      private

      def add_attendee_to_this_event(format, event)
        format.turbo_stream do
          render turbo_stream: [
            add_attendee_to_list(turbo_stream, event, current_user),
            update_attendance_buttons(turbo_stream, event)
          ]
        end
        format.html { redirect_to event_path(event), nothing: '' }
      end

      def remove_attendee_from_this_event(format, event)
        format.turbo_stream do
          render turbo_stream: [
            remove_attendee_from_list(turbo_stream, current_user),
            update_attendance_buttons(turbo_stream, event)
          ]
        end
        format.html { redirect_to event_path(event), nothing: '' }
      end

      def add_attendee_to_list(turbo_stream, event, attendee)
        turbo_stream.prepend(
          "event_#{event.id}_attendees".to_sym,
          partial: 'partials/attendees/card',
          locals: { attendee: }
        )
      end

      def update_attendance_buttons(turbo_stream, event)
        turbo_stream.update(
          "event_#{event.id}_attendance_buttons".to_sym,
          partial: 'partials/buttons/attendance_buttons',
          locals: { event: }
        )
      end

      def remove_attendee_from_list(turbo_stream, attendee)
        turbo_stream.remove("user_#{attendee.id}_attendee_card".to_sym)
      end
    end
  end
end
