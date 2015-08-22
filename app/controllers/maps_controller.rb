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


end