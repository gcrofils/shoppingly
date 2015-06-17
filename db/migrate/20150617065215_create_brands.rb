class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :chinese_name
      t.string :logo_uid
      t.string :banner_uid
      t.text :description
      t.integer :established
      t.string :website

      t.timestamps null: false
    end
  end
end
