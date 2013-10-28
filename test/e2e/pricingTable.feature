Feature: pricing Table
  Scenario: View pricing table
    Given I am on the homepage
    Then I should see a pricing grid

  Scenario: Check buy buttons are visible
    Given I am on the homepage
    When I see each of the pricing options
    Then they should each have a buy button