class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image_uid
      t.string :title
      t.integer :image_width
      t.integer :image_height
      t.integer :image_size

      t.timestamps null: false
    end
  end
end
