class Establishment < ActiveRecord::Base
  belongs_to :brand
  geocoded_by :address
  after_validation :geocode
end