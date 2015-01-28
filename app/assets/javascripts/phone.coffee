#= require jquery
#= require materialize-sprokets
#= require websocket_rails/main

appID = 'BDCCBA9B'
namespace = 'urn:x-cast:com.google.cast.sample.remote_control'
window.session = null

receiverListener = (e) ->
  if e == chrome.cast.ReceiverAvailability.AVAILABLE
    $('.start-cast').removeClass('disabled').on 'click', ->
      chrome.cast.requestSession onRequestSessionSuccess, onLaunchError
      false
  else
    console.log 'receiver list empty'

onRequestSessionSuccess = (e) ->
  window.session = e
  window.session.sendMessage namespace, 'Handshake', (->), onMessageError

sessionUpdateListener = ->

onInitSuccess = ->
  console.log 'onInitSuccess'

onMessageError = onLaunchError = onError = (message) ->
  console.log "onError"
  console.log message

sessionListener = (e) ->
  console.log 'New session ID:' + e.sessionId
  window.session = e
  window.session.addUpdateListener sessionUpdateListener
  # session.addMessageListener namespace, receiverMessage

initializeCastApi = ->
  sessionRequest = new chrome.cast.SessionRequest appID
  apiConfig = new chrome.cast.ApiConfig sessionRequest, sessionListener, receiverListener
  console.log chrome.cast.initialize apiConfig, onInitSuccess, onError

window['__onGCastApiAvailable'] = (loaded, errorInfo) ->
  if loaded
    initializeCastApi()
  else
    console.log errorInfo

