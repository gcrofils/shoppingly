
json.total @posts.count 

json.locale I18n.locale

json.result @posts do |p|
  
  # post
  json.post_id    p.id
  json.post_href  post_path(p.id)
  json.title      p.title
  json.summary    p.summary
  json.datetime   p.published_at
  json.date       p.published_at < 15.days.ago ? I18n.l(p.published_at, format: :long) : distance_of_time_in_words(p.published_at, Time.now)
  
  # author
  json.author_href    "#{user_path(p.user)}"
  json.author_avatar  p.user.avatar.thumb("30x30").url
  json.author_name    p.user.name
  
  # social 
  json.pin_social_id  dom_id(p, 'social')
  json.views          rand(150)
  
  # post picture
  width=240
  
  if p.photo
    image_width   = p.photo.image_width
    image_height  = p.photo.image_height
    url           = p.photo.image.url
  else
    image_width   = 600
    image_height  = 300
    url           = "http://placehold.it/#{image_width}x#{image_height}"
  end
  
  json.original_url   url
  json.width          width
  json.height         width * image_height / image_width
  
  # default solid color image
  colors              = %w(d5a924 246bd5 d53524 a058c1)
  color               = colors[rand(colors.size)]
  color_image         = Dragonfly.app.fetch_file(Rails.root.join('app', 'assets', 'images', 'colors', "#{color}.jpg"))
  json.color_image    color_image.thumb("#{image_width}x#{image_height}#", 'format' => 'jpg').url
  json.color          color
  
  # comments
  json.comments rand(5)

end