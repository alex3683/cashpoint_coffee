
require.config
  shim:
    'bower_components/angular/angular':
      exports: 'angular'

require [
  'bower_components/angular/angular'
  'lib/dependencies'
], ( angular, dependencies ) ->

  require [
    'bower_components/angular-route/angular-route'
  ], () ->

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

    module = angular.module 'main', [ dependencies.moduleName, 'ngRoute' ]

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
        $scope.isActiveRoute = ( route ) ->
          $location.path() == route.path
    ]

    angular.element(document).ready () ->
      angular.bootstrap( document, [ 'main' ] )