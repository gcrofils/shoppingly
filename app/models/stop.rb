class Stop < ActiveRecord::Base
  belongs_to :itinerary
  belongs_to :establishment
  
  validates_uniqueness_of :establishment_id, :scope => :itinerary_id
end
