class Brand < ActiveRecord::Base
  acts_as_taggable_on :positioning , :products
  has_many :establishments
  has_and_belongs_to_many :posts
end
