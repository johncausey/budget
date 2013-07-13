# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  Morris.Line
    element: 'monthly-expenses-chart'
    data: $('#monthly-expenses-chart').data('expenses')
    xkey: 'date_added'
    ykeys: ['amount']
    labels: ['Amount']
