$(document).ready ->
  $(".alert" ).fadeOut(5000)
  
$(document).on "click", '.bootbox a[data-remote=true]', (e) ->
  $(this).closest('.bootbox').find('.bootbox-close-button').trigger('click')
  
$(document).on "touchstart.alert click.alert", ".growlyflash", (e) ->
  e.stopPropagation()
  ($ @).alert 'close'
  off
  
