json.total @posts.count 

json.result @posts do |p|
  json.title p.title
  json.image image_url("mockup/#{rand(9)}.jpg")
  json.width 192
  json.height 288
end