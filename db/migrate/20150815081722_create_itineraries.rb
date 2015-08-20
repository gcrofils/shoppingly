class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string :title
      t.text :description
      t.references :user, :index => true, :null => false
      t.timestamps null: false
    end
  end
end
