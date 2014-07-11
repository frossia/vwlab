#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require chosen-jquery
#= require best_in_place
#= require activeadmin_settings
#= require jquery_nested_form
#= require jquery.ui.nestedSortable
#= require sortable_tree/initializer

jQuery ->
  $('.best_in_place').best_in_place()
  $('.chosen-input').chosen
    allow_single_deselect: false
    no_results_text: 'Ничего не найдено...'

  $('#select_all_generations').click ->
    $('.destroy_generation').prop("checked", true)
  $('#deselect_all_generations').click ->
    $('.destroy_generation').prop("checked", false)




#window.NestedFormEvents::insertFields = (content, assoc, link) ->
#  $tr = $(link).closest("tr")
#  $(content).insertBefore $tr

$(document).on "nested:fieldAdded", (event) ->

  # this field was just inserted into your form
  field = event.field

  # it's a jQuery object already! Now you can find date input
  dateField = field.find(".chosen-input")

  # and activate datepicker on it
#  dateField.chosen
  $('.chosen-input').chosen
    allow_single_deselect: false
    no_results_text: 'Ничего не найдено...'

