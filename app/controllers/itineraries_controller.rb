class ItinerariesController < ApplicationController
  
  def index
    @itineraries = Itinerary.all
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end
  
  def create
    @itinerary = Itinerary.new
    @itinerary.user = current_user
    @itinerary.save(validate: false)
    redirect_to itinerary_build_path(@itinerary, Itinerary.form_steps.first)
  end

  
  def destroy
    @itinerary = Itinerary.find(params[:id])
    level, key = @itinerary.destroy ? [:notice, 'destroyed_ok'] : [:alert, 'destroyed_ko']
    flash[level] = I18n.t "activerecord.actions.itinerary.#{key}", title: @itinerary.title
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = I18n.t 'activerecord.actions.itinerary.destroyed_already'
  ensure
    redirect_to stored_location_for(:user)
  end
   
private
   
  def itinerary_params
    params.require(:itinerary).permit(:user_id, :title, :description, stops_attributes: [:id, :description, :establishment_id, :itinerary_id, :position, :_destroy])
  end

 
end