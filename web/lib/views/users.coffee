define [
  'angular'
], ( angular ) ->
  module = angular.module 'users', []

  module.controller 'UsersController', [
    '$scope', 'Users'
    ($scope, usersService) ->

      $scope.users = [];
      $scope.newUserName = null

      usersService.updateUsers($scope)

      $scope.deleteUser = ( user ) -> usersService.deleteUser($scope, user)

      $scope.addNewUser = () ->
        if( $scope.newUserName )
          user = { name: $scope.newUserName }
          $scope.newUserName = null;
          usersService.addUser($scope, user)
  ]



  module.service 'Users', [ 'usersDb', ( usersDb ) ->
    options = { include_docs: true }

    fetchUsers = () ->
      usersDb.allDocs( options ).then (resp) ->
        if( resp.total_rows )
          return resp.rows

        # posting some initial date for testing purposes
        # TODO remove me later when users can be added manually
        usersDb
          .bulkDocs( { docs: [
            { name: 'Alex' }
            { name: 'Katja' }
          ] } )
          .then( () -> usersDb.allDocs( options ) )
          .then( (resp) -> resp.rows )

    obj = {
      updateUsers: (scope) ->
        fetchUsers()
          .then( (rows) ->
            scope.$apply () -> scope.users = rows.map (row) -> row.doc
          )

      deleteUser: (scope, user) ->
        usersDb.remove( user )
        obj.updateUsers(scope)

      addUser: (scope, user) ->
        usersDb
          .post( user )
          .then( () -> obj.updateUsers( scope ) )
    }
  ]

  module