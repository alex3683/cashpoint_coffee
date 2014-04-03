define [
  'angular'
  './views/vouchers'
  './views/users'
], (angular, vouchersModule, usersModule) ->
  angular.module 'dependencies', [
    'ngRoute'
    vouchersModule.name
    usersModule.name
  ]