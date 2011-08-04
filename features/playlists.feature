Feature: Playlists

  So that tracks can be grouped in lists
  As a listener
  I want to manage some playlists

  Background:
    Given I am signed in

  Scenario: List playlists
    Given a playlist named "Electro"
    And a playlist named "Reggae"
    When I am on the playlists page
    Then I should see "Electro" within "ul>li:first-child"
    And I should see "Reggae" within "ul>li:first-child+li"

  Scenario: Create playlist
    Given I am on the playlists page
    When I follow "Create playlist"
    And I fill in "Name" with "Electro"
    And I press "Create"
    Then I should see "Electro" within "ul>li:first-child"

  Scenario: Edit playlist
    Given a playlist named "Electro"
    And I am on the playlists page
    When I follow "Electro"
    And I fill in "Name" with "Rock"
    And I press "Save"
    Then I should see "Rock"
