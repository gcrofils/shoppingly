class Post < ActiveRecord::Base
  
  belongs_to :photo
  belongs_to :user
  
  def embedded_body
    body.gsub(/\{\{photo:([0-9]+)\}\}/x) do |match|
      if photo = Photo.find_by_id($1)
        url = photo.image.thumb('180x180#').url
        alt = photo.title
      else
        url = "http://placehold.it/180x180"
        alt = "image not found"
      end
      ActionController::Base.helpers.image_tag url, alt: alt
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
        photo = Photo.new(image: image, title: title.truncate(20, omission: '...'))
        photo.save
        "{{photo:#{photo.id}}}"
      end
      
      self.save
    rescue
      puts "#{title} has not been updated"
    end
  end

end
