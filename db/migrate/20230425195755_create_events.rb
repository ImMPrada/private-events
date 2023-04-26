class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.references :creator, references: :users, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
