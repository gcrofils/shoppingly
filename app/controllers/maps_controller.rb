class MapsController < ApplicationController


  def static
    if (ids = params[:ids])
      @establishments = Establishment.where(:id => ids)
    else
      @establishments = Establishment.all
    end
    render :layout => false
  end
  
  def selectable
    if (ids = params[:ids])
      @establishments = Establishment.where(:id => ids)
    else
      @establishments = Establishment.all
    end
    render :layout => false
  end
  
  def itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
    render :layout => false
  end


end