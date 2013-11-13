assert = require 'assert'
webdriver = require 'selenium-webdriver'
protractor = require 'protractor'
expect = require('chai').expect
async = require 'async'

worldDefinition = () ->

  ptor = null
  driver = null

  class World
    constructor: (callback) ->
      @browser = ptor
      @By = protractor.By
      @assert = assert
      @expect = expect
      @async = async
      callback()
  seleniumUrl = "http://192.168.1.72:4444/wd/hub"
  capabilities = webdriver.Capabilities.firefox()
  if process.env.CI is 'drone'
    seleniumUrl = "http://localhost:4445/wd/hub"
    capabilities.merge
      username: process.env.SAUCE_USERNAME
      accessKey: process.env.SAUCE_ACCESS_KEY
      name: 'ifa-secure e2e tests'
      browserName: 'Firefox'
      platform: 'Windows 7'
      'record-video': true
      'tunnel-identifier': process.env.DRONE_BUILD_NUMBER

  @BeforeFeatures (event, callback) ->
    driver = new webdriver.Builder().
    usingServer(seleniumUrl).
    withCapabilities(capabilities).build()

    ptor = protractor.wrapDriver driver
    ptor.driver.manage().timeouts().setScriptTimeout 10000
    
    callback()

  @AfterFeatures (event, callback) ->
    driver.quit().then (err) ->
      callback err

  @World = World

module.exports = worldDefinition