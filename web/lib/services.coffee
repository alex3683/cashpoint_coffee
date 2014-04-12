define([
  'angular'
], (ng) ->

  ng.module( 'services', [] )
    .service( 'toQ', [ '$q', ($q) ->
      (func) -> $q.when(func())
    ] )

)