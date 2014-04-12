require.config(
  shim:
    angular:
      exports: 'angular'
    'angular-route':
      deps: [ 'angular' ]
    bootstrap:
      deps: [ 'jquery' ]
  paths:
    angular: 'bower_components/angular/angular'
    'angular-route': 'bower_components/angular-route/angular-route'
    bootstrap: 'bower_components/bootstrap/dist/js/bootstrap.min'
    jquery: 'bower_components/jquery/dist/jquery.min'
    moment: 'bower_components/momentjs/moment'
    pouchdb: 'bower_components/pouchdb/dist/pouchdb-nightly'
)

require([
  'angular'
  'angular-route'
  'pouchdb'
  'lib/dependencies'
  'config'
  'bootstrap'
], (ng, ngRoute, PouchDB, dependencies, config, unused) ->
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

  module = ng.module('main', [ dependencies.name, 'ngRoute' ])

  module.config([ '$routeProvider', ($routeProvider) ->
    routes.forEach (route) ->
      $routeProvider.when route.path,
        templateUrl: route.templateUrl
        controller: route.controller

    $routeProvider.otherwise
      redirectTo: routes[0].path
  ])

  module.controller('ApplicationController', [
    '$scope', '$location'
    ($scope, $location) ->
      $scope.routes = routes
      $scope.isActiveRoute = (route) ->
        $location.path() == route.path
  ])

  module.service('usersDb', () ->
    new PouchDB(config.usersDbName)
  )

  module.service('vouchersDb', () ->
    new PouchDB(config.vouchersDbName)
  )

  ng.element(document).ready(() ->
    ng.bootstrap(document, [ 'main' ])
  )
)