$(document).ready ->
  $(".alert" ).fadeOut(5000)
  
$(document).on "click", '.bootbox a[data-remote=true]', (e) ->
  $(this).closest('.bootbox').find('.bootbox-close-button').trigger('click')
  
$(document).on "touchstart.alert click.alert", ".growlyflash", (e) ->
  e.stopPropagation()
  ($ @).alert 'close'
  off
  

$(document).ready ->
  spinner = "<i class='fa fa-spinner fa-spin'></i>"
  $("#itinerary-build-actions button[type='submit']").each (i, btn) ->
    $(btn).attr('data-disable-with', spinner + $(btn).find('span').text())

   

$(document).on "change", 'form :input', (e) ->
  spinner = "<i class='fa fa-spinner fa-spin'></i>"
  btn = $(this).closest('form').find("button[value='save']")
  btn
    .attr('data-disable-with', spinner + btn.data('label-on-change'))
    .find('span')
    .text(btn.data('label-on-change'))
  $(this).closest('form').find("button[value='cancel']").removeAttr('disabled')
  
$(document).on "click", 'button.bootbox-photo', (e) ->
  $.get $(this).data('url'),
      user_id: 1
    .done (data) ->
      bootbox.dialog({
        title : "test",
        message: data})