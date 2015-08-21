class Post < ActiveRecord::Base
  
  belongs_to :photo
  belongs_to :user
  has_and_belongs_to_many :brands
  has_one :pin, as: :pinnable
  
  # thumbs_up
  acts_as_voteable
  
  def self.find_all_by_brands(brands=[])
    if brands.first.is_a? (Brand)
      Post.includes(:brands).where('brands.id' => brands.collect{|b| b.id})
    else
      Post.includes(:brands).where('brands.id' => brands)
    end
  end
  
  def embedded_body
    body.gsub(/\{\{photo:([0-9]+)\}\}/x) do |match|
      if photo = Photo.find_by_id($1)
        url = photo.image.thumb('600x300').url
        alt = photo.title
      else
        url = "http://placehold.it/600x300"
        alt = "image not found"
      end
      "<center>#{ActionController::Base.helpers.image_tag url, alt: alt, class: 'img-responsive img-thumbnail'}</center>"
    end
  end 
  
  # initial data migration
  def download_images
    begin
      # featured_photo
      self.body = body.gsub(/\$\$([a-zA-Z0-9\/\.\&\:\=\?\_]*)\$\$/x) do |match| 
        image = Dragonfly.app.fetch_url($1)
        photo = Photo.new(image: image, title: "#{title.truncate(20, omission: '...')} featured image")
        photo.save
        self.photo_id = photo.id
        ""
      end
      
      self.body = body.gsub(/\{\{([a-zA-Z0-9\/\.\&\:\=\?\_]*)\}\}/x) do |match| 
        image = Dragonfly.app.fetch_url($1)
        #photo = Photo.new(image: image, title: title.truncate(20, omission: '...'))
        photo = Ckeditor::Asset.new(data: image, assetable_type: 'User', assetable_id: user.id, type: "Ckeditor::Picture")
        #photo.data_type = 
        photo.data_name = title.truncate(15, omission: '...')
        photo.save
        ActionController::Base.helpers.image_tag(photo.data.url, class:'img-responsive img-thumbnail', alt: "#{title.truncate(25, omission: '...')}")
      end
      
      self.save
    rescue Exception => e
      puts "#{title} has not been updated"
      puts e.message
    end
  end

end
