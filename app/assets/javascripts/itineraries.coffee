$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('fieldset').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $('table.stops tr:last').after($(this).data('fields').replace(regexp, time))
  event.preventDefault()
  
$(document).on 'click', 'li .add_establishment', (event) ->
  add_stop($(this).data('establishment'))
  event.preventDefault()

$(document).ready ->
  window.add_stop = (establishment) ->
    template = $('#stop_fields_template')
    id = new Date().getTime()
    regexp = new RegExp(template.data('id'), 'g')
    debugger
    $('table.stops tr:last').after(template.data('fields').replace(regexp, id))
    $('#itinerary_stops_attributes_' + id + '_establishment_id').val(establishment.id)
    $('#brand_name_' + id).text(establishment.brand)
    $('#establishment_label_' + id).text(establishment.establishment)
