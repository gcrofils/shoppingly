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

sprig [User, Post]