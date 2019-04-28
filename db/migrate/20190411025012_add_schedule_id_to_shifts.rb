class AddScheduleIdToShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :schedule_id, :integer
  end
end
