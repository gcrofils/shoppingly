$(document).on 'click', 'form .remove_stop', (event) ->
  Shoppingly.Itinerary.remove_stop_from_list $(this)
  event.preventDefault()
  

$(document).ready ->
  
  window.CKupdate = ->
    for int in CKEDITOR.instances
      CKEDITOR.instances[instance].updateElement();

  
  $( ".sortable" ).sortable(
    axis: 'y'
    update: ->
      Shoppingly.Itinerary.update_stop_positions()
  )

$(document).ajaxComplete ->
  
  $( ".sortable" ).sortable(
    axis: 'y'
    update: ->
      Shoppingly.Itinerary.update_stop_positions()
  )
  
  try
    CKEDITOR.replace( 'itinerary_description' );
  catch error
    return
