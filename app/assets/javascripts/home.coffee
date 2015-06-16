# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$(document).ready ->
#  $('.waterfall')
#    .data('bootstrap-waterfall-template', $('#waterfall-template').html())
#    .waterfall();

$(document).ready ->
  $('#container-waterfall').waterfall({
      itemCls: 'pin-wrapper',
      columnWidth: 240,
      gutterWidth: 15,
      gutterHeight: 15,
      checkImagesLoaded: false,
      isFadeIn: true,
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
          $('img.lazy').imagesLoaded  ->
            $('img.lazy').each ->
              imagex = $(this)
              $(imagex).removeClass('lazy')
              return
          return
      }
      path:  (page) -> 
          return "/posts/waterfall.json?locale=" + I18n_locale+ "&page=" + page
  });
  
