define [
  'angular'
  './services'
  './views/vouchers'
  './views/users'
], (ng, modules...) ->
  ng.module('dependencies', modules.map((_)->_.name))