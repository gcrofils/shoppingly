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
    
  fill_social_block = ->
    $(".pin-social").each (i, el) -> 
      $(this).load($(el).data('url'))
    
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
      itemCls: 'pin',
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
          models = ['brand', 'post', 'itinerary']
          templates = []
         
          for model in models
            tpl = $('#' + model + '-tpl').html()
            templates[model] = Handlebars.compile(tpl)
          
          result = ""
          for pin in data['pins']
            template = templates[pin['pinnable_type']]
            result += template(pin)
            
          return result
        loadingFinished: ($loading, isBeyondMaxPage) ->
          if !isBeyondMaxPage then $loading.fadeOut() else $loading.remove()
          fill_social_block()
          fill_lazy_container()
          
          #console.log ('WILL CALL IMAGES LOADED')
          $('#lazy-container').imagesLoaded().progress( onProgress ).always( onAlways );
          return
      }
      path:  (page) -> 
          return "/do/pins.json?locale=" + I18n_locale+ "&page=" + page
  });