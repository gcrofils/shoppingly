json.total @posts.count 

json.result @posts do |p|
  
  width=240
  featured_image = p.photo.image.thumb("#{width}x")
  json.image_src featured_image.url
  json.width width
  json.height featured_image.height
  
  json.title p.title
  json.summary p.summary
  
  json.likes rand(15)
  json.views rand(150)
  json.author_avatar Faker::Avatar.image(Faker::Internet.password, "30x30")
  json.author_name Faker::Name.name
end