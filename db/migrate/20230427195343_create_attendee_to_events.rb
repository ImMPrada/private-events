class CreateAttendeeToEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :attendee_to_events do |t|
      t.references :attendee, references: :users, foreign_key: { to_table: :users }, null: false
      t.references :attended_event, references: :events, foreign_key: { to_table: :events }, null: false

      t.timestamps
    end
  end
end
