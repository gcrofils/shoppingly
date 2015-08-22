$(document).on 'click', '#brand-stores.widget #add_new_establishment', (event) ->
  bootbox.dialog({
    title: $('#brand-stores.widget #form-new-establishment').data('title'),
    message: $('#brand-stores.widget #form-new-establishment').html()
  })
  event.preventDefault()
  
$(document).on 'click', '#brand-stores.widget .edit-establishment', (event) ->
  $.get($(this).attr("href"), (data) ->
    bootbox.dialog({
      title: 'edit',
      message: data
    })
  )
  event.preventDefault()
