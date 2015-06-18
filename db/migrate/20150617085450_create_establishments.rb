class CreateEstablishments < ActiveRecord::Migration
  def change
    create_table :establishments do |t|
      t.string :label
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :brand_id
      t.string :establishment_type
      t.string :picture_uid
      t.string :static_map_uid
      t.timestamps null: false
    end
  end
end

