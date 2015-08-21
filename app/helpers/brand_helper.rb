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
  
  
  def logo_tag(brand, size=:medium, options={})
    
    brand ||= Brand.new 
    
    case size
    when :small
      width   = 45
      height  = 45
    when :medium
      width   = 100
      height  = 100
    when :large
      width   = 200
      height  = 200
    when :original
      if brand.logo
        width   = brand.logo.width
        height  = brand.logo.height
      else
        width   = 200
        height  = 200
      end
    else
      
    end
    
    url = brand.logo ? brand.logo.thumb("#{width}x#{height}#").url : "http://placehold.it/#{width}x#{height}"
    
    options[:class] ||= '' 
    options[:class] << " img-brand-logo"
    image_tag url, alt: "#{brand_name brand}", class: options[:class]
    
  end
end