class Photo < ActiveRecord::Base
  dragonfly_accessor :image
  has_many :posts
end
