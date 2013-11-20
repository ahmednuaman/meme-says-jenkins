express = require 'express'
req = require 'request'
fs = require 'fs'
app = express()

jenkinsAPIEndPoint = 'https://builds.apache.org/api/json'
port = 8000

app.configure () ->
  app.use (request, response, next) ->
    response.header 'Access-Control-Allow-Origin', '*'
    response.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS'
    response.header 'Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With'

    next()

  app.use (request, response, next) ->
    if request.url.match /^\/api\.json/
      res = request.pipe req.get jenkinsAPIEndPoint

      res.pipe response

    else
      next()

  app.use '/', express.static __dirname + '/'

app.options '*', (request, response, next) ->
  response.send 200

app.get '*', (request, response, next) ->
  response.sendfile __dirname + '/index.html'

app.listen port, () ->
  console.log 'Listening on port: ' + port