module Utils
  module TurboStreamEvents
    module TurboStreamActions
      private

      def update_events_list(format, event)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(:events_list,
                                 partial: 'partials/events/card',
                                 locals: { event: }),
            turbo_stream.update(:new_event_form, '')
          ]
        end
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
      end
    end
  end
end
