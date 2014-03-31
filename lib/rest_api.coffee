_app = null

module.exports = (app) ->
  _app = app
  _app.get '/api', (req,res) -> handleApiGet( req, res )
  _app.get '/users', (req,res) -> handleUsersGet( req, res )
  _app.get '/unpaidVouchers', (req,res) -> handleUnpaidVouchersGet( req, res )
  _app.get '/vouchers', (req,res) -> handleVouchersGet( req, res )

handleApiGet = (req, res) ->
  res.send {
    _links: {
      self: href: '/api'
      openVouchers: href: '/openVouchers'
      vouchers: href: '/vouchers'
      users: href: '/users'
    }
  }

handleUsersGet = (req, res) ->
  res.send {
    _links: {
      self: href: '/users'
    }
    _embedded: {
      users: [
        # get me some users and embed them here
      ]
    }
  }

handleUnpaidVouchersGet = (req, res) ->
  res.send {
    _links: {
      self: href: '/vouchers'
    }
    _embedded: {
      vouchers: [
        # get me some vouchers and embed them here
      ]
    }
  }

handleVouchersGet = (req, res) ->
  res.send {
    _links: {
      self: href: '/vouchers'
    }
    _embedded: {
      vouchers: [
        # get me some vouchers and embed them here
      ]
    }
  }


