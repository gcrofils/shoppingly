class PinsController < ApplicationController
  
  def index
    page = (params[:page] || 1).to_i
    if params[:brand_id] && (@brand = Brand.find(params[:brand_id]))
      @pins = @brand.pins
    else
      @pins = Pin.limit(3).offset(3 * (page - 1) )
    end
  end
  
end
