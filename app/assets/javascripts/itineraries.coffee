$(document).on 'click', 'form .remove_stop', (event) ->
  node_to_delete = $(this).closest('.row-stop')
  if $(this).hasClass('dynamic')
    node_to_delete.remove()
  else
    node_to_delete.find("[id$='establishment_id']").addClass('destroyed')
    node_to_delete.find("input[name*='destroy']").val('1')
    node_to_delete.hide()
  event.preventDefault()
  
$(document).on 'click', 'li .add_establishment', (event) ->
  add_stop($(this).data('establishment'))
  event.preventDefault()
  

$(document).ready ->
  
  window.CKupdate = ->
    for int in CKEDITOR.instances
      CKEDITOR.instances[instance].updateElement();
  
  window.update_stop_positions = ->
    $("#stops").find("[id$='position']").each (index)->
      $(this).val(index)
  
  window.add_stop = (establishment) ->
    establishment_ids = $("#stops").find("[id$='establishment_id']").not(".destroyed").map -> 
      return parseInt(this.value)
    if $.inArray(establishment.id, establishment_ids) > -1
      bootbox.alert('Establishment already in the list')
    else
      template = $('#stop_fields_template')
      id = new Date().getTime()
      regexp = new RegExp(template.data('id'), 'g')
      $('#stops').append(template.data('fields').replace(regexp, id).replace('new_stop', 'stop_' + id))
      $('#stop_' + id).find('a.remove_stop').addClass('dynamic')
      $('#itinerary_stops_attributes_' + id + '_establishment_id').val(establishment.id)
      $('#brand_name_' + id).text(establishment.brand_name)
      $('#establishment_label_' + id).text(establishment.label) 
      update_stop_positions()   
  
  $( ".sortable" ).sortable(
    axis: 'y'
    update: ->
      update_stop_positions()
  )

$(document).ajaxComplete ->
  
  $( ".sortable" ).sortable(
    axis: 'y'
    update: ->
      update_stop_positions()
  )
  
  try
    CKEDITOR.replace( 'itinerary_description' );
  catch error
    return