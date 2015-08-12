class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :chinese_name
      t.string :logo_uid
      t.integer :logo_width
      t.integer :logo_height
      t.integer :logo_size
      t.string :banner_uid
      t.integer :banner_width
      t.integer :banner_height
      t.integer :banner_size
      t.string :marker_uid
      t.integer :marker_width
      t.integer :marker_height
      t.integer :marker_size
      t.text :summary
      t.text :description
      t.integer :established
      t.string :website
      t.timestamps null: false
    end
  end
end
