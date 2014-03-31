// Generated by CoffeeScript 1.6.3
(function() {
  var handleApiGet, handleUnpaidVouchersGet, handleUsersGet, handleVouchersGet, _app;

  _app = null;

  module.exports = function(app) {
    _app = app;
    _app.get('/api', function(req, res) {
      return handleApiGet(req, res);
    });
    _app.get('/users', function(req, res) {
      return handleUsersGet(req, res);
    });
    _app.get('/unpaidVouchers', function(req, res) {
      return handleUnpaidVouchersGet(req, res);
    });
    return _app.get('/vouchers', function(req, res) {
      return handleVouchersGet(req, res);
    });
  };

  handleApiGet = function(req, res) {
    return res.send({
      _links: {
        self: {
          href: '/api'
        },
        openVouchers: {
          href: '/openVouchers'
        },
        vouchers: {
          href: '/vouchers'
        },
        users: {
          href: '/users'
        }
      }
    });
  };

  handleUsersGet = function(req, res) {
    return res.send({
      _links: {
        self: {
          href: '/users'
        }
      },
      _embedded: {
        users: []
      }
    });
  };

  handleUnpaidVouchersGet = function(req, res) {
    return res.send({
      _links: {
        self: {
          href: '/vouchers'
        }
      },
      _embedded: {
        vouchers: []
      }
    });
  };

  handleVouchersGet = function(req, res) {
    return res.send({
      _links: {
        self: {
          href: '/vouchers'
        }
      },
      _embedded: {
        vouchers: []
      }
    });
  };

}).call(this);

/*
//@ sourceMappingURL=rest_api.map
*/