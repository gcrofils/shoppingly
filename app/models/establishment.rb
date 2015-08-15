class Establishment < ActiveRecord::Base
  belongs_to :brand
  has_many :itineraries, through: :stops
  geocoded_by :address
  after_validation :geocode, if: Proc.new { |_| _.address.present? && _.address_changed? }
  
  dragonfly_accessor :picture
  dragonfly_accessor :static_map
  
  
  
  # initial data migration
  def download_images
    begin
      # banner
      if picture_uid && picture_uid.start_with?("http")
        image = Dragonfly.app.fetch_url(picture_uid)
        self.picture = image
      end
      
      self.save
    rescue Exception => e
      puts "#{label} has not been updated"
      puts e.message
    end
  end
  
  
end