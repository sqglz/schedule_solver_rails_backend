class AddNameToShiftAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :shift_assignments, :name, :string, :default => nil
  end
end
