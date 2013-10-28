module.exports = ->

  @Given /^I am on the homepage$/, (callback) ->
    @browser.get('http://localhost:9001').then ->
      callback()

  @Then /^I should see a pricing grid$/, (callback) ->
    @browser.findElements(@By.css ".pricing-option").then (elem) =>
      @expect(elem.length).to.equal 3
      callback()

  @When /^I see each of the pricing options$/, (callback) ->
    callback()

  @Then /^they should each have a buy button$/, (callback) ->
    @browser.findElements(@By.css ".pricing-option").then (options) =>
      @async.each options, (option, cb) =>
        option.isElementPresent(@By.css ".btn-primary").then (isPresent) =>
          @expect(isPresent).to.be.true
          cb()
      , () ->
        callback()