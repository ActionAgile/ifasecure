Feature: audit
  Scenario: Contact detail form is hidden
    Given I am on the homepage
    Then I should not see a contact detail form

  Scenario: Enter contact details
    Given I am on the homepage
    When I click for a free audit
    Then I should see a contact detail form

  Scenario: Enter name
    Given I am on the homepage
    When I click for a free audit
    Then I should be able to enter my name
    And I should be able to enter my email
    And I should be able to enter my phone