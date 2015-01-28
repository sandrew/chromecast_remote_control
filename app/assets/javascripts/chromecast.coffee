#= require jquery
#= require websocket_rails/main

namespace = 'urn:x-cast:com.google.cast.sample.remote_control'

$ ->
  window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance()

  window.messageBus = window.castReceiverManager.getCastMessageBus namespace
  window.messageBus.onMessage = (e) ->
    console.log "Message [#{e.senderId}]: #{e.data}"

  window.castReceiverManager.start()
