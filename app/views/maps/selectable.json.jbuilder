json.array! @establishments do |e|
  json.lat  e.latitude
  json.lng  e.longitude
  json.establishment do
    json.id             e.id
    json.label          e.label
    json.brand_name     e.brand.name
    json.brand_logo     logo_tag(e.brand)
  end
  json.picture do 
    json.url "#{asset_path('maps/pointer.png')}"
    json.width 42
    json.height 42
  end
  json.infowindow "<b>#{e.brand.name} #{e.label}</b><br/>#{e.address}"
end