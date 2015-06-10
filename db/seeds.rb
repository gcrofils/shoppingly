# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

module Faker
  
  class Post
   def self.faketitle
      return Faker::Lorem.sentence(3, true, 4)
    end
  
    def self.fakebody
      return "<h1>#{Faker::Lorem.sentence(3)}</h1>
      <h2>#{Faker::Lorem.sentence(3)}</h2>
      <p>#{Faker::Lorem.paragraph(1, true, 4)}</p>
      <h2>#{Faker::Lorem.sentence(3)}</h2>
      <p>#{Faker::Lorem.paragraph(1, true, 4)}</p>
      <p><img src='http://imagemockup.com/640/480/textures/?#{rand(1000)}'></p>
      <p><img src='http://imagemockup.com/640/480/textures/?#{rand(1000)}'></p>
      <p><img src='http://imagemockup.com/640/480/textures/?#{rand(1000)}'></p>
      <p><img src='http://imagemockup.com/640/480/textures/?#{rand(1000)}'></p>
      "
    end
  end
  
end




Post.all.destroy_all

(1..100).each do |i|
  Post.create(
    title: Faker::Post.faketitle,
    body: Faker::Post.fakebody
  )
end



