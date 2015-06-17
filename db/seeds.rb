# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include Sprig::Helpers

ActiveAdmin::Comment.all.destroy_all
Photo.all.destroy_all
Post.all.destroy_all
User.all.destroy_all

sprig [User, Post, Brand]

# add avatar to users
avatars = %w(uxceo pixeliris jadlimcaco)
User.all.each_with_index do |u, i|
  avatar = Dragonfly.app.fetch_url("http://s3.amazonaws.com/uifaces/faces/twitter/#{avatars[i]}/128.jpg")
  u.avatar = avatar
  u.save!
end