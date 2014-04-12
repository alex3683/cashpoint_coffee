define([
  'angular'
  'moment'
], (ng, moment) ->
  module = ng.module('vouchers', [])

  module.controller('VouchersController', [
    '$scope', 'vouchers'
    ($scope, vouchersService) ->
      $scope.vouchers = []
      $scope.users = []
      $scope.newVoucher = {
        paidAt: moment().format('YYYY-MM-DD')
      }

      vouchersService.updateUsersInScope($scope)
      vouchersService.updateVouchersInScope($scope)

      $scope.addVoucher = () ->
        console.log( $scope.newVoucher)
        if( $scope.newVoucher &&
            $scope.newVoucher.amount )
          $scope.newVoucher.repaid = false
          $scope.newVoucher.repaidAt = null

          vouchersService.addVoucher($scope, ng.copy($scope.newVoucher))
            .catch((e)-> console.error(e))

          $scope.newVoucher = {
            paidAt: new Date()
          }

      $scope.deleteVoucher = (voucher) ->
        vouchersService.deleteVoucher($scope, voucher)
  ])


  module.service('vouchers', [ 'toQ', 'usersDb', 'vouchersDb', (toQ, usersDb, vouchersDb) ->
    options = { include_docs: true }

    fetchUsers = () ->
      usersDb.allDocs(options).then((_) -> _.rows || [])

    fetchVouchers = () ->
      vouchersDb.allDocs(options).then((_) -> _.rows || [])


    obj = {
      updateUsersInScope: (scope) ->
        fetchUsers()
          .then((rows) ->
            scope.$apply(() ->
              scope.users = rows.map((_) -> _.doc)
            )
          )

      updateVouchersInScope: (scope) ->
        fetchVouchers()
          .then((rows) ->
            scope.$apply(() ->
              scope.vouchers = rows.map((_) -> _.doc)
            )
          )

      deleteVoucher: (scope, voucher) ->
        vouchersDb.remove(voucher)
        obj.updateVouchersInScope(scope)

      addVoucher: (scope, voucher) ->
        toQ(() ->
          vouchersDb
            .post(voucher)
            .then(() -> obj.updateVouchersInScope(scope))
        )

      repayVoucher: (scope, voucher) ->
        voucher.repaid = true
        toQ(() ->
          usersDb
            .put(voucher)
            .then(() -> obj.updateVouchersInScope(scope))
        )
    }
  ])

  module
)