#= require jquery
#= require websocket_rails/main

$ ->
  window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance()
  window.castReceiverManager.start()
