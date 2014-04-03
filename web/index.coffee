require.config
  paths:
    angular: 'bower_components/angular/angular'
    'angular-route': 'bower_components/angular-route/angular-route'
    pouchdb: 'bower_components/pouchdb/dist/pouchdb-nightly'
  shim:
    angular:
      exports: 'angular'
    'angular-route':
      deps: [ 'angular' ]

require [
  'angular'
  'angular-route'
  'pouchdb'
  'lib/dependencies'
  'config'
], (angular, angularRoute, PouchDB, dependencies, config) ->

  routes = [
    {
      path: '/vouchers',
      templateUrl: 'lib/views/vouchers.html'
      controller: 'VouchersController'
      title: 'Kassenzettelübersicht'
    }
    {
      path: '/users',
      templateUrl: 'lib/views/users.html'
      controller: 'UsersController'
      title: 'Benutzer'
    }
  ]

  module = angular.module 'main', [ dependencies.name, 'ngRoute' ]

  module.config [ '$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
    routes.forEach (route) ->
      $routeProvider.when route.path,
        templateUrl: route.templateUrl
        controller: route.controller

    $routeProvider.otherwise
      redirectTo: routes[0].path
  ]

  module.controller 'ApplicationController', [
    '$scope', '$location'
    ($scope, $location) ->
      $scope.routes = routes
      $scope.isActiveRoute = (route) ->
        $location.path() == route.path
  ]

  module.service 'usersDb', () -> new PouchDB config.usersDbName
  module.service 'vouchersDb', () -> new PouchDB config.vouchersDbName

  angular.element(document).ready () ->
    angular.bootstrap(document, [ 'main' ])