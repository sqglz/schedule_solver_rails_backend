class AddNotesToShiftAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :shift_assignments, :notes, :text
  end
end
