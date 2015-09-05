class AddBannerToItineraries < ActiveRecord::Migration
  def change
    add_column :itineraries, :banner_id, :string
  end
end
