class AddUserinfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_role, :integer, :default => 0
    add_column :users, :username, :string
    add_column :users, :employment_start_date, :datetime
    add_column :users, :worker_responsibilities, :string, array: true
  end
end
