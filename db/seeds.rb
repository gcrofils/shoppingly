# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include Sprig::Helpers

# cleaning
ActiveAdmin::Comment.all.destroy_all
Photo.all.destroy_all

### Posts and Users
Stop.all.destroy_all
Itinerary.all.destroy_all
Post.all.destroy_all
User.all.destroy_all
Establishment.all.destroy_all
Brand.all.destroy_all


sprig [User, Post, Brand, Establishment, Itinerary, Stop]

# add avatar to users
avatars = %w(uxceo pixeliris jadlimcaco)
User.all.each_with_index do |u, i|
  avatar = Dragonfly.app.fetch_url("http://s3.amazonaws.com/uifaces/faces/twitter/#{avatars[i]}/128.jpg")
  u.avatar = avatar
  u.save!
end

#add posts to pin collection
Post.all.each do |p|
  Pin.create(pinnable: p, keywords: p.body)
end

#add brands to pin collection
Brand.all.each do |b|
  Pin.create(pinnable: b, keywords: b.description)
end

#add itineraries to pin collection
Itinerary.all.each do |i|
  Pin.create(pinnable: i, keywords: i.description)
end


