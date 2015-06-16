json.total @posts.count 

json.locale I18n.locale

json.result @posts do |p|
  
  #begin
  width=240
  #if p.photo
    #featured_image = p.photo.image.thumb("#{width}x")
    #json.image_src featured_image.url
    #json.image_caption p.photo.title
    color = 'd5a924'
    color_image = Dragonfly.app.fetch_file(Rails.root.join('app', 'assets', 'images', 'colors', "#{color}.png"))

    json.original_url p.photo.image.remote_url
    json.color color_image.thumb("#{p.photo.image_width}x#{p.photo.image_height}").url
    json.width width
    json.height width * p.photo.image_height / p.photo.image_width
    
   
    
    #end
  
  json.post_id p.id
  json.post_href post_path(p.id)
  
  json.title p.title
  json.summary p.summary
  json.datetime p.published_at
  json.date p.published_at < 15.days.ago ? I18n.l(p.published_at, format: :long) : distance_of_time_in_words(p.published_at, Time.now)
  
  json.likes rand(15)
  json.views rand(150)
  json.author_avatar p.user.avatar.thumb("30x30").url
  json.author_name p.user.name
  
  json.comments rand(5)
  #rescue
  #end
end