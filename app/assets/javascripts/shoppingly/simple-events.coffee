
    
isBreakpoint= (alias) ->
  $('.device-' + alias).is(':visible')

$(document).ready ->
  $(".alert" ).fadeOut(5000)
  
$(document).on "click", '.bootbox a[data-remote=true]', (e) ->
  $(this).closest('.bootbox').modal('hide')
  
$(document).on "touchstart.alert click.alert", ".growlyflash", (e) ->
  e.stopPropagation()
  ($ @).alert 'close'
  off
  

## Itinerary Build  

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
 

banner_image= (url, title)->
  image = "<img title='#{title}' class='img-thumbnail img-responsive' src='#{url}' alt='#{title}'>"
  $('#banner-image').html(image)  
  
gal_per_page= ->
  return 8 if isBreakpoint('xs')
  return 9 if isBreakpoint('sm')
  return 16 if isBreakpoint('sm')
  return 24 if isBreakpoint('lg')
  
$(document).on "click", '#banner-gallery button', (e) ->
  title = $(this).data('title')
  $.get $(this).data('url'),
      user_id: 1
      per_page: gal_per_page()
    .done (data) ->
      $('#banner-gallery #modal-default .modal-body').html(data)
      $('#banner-gallery #modal-default .modal-title').html(title)
    
$(document).on "click", ".gal-item", (e) ->
  $('#itinerary_banner_id').val $(this).attr('id').substring($(this).data('asset-type').length + 1)
  img = $(this).find('img')
  banner_image(img.attr('src'), img.attr('title'))
  $(this).closest('.modal').modal('hide')

$(document).ajaxComplete ->
  $('#banner-gallery .pagination a').attr('data-remote', 'true')

