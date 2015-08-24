class CreateEstablishments < ActiveRecord::Migration
  def change
    create_table :establishments do |t|
      t.string :label
      t.string :slug
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :brand_id
      t.string :establishment_type
      t.string :picture_uid
      t.integer :picture_width
      t.integer :picture_height
      t.integer :picture_size
      t.string :static_map_uid
      t.integer :static_map_width
      t.integer :static_map_height
      t.integer :static_map_size
      t.timestamps null: false
    end
    add_index :establishments, :slug, unique: true
  end
end

