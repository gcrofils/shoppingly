class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string :title
      t.references :user, :index => true
      t.timestamps null: false
    end
  end
end
