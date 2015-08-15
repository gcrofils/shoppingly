class Itinerary < ActiveRecord::Base
  
  belongs_to :user
  has_many :establishments, through: :stops
  
  # thumbs_up
  acts_as_voteable
  
end
