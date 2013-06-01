$ ->
  initToolbarBootstrapBindings = ->
    fonts = ["Serif", "Sans", "Arial", "Arial Black", "Courier", "Courier New", "Comic Sans MS", "Helvetica", "Impact", "Lucida Grande", "Lucida Sans", "Tahoma", "Times", "Times New Roman", "Verdana"]
    fontTarget = $("[title=Font]").siblings(".dropdown-menu")
    $.each fonts, (idx, fontName) ->
      fontTarget.append $("<li><a data-edit=\"fontName " + fontName + "\" style=\"font-family:'" + fontName + "'\">" + fontName + "</a></li>")

    $("a[title]").tooltip container: "body"
    $(".dropdown-menu input").click(->
      false
    ).change(->
      $(this).parent(".dropdown-menu").siblings(".dropdown-toggle").dropdown "toggle"
    ).keydown "esc", ->
      @value = ""
      $(this).change()

    $("[data-role=magic-overlay]").each ->
      overlay = $(this)
      target = $(overlay.data("target"))
      overlay.css("opacity", 0).css("position", "absolute").offset(target.offset()).width(target.outerWidth()).height target.outerHeight()

    if "onwebkitspeechchange" of document.createElement("input")
      editorOffset = $("#post_body_editor").offset()
      $("#voiceBtn").css("position", "absolute").offset
        top: editorOffset.top + 30
        left: editorOffset.left + $("#post_body_editor").innerWidth() - 35

    else
      $("#voiceBtn").hide()

  initToolbarBootstrapBindings()

  $('#image_modal').on('click', 'a.thumbnail', ->
    $('#image_modal').modal('hide')
    window.wysiwyg.focus()
    document.execCommand("insertImage",0 , $(this).find('img').attr('src'))
    false
  )

  window.wysiwyg = $('#post_body_editor').wysiwyg()
  $('#pictureBtn').click( ->
    console.log this
  )

  $('form').submit( ->
    $('#post_body').val($('#post_body_editor').cleanHtml())
  )
