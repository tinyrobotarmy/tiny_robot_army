class @Search

  constructor: (@searchField, @url) ->
    @button = @searchField.parent().find('button')
    @button.on 'click', @doSearch
    @searchField.on 'keyup', @checkForSubmit

  doSearch: (event) =>
    window.location.href = "#{@url}?q=#{@searchField.val()}"

  checkForSubmit: (event) =>
    @doSearch()  if event.keyCode is 13
