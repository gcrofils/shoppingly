class Stop < ActiveRecord::Base
  belongs_to :itinerary
  belongs_to :establishment
  
  validates_uniqueness_of :establishment_id, :scope => :itinerary_id
  
  default_scope { order('position ASC') }
  
  # initial data migration
  def download_images
    begin
      
      self.description = description.gsub(/\{\{([a-zA-Z0-9\/\.\&\:\=\?\_]*)\}\}/x) do |match| 
        image = Dragonfly.app.fetch_url($1)
        photo = Ckeditor::Asset.new(data: image, assetable_type: 'User', assetable_id: itinerary.user.id, type: "Ckeditor::Picture")
        photo.data_name = establishment.brand.name
        photo.save
        ActionController::Base.helpers.image_tag(photo.data.url, class:'img-responsive img-thumbnail', alt: establishment.brand.name)
      end
      
      self.save
    rescue Exception => e
      puts "this stop (establishment: #{establishment.id}, itinerary: #{itinerary.id}) has not been updated"
      puts e.message
    end
  end
  
end
