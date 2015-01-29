#= require jquery
#= require ./magnum

$ ->
  window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance()

  Magnum.init window.castReceiverManager

  window.castReceiverManager.start()
