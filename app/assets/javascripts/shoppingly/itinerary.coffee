class @Shoppingly.Itinerary
  
  @update_stop_positions: ->
    $("#stops").find("[id$='position']").each (index)->
      $(this).val(index)
      
  @add_stop: (establishment) ->
    node_to_reactivate = $("[establishment-id=" +  establishment.id + "]").closest('.row-stop')
    if node_to_reactivate.length
      node_to_reactivate.find("[id$='establishment_id']").removeClass('destroyed')
      node_to_reactivate.find("input[name*='destroy']").val('0')
      node_to_reactivate.appendTo('#stops')
      node_to_reactivate.show()
    else
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
        $('#stop_' + id).find('.img-brand-logo').replaceWith(establishment.brand_logo)
        $('#itinerary_stops_attributes_' + id + '_establishment_id').val(establishment.id)
        $('#itinerary_stops_attributes_' + id + '_establishment_id').attr('establishment-id', establishment.id)
        $('#brand_name_' + id).text(establishment.brand_name)
        $('#establishment_label_' + id).text(establishment.label) 
        @update_stop_positions()
  
  @remove_stop_from_map = (establishment) ->
    node_to_delete = $("[establishment-id=" +  establishment.id + "]").closest('.row-stop')
    if node_to_delete.find("a.remove_stop").hasClass('dynamic')
      node_to_delete.remove()
    else
      node_to_delete.find("[id$='establishment_id']").addClass('destroyed')
      node_to_delete.find("input[name*='destroy']").val('1')
      node_to_delete.hide()
    
  @remove_stop_from_list = (obj) ->
    node_to_delete = obj.closest('.row-stop')
    establishmentId = parseInt(node_to_delete.find("[id$='establishment_id']").val())
    marker = shoppingly.findMarkerbyEstablishmentId establishmentId
    shoppingly.unSelectMarker marker.serviceObject
    if $(this).hasClass('dynamic')
      node_to_delete.remove()
    else
      node_to_delete.find("[id$='establishment_id']").addClass('destroyed')
      node_to_delete.find("input[name*='destroy']").val('1')
      node_to_delete.hide() 