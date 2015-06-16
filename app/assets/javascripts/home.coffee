# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$(document).ready ->
#  $('.waterfall')
#    .data('bootstrap-waterfall-template', $('#waterfall-template').html())
#    .waterfall();



$(document).ready ->
  
  onProgress = ( imgLoad, image ) ->
    if image.isLoaded 
      img = $('#' + $(image.img).data('original-id'))
      img.removeClass('lazy').attr('src', img.data('original'))
    return

  onAlways = ->
    $('img.lazy').each ->
      imagex = $(this)
      $(imagex).removeClass('lazy')
      return
    return
    
  fill_lazy_container = ->
    $('img.lazy').each (i, el) -> 
      img = $('<img />')
      img.attr({ 
        src: $(el).data('original'),
        "data-original-id": el.id
      });
      $('#lazy-container').append(img)
    return
  
  $('#container-waterfall').waterfall({
      itemCls: 'pin-wrapper',
      columnWidth: 240,
      gutterWidth: 15,
      gutterHeight: 15,
      checkImagesLoaded: false,
      isFadeIn: false,
      isAnimated: false,
      animationOptions: {
      },
      callbacks: {
        renderData: (data, dataType) ->
          $('#container-waterfall').waterfall('pause') if data.total < 1 
          tpl = $('#waterfall-tpl').html()
          template = Handlebars.compile(tpl)
          return template(data)
        loadingFinished: ($loading, isBeyondMaxPage) ->
          if !isBeyondMaxPage then $loading.fadeOut() else $loading.remove()
          fill_lazy_container()
          
          #console.log ('WILL CALL IMAGES LOADED')
          $('#lazy-container').imagesLoaded().progress( onProgress ).always( onAlways );
          return
      }
      path:  (page) -> 
          return "/posts/waterfall.json?locale=" + I18n_locale+ "&page=" + page
  });