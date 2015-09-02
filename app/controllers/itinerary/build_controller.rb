class Itinerary::BuildController < ApplicationController
  include Wicked::Wizard
  steps *Itinerary.form_steps
  
  before_filter :find_itinerary
  
  def show
    render_wizard nil, layout: 'user'
  end
  
  def update
    @itinerary.assign_attributes(itinerary_params(step))
    render_wizard @itinerary, layout: 'user'
  rescue ActionController::ParameterMissing
    flash[:alert] = 'veuillez remplir tous les champs'
    render_wizard nil, layout: 'user'
  end
  
  private
  
  def find_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  
  def itinerary_params(step)
    permitted_attributes = case step
      when "intro"
        [:user_id]
      when "init"
        [:title, :description]
      when "map"
        [stops_attributes: [:id, :description, :establishment_id, :itinerary_id, :position, :_destroy]]
      when "stops"
        [stops_attributes: [:id, :description, :establishment_id, :itinerary_id, :position, :_destroy]]
      end
    params.require(:itinerary).permit(permitted_attributes).merge(form_step: step).merge(status: next_step)
  end
  
end


