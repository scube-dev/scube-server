Feature: User

  So that I can use the application
  As a visitor
  I want to register

  Scenario: User registration
    Given I go to the home page
    When I follow the sign up link
    And I fill in the sign up form
    Then I should be redirected to the home page
