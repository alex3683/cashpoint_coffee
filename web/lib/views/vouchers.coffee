define [
  'angular'
], ( angular ) ->
  module = angular.module 'vouchers', []

  module.controller 'VouchersController', [
    '$scope', 'vouchersDb'
    ($scope, vouchersDb) ->

  ]

  module