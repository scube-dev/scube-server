Feature: User

  So that I can manage my own content
  As a listener
  I want the application to require a valid authentication

  Scenario: Unauthenticated user
    Given I am not signed in
    When I go to the home page
    Then I should be redirected to the sign in page

  Scenario: User authentication
    Given I am not signed in
    When I go to the home page
    Then I should be redirected to the sign in page
    When I submit valid credentials
    Then I should be redirected to the home page

  Scenario: User registration
    Given I go to the home page
    When I follow the sign up link
    And I fill in the sign up form
    Then I should be redirected to the home page
