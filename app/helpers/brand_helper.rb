module BrandHelper
  def breadcrumb_brandname(brand)
    if is_chinese_locale? && !brand.chinese_name.blank?
      brand.chinese_name
    else
      brand.name
    end
  end
  
  def brand_name(brand)
    is_chinese_locale? ? brand.chinese_name : brand.name
  end
  
  
  def logo_tag(brand, size=:medium)
    
    brand ||= Brand.new 
    
    case size
    when :small
      width   = 45
      height  = 45
    when :medium
      width   = 100
      height  = 100
    when :original
      if brand.logo
        width   = brand.logo.image_width
        height  = brand.logo.image_height
      else
        width   = 200
        height  = 200
      end
    else
      
    end
    
    url = brand.logo ? brand.logo.thumb("#{width}x#{height}#").url : "http://placehold.it/#{width}x#{height}"
    
    image_tag url, size: "#{width}x#{height}", alt: "#{brand_name brand}", class: "brand-logo"
    
  end
end