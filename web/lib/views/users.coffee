define([
  'angular'
], (ng) ->
  module = ng.module('users', [])

  module.controller('UsersController', [
    '$scope', 'users'
    ($scope, usersService) ->
      $scope.users = []
      $scope.newUser = {}
      $scope.editingUser = null

      editingUserBackup = null

      usersService.updateUsersInScope($scope)

      $scope.deleteUser = (user) ->
        usersService.deleteUser($scope, user)

      $scope.addUser = () ->
        if( $scope.newUser && $scope.newUser.name )
          usersService.addUser($scope, ng.copy($scope.newUser))
            .then(
              () ->
                $scope.newUser = {}
                $scope.newUserForm.$setPristine(true)
              (e) -> console.error(e)
            )

      $scope.editUser = (user) ->
        editingUserBackup = ng.copy(user)
        $scope.editingUser = user

      $scope.editUserApply = () ->
        usersService.updateUser($scope, ng.copy($scope.editingUser))
          .finally(() -> $scope.editingUser = editingUserBackup = null)

      $scope.editUserCancel = () ->
        $scope.editingUser.name = editingUserBackup.name
        $scope.editingUser = editingUserBackup = null

      $scope.editKeyUp = (event) ->
        switch event.keyCode
          when 13 then $scope.editUserApply()
          when 27 then $scope.editUserCancel()

  ])


  module.service('users', [ 'toQ', 'usersDb', (toQ, usersDb) ->
    options = { include_docs: true }

    fetchUsers = () ->
      usersDb.allDocs(options).then((_) -> _.rows || [])

    obj = {
      updateUsersInScope: (scope) ->
        fetchUsers()
          .then((rows) ->
            scope.$apply(() ->
              scope.users = rows.map((_) -> _.doc))
          )

      deleteUser: (scope, user) ->
        usersDb.remove(user)
        obj.updateUsersInScope(scope)

      addUser: (scope, user) ->
        toQ(() ->
          usersDb
            .post(user)
            .then(() -> obj.updateUsersInScope(scope))
        )

      updateUser: (scope, user) ->
        toQ(() ->
          usersDb
            .put(user)
            .then(() -> obj.updateUsersInScope(scope))
        )
    }
  ])


  module.directive('cpFocusOn', [ '$timeout', ($timeout) ->
    (scope, element, attrs) ->
      scope.$watch(attrs.cpFocusOn, (newValue, oldValue) ->
        if newValue == true && newValue != oldValue
          $timeout(() ->
            element[0].focus())

      )
  ])

  module
)