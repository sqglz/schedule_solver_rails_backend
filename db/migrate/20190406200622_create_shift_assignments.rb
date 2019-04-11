class CreateShiftAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :shift_assignments do |t|
      t.references :shift, foreign_key: true
      t.references :assignment, foreign_key: true
      t.boolean :assigned
      t.integer :user_id

      t.timestamps
    end
  end
end
