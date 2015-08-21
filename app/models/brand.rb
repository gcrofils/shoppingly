class Brand < ActiveRecord::Base
  acts_as_taggable_on :positioning , :products
  has_many :establishments
  has_and_belongs_to_many :posts
  has_one :pin, as: :pinnable
  dragonfly_accessor :logo
  dragonfly_accessor :banner
  
  before_save :default_chinese_name
  
  # thumbs_up
  acts_as_voteable
  
  def itineraries
    Itinerary.includes('stops').where('stops.establishment_id' => establishments)
  end
  
  # initial data migration
  def download_images
    begin
      # banner
      if banner_uid && banner_uid.start_with?("http")
        image = Dragonfly.app.fetch_url(banner_uid)
        self.banner = image
      end
      
      # logo
      if logo_uid && logo_uid.start_with?("http")
        image = Dragonfly.app.fetch_url(logo_uid)
        self.logo = image
      end
      
      
      self.save
    rescue Exception => e
      puts "#{name} has not been updated"
      puts e.message
    end
  end
  
  private
  
  def default_chinese_name
    self.chinese_name = name if chinese_name.blank?
  end
end
