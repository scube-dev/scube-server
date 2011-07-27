Feature: Home

  So that I can use scube efficiently
  As a listener
  I want to access the main features and valuable content from the homepage

  Scenario: Playlist access
    Given a playlist named "Electro"
    When I am on the home page
    Then I should see "Electro" within "ul>li"
