class Stop < ActiveRecord::Base
  belongs_to :itinerary
  belongs_to :establishment
end
