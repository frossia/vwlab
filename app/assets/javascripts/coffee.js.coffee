#= require chosen-jquery
#= require best_in_place
#= require jquery_nested_form

jQuery ->
  $('.best_in_place').best_in_place()
  $('.chosen-input').chosen
    allow_single_deselect: false
    no_results_text: 'Ничего не найдено...'

#---------------------------------------------------------------------------------------------

  $('.catalog_post').change ->
    $("#notice_message .alert").show()
    $("#notice_message").show()
    $("#notice_message").addClass('bounceInDown animated')
    $("#notice_message p").html('Загрузка...')
    $.ajax({
      type: "PATCH",
      url: "/items/"+$(this).data("id"),
      data: { item: {catalog_id: $(this).val()}},
      ajaxStart: ->

      success: (data) ->
        $("#notice_message").fadeIn()
        $("#notice_message p").html("Товру <b>#{data.item.name}</b> присвоена категория <b>#{data.catalog.name}</b>")
        $("#notice_message").delay(5800).fadeOut()
      error: ->
        $("#notice_message").fadeIn()
        $("#notice_message p").html("Ошибка!")
        $("#notice_message").delay(5800).fadeOut()
    })


#---------------------------------------------------------------------------------------------

  $("#new_reception").on("ajax:success", (e, data, status, xhr) ->

    $("#reception.modal").modal('hide')
    $("#notice_message").fadeIn()
    $("#notice_message p").html("Спасибо <b>#{jQuery.parseJSON(xhr.responseText).name}</b>! Ваше сообщение отправлено.")
    $("#notice_message").delay(5800).fadeOut

  ).on "ajax:error", (e, xhr, settings, exception) ->
    $(".modal-body .notice").html("Ошибка! Проверьте правильность заполнения всех полей.")


#---------------------------------------------------------------------------------------------

  $('#accordion').collapse ->
    toggle: false

  toggleChevron = (e) ->
    $(e.target).prev("#header-cat").find("i.indicator").toggleClass "fa-plus-square-o fa-minus-square-o"
  $("#accordion").on "hidden.bs.collapse", toggleChevron
  $("#accordion").on "shown.bs.collapse", toggleChevron


  $('#collaps_in').click ->
    $('[data-collapspanel]').collapse('show')
    $('#header-cat').attr('data-toggle', '')
  $('#collaps').click ->
    $('[data-collapspanel]').collapse('hide')
    $('#header-cat').attr('data-toggle', 'collapse')
#    toggleChevron

#---------------------------------------------------------------------------------------------

#  $("#search_results").show ->
#    $("#search_results").addClass('flipInY animated')
#  $("#search_results").hide ->
#    $("#search_results").removeClass('flipInY animated')
  $('#search').focus ->
    $("#search_results").css('display': 'block')
  $('#search').focusout ->
    window.setTimeout (->
      $("#search_results").css('display': 'none')
      return
    ), 200

  $('#search').keyup ->
    search = $('#search').val()
    $("#search_results").css('display': 'none')
    if search.length > 1
      $("#search_results").css('display': 'block')
      $.ajax({
        type: "GET",
        url: "/items",
        data: {search: search},
        contentType: 'json',
        dataType: 'json',

        success: (data) ->
          $("#search_results").html('')
          if data.length == 0
            $("#search_results").addClass('fadeInUp animated')
            $("#search_results").append(
              $('<h5/>', 'class': 't-c', text: 'Ничего не найдено...')
            )

          $.each data, (index, element) ->

            $("#search_results").addClass('fadeInUp animated')
            $("#search_results").append(

              $("<a/>", {'class': "result_link animate_it", 'href': '/items/'+element.id}).append(

                $("<h5/>", text: index+1 + ". " + element.name )
                $("<small/>", text: jQuery.trim(element.description).substring(0, 100).split(" ").slice(0, -1).join(" ") + "..." )
                $("<div/>", "class": 't-r').append(
                  $('<i/>').append(
                    $("<small/>", "class": 'muted', text: element.catalog)
                  )
                )
              )

              $("<hr/>")

            )

            if index > 4
              $("#search_results").append(
                $('<div/>', 'class': 't-c',).append(
                  $("<button/>", text: 'Еще результаты...', 'class': 'btn btn-link result_link t-c', 'type': "submit")
              ))
              return false

          $.each $(".animate_it"), (i, el) ->
            $(el).css "opacity", "0"
            setTimeout (->
              $(el).css "opacity", "1"
              $(el).addClass "fadeInUp animated-05"
            ), 0 + (i * 100)

        error: ->
          $("#search_results").html(
            $('<h5/>', 'class': 't-c', text: 'Ничего не найдено...')
          )
      })
