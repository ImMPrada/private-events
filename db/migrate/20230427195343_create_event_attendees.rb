class CreateEventAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :event_attendees do |t|
      t.references :attendee, references: :users, foreign_key: { to_table: :users }, null: false
      t.references :attended_event, references: :events, foreign_key: { to_table: :events }, null: false

      t.timestamps
    end
  end
end
