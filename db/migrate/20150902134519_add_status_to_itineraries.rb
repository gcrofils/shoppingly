class AddStatusToItineraries < ActiveRecord::Migration
  def change
    add_column :itineraries, :status, :string
  end
end
