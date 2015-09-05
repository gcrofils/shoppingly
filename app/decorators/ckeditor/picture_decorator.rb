class Ckeditor::PictureDecorator < ApplicationDecorator
  delegate_all
  def url_thumb
    data.thumb("200x150#").url
  end
  
end