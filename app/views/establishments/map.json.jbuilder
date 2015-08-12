json.array! @establishments do |e|
  json.lat  e.latitude
  json.lng  e.longitude
  json.picture do 
    json.url "#{asset_path('maps/pointer.png')}"
    json.width 36
    json.height 36
  end
  json.infowindow "<b>#{e.brand.name} #{e.label}</b><br/>#{e.address}"
end