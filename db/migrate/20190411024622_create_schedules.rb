class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :owner_id
      t.boolean :default, default: false

      t.timestamps
    end
  end
end
