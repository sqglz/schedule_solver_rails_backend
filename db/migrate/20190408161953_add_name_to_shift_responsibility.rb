class AddNameToShiftResponsibility < ActiveRecord::Migration[5.2]
  def change
    add_column :shift_responsibilities, :name, :string, :default => nil
  end
end
