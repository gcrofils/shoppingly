class CreateBrandsPosts < ActiveRecord::Migration
  def change
    create_table :brands_posts, :id => false do |t|
      t.references :brand
      t.references :post
    end
    
    # http://stackoverflow.com/questions/15210639/need-two-indexes-on-a-habtm-join-table
    add_index :brands_posts, [:brand_id, :post_id], :unique => true
    add_index :brands_posts, :post_id
    
  end
end
