# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  showPoundsHelper = ()->
    hint = $(".hint-block")
    hint.text("= £" + (hint.siblings("input").val()/100).toFixed(2) )

  appendToCheckout = (productId, productFields)->
    $("#checkout-table tbody").append("<tr data-id=#{productId}> <td class='quantity'> 1 </td> </tr>")
    $("#checkout-table tbody tr:last").append(productFields)

  increaseQuantity = (quantityElement)->
    quantityElement.text( parseInt( quantityElement.text() ) + 1 )

  scannedItems = []

  # showPoundsHelper();

  $(".pennies-input").on 'keyup change', ->
    showPoundsHelper();

  $(".scan-item").click ->
    productId = $(this).data('id')

    if scannedItems.indexOf(productId) > -1
      increaseQuantity( $("tr[data-id=#{productId}] .quantity") )
    else
      appendToCheckout( productId, $(this).parent().siblings("td:lt(4)").clone() )

    scannedItems.push(productId)

    $.getJSON("/products/checkout", product_ids: scannedItems).success (data)->
      $("#checkout-price").text(data["total"])
