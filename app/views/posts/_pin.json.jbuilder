# post
json.title      p.title
json.summary    p.summary
json.datetime   p.published_at
json.date       p.published_at < 15.days.ago ? I18n.l(p.published_at, format: :long) : distance_of_time_in_words(p.published_at, Time.now)

# author
json.author_href    "#{profile_path(p.user)}"
json.author_avatar  p.user.avatar.thumb("30x30").url
json.author_name    p.user.name

# social
json.views          rand(150)

# post banner

if p.banner
  image_width   = p.banner.image_width
  image_height  = p.banner.image_height
  url           = p.banner.image.url
else
  image_width   = 600
  image_height  = 300
  url           = "http://placehold.it/#{image_width}x#{image_height}"
end

json.original_url   url
json.width          pin_width
json.height         pin_width * image_height / image_width

json.partial! 'pins/solid_image', image_width: image_width,  image_height: image_height

# comments
json.comments rand(5)

