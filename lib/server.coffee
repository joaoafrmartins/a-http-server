{ resolve } = require 'path'

{ waterfall } = require 'async'

express = require 'express'

cookies = require 'cookie-parser'

{ json, urlencoded } = require 'body-parser'

module.exports = class Server

  constructor: (next, config) ->

    config ?= require('a-npm-config')(

      resolve(__dirname, '.', 'config'),

      ['plugins', 'components', 'middleware']

    )

    Object.defineProperty @, "config", value: config

    Object.defineProperty @, "app", value: express()

    Object.defineProperty @, "http", value: @app.listen @config.port

    try

      @configure()

      waterfall @getPlugins(), (err) =>

        @loadComponents()

        process.emit "a-http-server:started"

        next err, @

    catch err then console.error err.message, err.stack

  configure: () =>

    options = @config.middleware

    @app.use json options.json

    @app.use urlencoded options.urlencoded

    @app.use cookies options.cookies.secret, options.cookies.options

  loadComponent: (middleware) =>

    if typeof middleware is "function"

      @app.use middleware @

    else throw new Error "invalid component: #{middlware}"

  loadComponents: () =>

    Object.keys(@config.components or {}).map (name) =>

      if @config.components[name]

        try

          component = require name

        catch err

          component = require resolve(

            "#{process.env.PWD}", "node_modules", "#{name}"

          )

        @loadComponent component

  getPlugins: () =>

    plugins = []

    Object.keys(@config.plugins or {}).map (name) =>

      if @config.plugins[name]

        try

          plugin = require name

        catch err

          plugin = require resolve(

            "#{process.env.PWD}", "node_modules", "#{name}"

          )

        plugins.push plugin.bind @

    plugins
