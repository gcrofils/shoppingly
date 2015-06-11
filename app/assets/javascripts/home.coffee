# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$(document).ready ->
#  $('.waterfall')
#    .data('bootstrap-waterfall-template', $('#waterfall-template').html())
#    .waterfall();

$(document).ready ->
  $('#container').waterfall({
      itemCls: 'item',
      colWidth: 222,
      gutterWidth: 15,
      gutterHeight: 15,
      checkImagesLoaded: false,
      isAnimated: true,
      animationOptions: {
      },
      path:  (page) -> 
          return '/posts/waterfall.json?page=' + page
  });