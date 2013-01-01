(($) ->
  $.fn.slideoutForm = (options) ->
    @each ->
      new SlideoutForm($(this), options)


  SlideoutForm = (form, options) ->
    @form = form
    @list = options.list
    @control = options.control
    @cancelControl = options.cancel
    @control.click $.proxy(@add, this)
    @cancelControl.click $.proxy(@cancel, this)
    if options["multipart"]
      @form.ajaxForm success: $.proxy(@updateList, this)
    else
      @form.submit $.proxy(@save, this)
    @form.hide()  if @form.is(":visible")

  SlideoutForm:: =
    add: ->
      @form.slideDown "fast"
      @form.find("input[type=text],textarea,select").filter(":visible:first").focus()
      $(document).keyup $.proxy(@keyCancel, this)
      @control.hide()
      @form.trigger "formShow"
      false

    cancel: ->
      @form.find("textarea, input[type=text], select").val ""
      @form.find("input[type=submit]").removeAttr "disabled"
      $(document).unbind "keyup", $.proxy(@keyCancel, this)
      @form.slideUp "fast"
      @control.show()
      @form.trigger "formHide"
      false

    keyCancel: (event) ->
      @cancel()  if event.keyCode is 27
      false

    save: ->
      $.ajax
        url: @form.attr("action")
        type: "POST"
        data: @form.serialize()
        success: $.proxy(@updateList, this)

      false

    updateList: (data) ->
      @list.prepend data
      @form.trigger "newItem", @list.find("li:first")
      $("input[type=submit]").removeAttr "disabled"
      @cancel()
) jQuery