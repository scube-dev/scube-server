Feature: User

  So that I can use the application
  As a visitor
  I want to register

  Scenario: User registration
    Given I go to the home page
    When I follow the sign up link
    And I fill in the sign up form
    Then I should be redirected to the home page

  Scenario: User can't register twice with the same email address
    Given a user with "unique@example.net" email address exists
    When I register with "unique@example.net" email address
    Then I should see "Email has already been taken"
