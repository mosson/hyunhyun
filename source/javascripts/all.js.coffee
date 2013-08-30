#= require_tree .

jQuery ->
  @update_display = _.throttle( (target) =>
    source = $(target).val()
    @$display = $(target).closest(".special-text-input").find(".display")

    str = source.split("")

    if str.length <= 0
      @$display.find("> span").html("")
    else
      @$display.find("> span:gt(#{str.length-1})").remove()

    _.each( str, (char, index) =>
      char = "&nbsp;" if /\s/.test char

      $span = @$display.find("> span").eq(index)
      if $span.length > 0
        if $span.text() == char
          return
        else
          $span.remove()

      $attach = $("<span class=\"move\" unselectable=\"on\">#{char}</span>")

      if @$display.find("> span").length > 0
        if  index == 0
          @$display.prepend( $attach )
        else
          @$display.find("> span").eq(index-1).after( $attach )
      else
        @$display.prepend( $attach )
    )
  , 60 )

  setInterval =>
    $(".special-text-input input").each (index, element) =>
      @update_display( element )

  , 60

  $(document).on "change keydown keyup", ".special-text-input input", (e) =>
    @update_display( e.currentTarget )