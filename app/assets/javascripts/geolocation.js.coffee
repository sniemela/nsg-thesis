$ ->
  $.getLocationSupported = false
  $.userLocation = null
  
  handlePosition = ->
    if $.userLocation and $.userLocation.length == 2
      elements = $('a[data-location=true]')
      for element in elements
        href = $(element).attr('href')
        href += '?' if href[-1] != '?'
        href += '&location=' + $.userLocation[0] + ',' + $.userLocation[1]
        $(element).attr('href', href)
      
      elements = $('input[data-location=true]')
      for element in elements
        $(element).val($.userLocation[0] + ',' + $.userLocation[1])


  if navigator.geolocation
    $.getlocationSupported = true

    navigator.geolocation.getCurrentPosition (position) ->
        $.userLocation = [position.coords.latitude, position.coords.longitude]
        handlePosition()
      , (error) ->
        $.userLocation = null
        handlePosition()
