class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :summary
      t.integer :photo_id
      t.references :user, :index => true
      t.timestamps null: false
      t.date :published_at
    end
    
  end
end
