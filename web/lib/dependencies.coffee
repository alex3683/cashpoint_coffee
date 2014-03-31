define [
  'bower_components/angular/angular'
  './views/vouchers'
  './views/users'
], ( angular, vouchersModule, usersModule ) ->

  module = angular.module 'dependencies', [ 'ngRoute', vouchersModule.name, usersModule.name ]

  {
    moduleName: module.name
  }
