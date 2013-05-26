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
  showErrorAlert = (reason, detail) ->
    msg = ""
    if reason is "unsupported-file-type"
      msg = "Unsupported format " + detail
    else
      console.log "error uploading file", reason, detail
    $("<div class=\"alert\"> <button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button>" + "<strong>File upload error</strong> " + msg + " </div>").prependTo "#alerts"
  initToolbarBootstrapBindings()
