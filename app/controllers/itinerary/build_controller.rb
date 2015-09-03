class Itinerary::BuildController < ApplicationController
  include Wicked::Wizard
  steps *Itinerary.form_steps
  
  before_filter :find_itinerary
  before_filter :current_step
  
  SUBMIT_SAVE = 'save'
  SUBMIT_PREVIOUS = 'previous'
  SUBMIT_FOR_REVIEW = 'review'
  
  def show
    render_wizard nil, layout: 'user'
  end
  
  def update
    @itinerary.assign_attributes(itinerary_params(step))
    case params[:submit]
    when SUBMIT_SAVE
      save_and_exit_wizard and return
    when SUBMIT_PREVIOUS
      jump_to_step(previous_step)
    when SUBMIT_FOR_REVIEW
      submit_to_editor and return
    end
    render_wizard @itinerary, layout: 'user'
  rescue ActionController::ParameterMissing
    flash[:alert] = 'veuillez remplir tous les champs'
    render_wizard nil, layout: 'user'
  end
  
  private

  
  def current_step
    @current_step = params[:id]
  end
  
  def find_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end
  
  def save_and_exit_wizard
    @itinerary.status = step
    if @itinerary.save
      redirect_to itineraries_user_path 
    else
      render_wizard(@itinerary, layout: 'user')
    end
  end
  
  def jump_to_step(step)
    @current_step     = step
    @itinerary.status = step
    jump_to(step)
  end
  
  def submit_to_editor
    @itinerary.status = Itinerary.form_steps.last
    @itinerary.submit_to_editor!
    flash[:notice] = "Itinérarire '#{@itinerary.title}' a été soumis pour validation"
    redirect_to itineraries_user_path
  rescue Workflow::NoTransitionAllowed
    flash[:alert] = 'une erreur est survenue'
    jump_to_step(Itinerary.form_steps.first)
    render_wizard @itinerary, layout: 'user'
  end
  
  def finish_wizard_path
    itineraries_user_path
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


