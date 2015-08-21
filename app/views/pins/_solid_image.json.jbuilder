# default solid color image
colors              = %w(d5a924 246bd5 d53524 a058c1)
color               = colors[rand(colors.size)]
color_image         = Dragonfly.app.fetch_file(Rails.root.join('app', 'assets', 'images', 'colors', "#{color}.jpg"))
json.color_image    color_image.thumb("#{image_width}x#{image_height}#", 'format' => 'jpg').url
json.color          color