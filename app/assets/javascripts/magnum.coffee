#= require sugar

@Magnum =
  namespace: 'urn:x-cast:com.google.cast.sample.remote_control'
  cursorX: 0
  cursorY: 0
  zIndex: 1
  aims: []

  init: (receiverManager) ->
    @currentHover = $('body')[0]
    @cursor = $('<div></div>')
      .css
        position: 'absolute'
        'background-color': '#0f0'
        width: 10
        height: 10
      .appendTo 'body'

    @cursorEl = @cursor[0]

    @messageBus = receiverManager.getCastMessageBus @namespace, cast.receiver.CastMessageBus.MessageType.JSON

    @messageBus.onMessage = (e) =>
      if e.data?.x && e.data?.y
        @cursorEl.style.left = e.data.x + 'px'
        @cursorEl.style.top = e.data.y + 'px'

        element = document.elementFromPoint e.data.x - 1, e.data.y - 1

        if @currentHover != element
          @currentHover.dispatchEvent new Event('mouseleave')
          @currentHover.classList.remove 'hover'

          @currentHover = element

          @currentHover.dispatchEvent new Event('mouseenter')
          @currentHover.classList.add 'hover'
