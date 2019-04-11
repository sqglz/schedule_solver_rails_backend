class AddBusinessIdToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :business_id, :integer
  end
end
