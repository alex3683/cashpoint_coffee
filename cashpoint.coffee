express = require 'express'
restApi = require './lib/rest_api'

webDir = __dirname + '/web'
app = express()

restApi app

app.use express.bodyParser()
app.use express.directory(webDir)
app.use express.static(webDir)

app.listen 8666