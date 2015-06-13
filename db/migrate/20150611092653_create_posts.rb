class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :summary
      t.integer :photo_id
      t.integer :user_id
      t.timestamps null: false
      t.datetime :published_at
    end
  end
end
