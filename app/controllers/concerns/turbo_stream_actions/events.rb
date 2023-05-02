module TurboStreamActions
  module Events
    def update_events_list_response(event)
      [
        turbo_stream.prepend(:events_list,
                             partial: 'partials/events/card',
                             locals: { event: }),
        turbo_stream.update(:new_event_form, '')
      ]
    end
  end
end
