class Editors::ItinerariesController < ApplicationController
  
  before_action :find_resource, only: [:show, :update]
  
  def index
    @itineraries = Itinerary.all
  end
  
  def show
    @itinerary.review!(current_user)
  rescue Workflow::NoTransitionAllowed
    flash[:alert] = I18n.t('activerecord.actions.editor.itinerary.show_not_available', title: @itinerary.title)
    redirect_to editor_itineraries_path
  end
  
  def update
    @itinerary.send("#{params[:review]}!")
    redirect_to editor_itineraries_path
  rescue Workflow::NoTransitionAllowed
    if @itinerary.awaiting_editor_review?
      flash[:alert] = I18n.t('activerecord.actions.editor.itinerary.must_be_reviewed', title: @itinerary.title)
    else
      flash[:alert] = 'unknown error'
    end
    redirect_to editor_itineraries_path
  end
  
  private
  
  def find_resource
    @itinerary = Itinerary.find(params[:id])
  end
end
