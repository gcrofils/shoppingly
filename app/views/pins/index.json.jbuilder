json.total @pins.count 

json.locale I18n.locale

json.pins @pins do |p|
  
  pinnable      = p.pinnable
  pinnable_type = pinnable.class.name.downcase
  pinnable_id   = p.pinnable.id
  
  # pins
  json.pinnable_type  pinnable_type
  json.pinnable_id    pinnable_id
  json.pinnable_href  send("#{pinnable_type}_path", pinnable)
  
  # social 
  json.pin_social_id  dom_id(pinnable, 'social')
  json.user_likes_url user_likes_path(voteable: pinnable_type, id: pinnable_id )
  
  json.partial! "#{pinnable_type.pluralize}/pin", p: pinnable, pin_width: 240
  
end