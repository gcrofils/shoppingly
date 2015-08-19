class Itinerary < ActiveRecord::Base
  
  belongs_to :user
  has_many :stops
  has_many :establishments, through: :stops
  accepts_nested_attributes_for :stops, allow_destroy: true
  
  validates :user, :presence => true
  validates :title, :presence => true
  
  # thumbs_up
  acts_as_voteable
  
end
