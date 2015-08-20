class ItinerariesController < ApplicationController
 
  layout "application"
  
  def index
    @itineraries = Itinerary.all
  end
   
  def new
     @itinerary = Itinerary.new
     @itinerary.user = current_user
     render 'form'
  end
  
  def show
    @itinerary = Itinerary.find(params[:id])
  end
  
  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user = current_user
    #debugger
    if @itinerary.save
      flash[:notice] = "Welcome to the Sample App!"
      redirect_to @itinerary
    else
      flash[:alert] = "error"
      render 'form'
    end
  end
  
  def edit
    @itinerary = Itinerary.find(params[:id])
    render 'form'
  end
  
  def update
    @itinerary = Itinerary.find(params[:id])
    @itinerary.user = current_user
    #debugger
    if @itinerary.update_attributes(itinerary_params)
      flash[:notice] = "Welcome to the Sample App!"
      redirect_to @itinerary
    else
      flash[:alert] = "error"
      render 'form'
    end
  end
   
  private
   
  def itinerary_params
    params.require(:itinerary).permit(:user_id, :title, :description, stops_attributes: [:id, :description, :establishment_id, :itinerary_id, :position, :_destroy])
  end

 
end