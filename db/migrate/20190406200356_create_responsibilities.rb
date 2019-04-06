class CreateResponsibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :responsibilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
