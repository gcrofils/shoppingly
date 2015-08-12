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
end