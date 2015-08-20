class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.references :itinerary
      t.references :establishment
      t.integer :position
      t.text :description

      t.timestamps null: false
    end
    
    # http://stackoverflow.com/questions/15210639/need-two-indexes-on-a-habtm-join-table
    add_index :stops, [:establishment_id, :itinerary_id], :unique => true, :name => "idx_establishments_itineraries_uniq"
    add_index :stops, :itinerary_id
    
  end
end
