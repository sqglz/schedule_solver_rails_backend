class CreateShiftPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :shift_preferences do |t|
      t.references :shift, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :answer

      t.timestamps
    end
  end
end
