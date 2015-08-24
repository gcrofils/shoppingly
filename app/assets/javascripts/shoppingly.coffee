# Override Rails handling of confirmation
# https://gist.github.com/postpostmodern/1862479
$.rails.allowAction = (element) ->
  # The message is something like "Are you sure?"
  message = element.data('confirm')
  # If there's no message, there's no data-confirm attribute, 
  # which means there's nothing to confirm
  return true unless message
  # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
  $link = element.clone()
    # We don't necessarily want the same styling as the original link/button.
    .removeAttr('class')
    # We don't want to pop up another confirmation (recursion)
    .removeAttr('data-confirm')
    # We want a button
    .addClass('btn').addClass('btn-danger')
    # We want it to sound confirmy
    .html("OK")

  # Create the modal box with the message
  modal_html = """
              <div class="bootbox modal fade bootbox-confirm" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body">
                      <button type="button" class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true" style="margin-top: -10px;">×</button>
                      <div class="bootbox-body">#{message}</div>
                    </div>
                    <div class="modal-footer">
                      <button data-bb-handler="cancel" type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                  </div>
                </div>
              </div>
               """
  $modal_html = $(modal_html)
  # Add the new button to the modal box
  $modal_html.find('.modal-footer').append($link)
  # Pop it up
  $modal_html.modal()
  # Prevent the original link from working
  return false



# https://github.com/estum/growlyflash
Growlyflash.defaults = $.extend on, Growlyflash.defaults,
  align:   'right'  # horizontal aligning (left, right or center)
  delay:   4000     # auto-dismiss timeout (0 to disable auto-dismiss)
  dismiss: yes      # allow to show close button
  spacing: 10       # spacing between alerts
  target:  'body'   # selector to target element where to place alerts
  title:   no       # switch for adding a title
  type:    null     # bootstrap alert class by default
  class:   ['alert', 'growlyflash', 'fade']

$(document).ready ->
  $(".alert" ).fadeOut(5000)
  
$(document).on "click", '.bootbox a[data-remote=true]', (e) ->
  $(this).closest('.bootbox').find('.bootbox-close-button').trigger('click')
  
$(document).on "touchstart.alert click.alert", ".growlyflash", (e) ->
  e.stopPropagation()
  ($ @).alert 'close'
  off