{ resolve, join } = require 'path'

{ readdirSync } = require 'fs'

{ waterfall } = require 'async'

express = require 'express'

module.exports = class Server

  constructor: (next, config) ->

    plugins = []

    if config is undefined then config = require('./config')()

    Object.defineProperty @, "app", value: express()

    Object.defineProperty @, "config", value: config

    Object.defineProperty @, "http", value: @app.listen @config.port

    try

      Object.keys(config.plugins or {}).map (plugin) =>

        plugin = require plugin

        plugins.push plugin.bind @

      waterfall plugins, (err) =>

        Object.keys(config.components or {}).map (component) =>

          component = require component

          @app.use component @

        next err, @

    catch err then console.error err.message, err.stack
