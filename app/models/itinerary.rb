class Itinerary < ActiveRecord::Base
  
  belongs_to  :user
  has_many    :stops
  has_many    :establishments, through: :stops
  has_many    :brands, through: :establishments
  has_one     :pin, as: :pinnable
  
  accepts_nested_attributes_for :stops, allow_destroy: true
  
  validates :user, :presence => true
  validates :title, :presence => true
  
  # thumbs_up
  acts_as_voteable
  
  # initial data migration
  def download_images
    begin
      
      self.description = description.gsub(/\{\{([a-zA-Z0-9\/\.\&\:\=\?\_]*)\}\}/x) do |match| 
        image = Dragonfly.app.fetch_url($1)
        photo = Ckeditor::Asset.new(data: image, assetable_type: 'User', assetable_id: user.id, type: "Ckeditor::Picture")
        photo.data_name = title
        photo.save
        ActionController::Base.helpers.image_tag(photo.data.url, class:'img-responsive img-thumbnail', alt: title)
      end
      
      self.save
    rescue Exception => e
      puts "#{title} has not been updated"
      puts e.message
    end
  end
  
end
