json.total @posts.count 

json.result @posts do |p|
  width = 240
  height = rand(100..600)
  json.title p.title
  json.image p.featured_image
  json.summary p.summary
  json.width width
  json.height height
  json.likes rand(15)
  json.views rand(150)
  json.author_avatar Faker::Avatar.image(Faker::Internet.password, "30x30")
  json.author_name Faker::Name.name
end