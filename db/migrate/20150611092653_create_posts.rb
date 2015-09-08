class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.text :summary
      t.integer :banner_id
      t.references :user, :index => true
      t.timestamps null: false
      t.date :published_at
    end
    
  end
end
