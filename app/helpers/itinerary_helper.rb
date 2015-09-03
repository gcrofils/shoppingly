module ItineraryHelper
  def itinerary_title(itinerary)
    itinerary.title.blank? ? I18n.t('itineraries.unknown_title') : itinerary.title
  end
end