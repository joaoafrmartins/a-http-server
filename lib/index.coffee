config = require './config'

Server = require './server'

new Server (err, server) ->

  shutdown = server.shutdown or () ->

    process.exit 0

  config.kill.map (signal) ->

    process.on signal, shutdown
