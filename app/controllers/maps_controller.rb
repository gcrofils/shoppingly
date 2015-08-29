class MapsController < ApplicationController


  def static
    if (ids = params[:ids])
      @establishments = Establishment.geocoded.where(:id => ids)
    else
      @establishments = Establishment.geocoded
    end
    render :layout => false
  end
  
  def selectable
    if (ids = params[:ids])
      @establishments = Establishment.geocoded.where(:id => ids)
    else
      @establishments = Establishment.geocoded
    end
    render :layout => false
  end
  
  def itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
    render :layout => false
  end
  
  def geolocalised
    render :layout => false
  end
  
  def near
    @establishments = Establishment.near([params[:latitude], params[:longitude]], 5)
    @establishments = @establishments.where("id NOT IN (?)", params[:e]) if params[:e]
    @establishments = @establishments.limit(10)
    render 'selectable'
  end


end