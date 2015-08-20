json.array! @itinerary.stops do |s|
  e = s.establishment
  json.lat  e.latitude
  json.lng  e.longitude
  json.picture do 
    json.url "#{asset_path('maps/pointer.png')}"
    json.width 42
    json.height 42
  end
  json.infowindow "<b>#{e.brand.name} #{e.label}</b><br/>#{e.address}"
end