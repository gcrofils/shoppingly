class EstablishmentsController < ApplicationController
  
  def map
    
    if (ids = params[:ids])
      @establishments = Establishment.where(:id => ids)
    else
      @establishments = Establishment.all
    end
    render :layout => false
  end
  
end