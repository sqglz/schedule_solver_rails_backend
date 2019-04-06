class CreateBusinessUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :business_users do |t|
      t.references :business, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
