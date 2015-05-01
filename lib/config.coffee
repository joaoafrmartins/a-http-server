merge = require 'lodash.merge'

config = require '../default/config'

module.exports = () ->

  try

    return merge config, require "#{process.env.PWD}/config"

  catch err

    Object.keys(process.env).map (key) ->

      if key.match(/^npm_package_config_/) isnt null

        value = process.env[key]

        key = key.replace(/^npm_package_config_/, '').split "_"

        if key[key.length-1].match(/[0-9]+$/) isnt null

          type = key.shift()

          index = JSON.parse key.pop()

          type = [type].concat(key).join "_"

          config[type] ?= []

          config[type][index] = value

        else

          type = key.shift()

          if ['plugins', 'components'].indexOf(type) isnt -1

            key = key.join "-"

            config[type][key] = JSON.parse value

          else

            config[type] = value

    return merge config