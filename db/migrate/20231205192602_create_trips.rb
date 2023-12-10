class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :destination
      t.text :description
      t.date :date_debut
      t.date :date_fin

      t.timestamps
    end
  end
end
