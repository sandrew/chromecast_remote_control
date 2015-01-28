#= require jquery
#= require websocket_rails/main

namespace = 'urn:x-cast:com.google.cast.sample.remote_control'

$ ->
  cursor = $ '.cursor'

  window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance()

  window.messageBus = window.castReceiverManager.getCastMessageBus namespace, cast.receiver.CastMessageBus.MessageType.JSON
  window.messageBus.onMessage = (e) ->
    if e.data?.x && e.data?.y
      cursor.css left: e.data.x, top: e.data.y


  window.castReceiverManager.start()
