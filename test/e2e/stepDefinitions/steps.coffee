module.exports = ->

  @Given /^I am on the homepage$/, (callback) ->
    @browser.get('http://localhost:9001').then ->
      callback()

  @Then /^I should see a pricing grid$/, (callback) ->
    @browser.findElements(@By.css ".pricing-option").then (elem) =>
      @expect(elem.length).to.equal 3
      callback()