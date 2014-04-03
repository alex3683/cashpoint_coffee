express = require 'express'

webDir = __dirname + '/web'
app = express()

app.use express.bodyParser()
app.use express.directory(webDir)
app.use express.static(webDir)

app.listen 8666