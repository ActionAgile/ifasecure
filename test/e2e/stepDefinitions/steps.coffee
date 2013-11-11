module.exports = ->

  @Given /^I am on the homepage$/, (callback) ->
    @browser.get('http://dev.ifasecure.co.uk:9002').then ->
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

  @Then /^I should see an emphasised pricing option$/, (callback) ->
    @browser.findElements(@By.css ".pricing-option-emph").then (elem) =>
      @expect(elem.length).to.equal 1
      callback()

  @Then /^it should have a buy button$/, (callback) ->
    @browser.findElements(@By.css ".pricing-option-emph").then (options) =>
      @async.each options, (option, cb) =>
        option.isElementPresent(@By.css ".btn-primary").then (isPresent) =>
          @expect(isPresent).to.be.true
          cb()
      , () ->
        callback()


  @When /^I click for a free audit$/, (callback) ->
    @browser.findElement(@By.css '.free-audit-button').click()
    callback()

  @Then /^I should see a contact detail form$/, (callback) ->
    @browser.findElement(@By.id 'auditModal').isDisplayed()
    .then (isDisplayed) =>
      @expect(isDisplayed).to.be.true
      callback()

  @Then /^I should not see a contact detail form$/, (callback) ->
    @browser.findElement(@By.id 'auditModal').isDisplayed()
    .then (isDisplayed) =>
      @expect(isDisplayed).to.be.false
      callback()

  @Then /^I should be able to enter my (.*)$/, (field, callback) ->
    @browser.findElement(@By.id 'auditModal').then (auditModal) =>
      auditModal.isElementPresent(@By.name field).then (isPresent) =>
        @expect(isPresent).to.be.true
        callback()
