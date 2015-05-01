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

      load = (middlware) =>

        if typeof middlware is "function"

          @app.use middlware @

        else throw new Error "invalid component: #{middlware}"

      Object.keys(config.plugins or {}).map (plugin) =>

        plugin = require plugin

        plugins.push plugin.bind @

      waterfall plugins, (err) =>

        Object.keys(config.components or {}).map (name) =>

          try

            component = require name

          catch err

            component = require "#{process.env.PWD}/node_modules/#{name}"

          load component

        next err, @

    catch err then console.error err.message, err.stack
