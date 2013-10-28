assert = require 'assert'
webdriver = require 'selenium-webdriver'
expect = require('chai').expect
worldDefinition = () ->

  driver = null

  class World
    constructor: (callback) ->
      @browser = driver
      @By = webdriver.By
      @assert = assert
      @expect = expect
      callback()

  capabilities = webdriver.Capabilities.firefox()
  # .merge
  #   username: process.env.SAUCE_USERNAME
  #   accessKey: process.env.SAUCE_ACCESS_KEY
  #   name: 'gint-security protractor test'
  #   browserName: 'Chrome'
  #   platform: 'Windows 7'
  #   'record-video': true
  #   'tunnel-identifier': process.env.DRONE_BUILD_NUMBER

  @BeforeFeatures (event, callback) ->
    driver = new webdriver.Builder().
    usingServer('http://192.168.1.72:4444/wd/hub').
    withCapabilities(capabilities).build()

    callback()

  @AfterFeatures (event, callback) ->
    driver.quit().then (err) ->
      callback err

  @World = World

module.exports = worldDefinition