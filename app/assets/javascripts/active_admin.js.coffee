#= require jquery
#= require jquery_ujs
#= require chosen-jquery
#= require best_in_place
#= require active_admin/base
#= require jquery_nested_form

jQuery ->
  $('.best_in_place').best_in_place()
  $('.chosen-input').chosen
    allow_single_deselect: false
    no_results_text: 'Ничего не найдено...'


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

