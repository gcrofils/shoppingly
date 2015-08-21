# brand
json.title      brand_name(p)
json.summary    p.summary
json.datetime   p.updated_at
json.date       p.updated_at < 15.days.ago ? I18n.l(p.updated_at, format: :long) : distance_of_time_in_words(p.updated_at, Time.now)

# social
json.views      rand(150)

# flag
json.flag_url   asset_url('icons/flag_france.png' )

image_width   = rand(200) + 400
image_height  = 300
url           = "http://placehold.it/#{image_width}x#{image_height}"

json.original_url   url
json.width          pin_width
json.height         pin_width * image_height / image_width

json.partial! 'pins/solid_image', image_width: image_width,  image_height: image_height

# comments
json.comments rand(5)