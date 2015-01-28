#= require jquery
#= require materialize-sprokets
#= require sugar
#= require websocket_rails/main

appID = 'BDCCBA9B'
namespace = 'urn:x-cast:com.google.cast.sample.remote_control'
window.session = null

startCursor = ->
  unless $('body').hasClass 'moving'
    $('body').addClass('moving').on 'mousemove', ((e) ->
      window.session.sendMessage 'urn:x-cast:com.google.cast.sample.remote_control', {x: e.clientX, y: e.clientY}, (->), (->)
    ).throttle(10)

receiverListener = (e) ->
  if e == chrome.cast.ReceiverAvailability.AVAILABLE
    $('.start-cast').removeClass('disabled').on 'click', ->
      chrome.cast.requestSession onRequestSessionSuccess, onLaunchError
      false
  else
    console.log 'receiver list empty'

onRequestSessionSuccess = (e) ->
  window.session = e
  startCursor()

sessionUpdateListener = ->

onInitSuccess = ->
  console.log 'onInitSuccess'

onMessageError = onLaunchError = onError = (message) ->
  console.log "onError"
  console.log message

sessionListener = (e) ->
  if e.status == 'connected'
    startCursor()
  window.session = e
  window.session.addUpdateListener sessionUpdateListener
  # session.addMessageListener namespace, receiverMessage

initializeCastApi = ->
  sessionRequest = new chrome.cast.SessionRequest appID
  apiConfig = new chrome.cast.ApiConfig sessionRequest, sessionListener, receiverListener
  chrome.cast.initialize apiConfig, onInitSuccess, onError

window['__onGCastApiAvailable'] = (loaded, errorInfo) ->
  if loaded
    initializeCastApi()
  else
    console.log errorInfo

