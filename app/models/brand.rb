class Brand < ActiveRecord::Base
  acts_as_taggable_on :positioning , :products
  has_many :establishments
  has_and_belongs_to_many :posts
  has_one :pin, as: :pinnable
  dragonfly_accessor :logo
  dragonfly_accessor :banner
  
  before_save :default_chinese_name
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  # thumbs_up
  acts_as_voteable
  
  def itineraries
    Itinerary.includes('stops').where('stops.establishment_id' => establishments)
  end
  
  # all pins related to this brand
  def pins
    pins = []
    #(Pin.types - [self.class.name]).each do |type|
    #   send(type.downcase.pluralize.to_sym).each{|p| pins << p.pin}
    #end
    %w(itineraries posts).each do |pinnable_type|
      send(pinnable_type.to_sym).each{|p| pins << p.pin}
    end
    pins
  end
  
  # Seed Banner and Logo
  def generate_placeholders
    if banner_uid.nil?
      self.banner_uid = "http://lorempixel.com/1000/300/fashion/"
    end
    if logo_uid.nil?
      self.logo_uid = "http://lorempixel.com/200/200/abstract/"
    end
    self.save
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
