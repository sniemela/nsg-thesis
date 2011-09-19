# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  Array::unique = ->
    output = {}
    output[@[key]] = @[key] for key in [0...@length]
    value for key, value of output

  handleSlide = (value) ->
    $('input#ad_days').val(value)
    $('#days').html(value)
    updatePrice()

  updatePrice = ->
    days = $('input#ad_days').val()
    tagsStr = $('input#tags').val()
    tagsRegex = /([A-Za-z0-9]+)/g
    tags = (tagsStr.match(tagsRegex) || []).unique()

    tagsPrice = 0
    tagsPrice = tags.length * 5
    daysPrice = days * 5
    total = tagsPrice + daysPrice
    $('.ad_price').html(total)

  $('#select_ad_days').slider({
    min: 1,
    slide: (event, ui) -> handleSlide(ui.value); true,
    create: (event, ui) -> handleSlide(1)
  })

  $('input.datetimepicker').timepicker()
  $('input#tags').keydown ->
    setTimeout((-> updatePrice()), 50)


