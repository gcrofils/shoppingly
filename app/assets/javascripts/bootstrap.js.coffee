jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('.dropdown-toggle').dropdown()

  setTimeout (->
    $('img.lazy2').each ->
      imagex = $(this)
      imgOriginal = imagex.data('original')
      $(imagex).attr 'src', imgOriginal
      return
    return
  ), 3000
