# itinerary
json.title      p.title
json.summary    p.summary
json.datetime   p.updated_at
json.date       p.updated_at < 15.days.ago ? I18n.l(p.updated_at, format: :long) : distance_of_time_in_words(p.updated_at, Time.now)

# social
json.views          rand(150)

# author
json.author_href    "#{profile_path(p.user)}"
json.author_avatar  p.user.avatar.thumb("30x30").url
json.author_name    p.user.name

# image
image_width   = 600
image_height  = rand(200) + 100
url           = "http://placehold.it/#{image_width}x#{image_height}"

json.original_url   url
json.width          pin_width
json.height         pin_width * image_height / image_width

json.partial! 'pins/solid_image', image_width: image_width,  image_height: image_height

# comments
json.comments rand(5)