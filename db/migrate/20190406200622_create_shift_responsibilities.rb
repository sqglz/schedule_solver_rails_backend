class CreateShiftResponsibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :shift_responsibilities do |t|
      t.references :shift, foreign_key: true
      t.references :responsibility, foreign_key: true
      t.boolean :assigned
      t.integer :user_id

      t.timestamps
    end
  end
end
