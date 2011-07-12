Feature: Playlists

  So that tracks can be grouped in lists
  As a listener
  I want to manage some playlists

  Scenario: List playlists
    Given Foo and Bar playlists
    When I am on the playlists page
    Then I should see "Foo" within "ul>li"
    And I should see "Bar" within "ul>li+li"

  Scenario: Create playlist
    Given I am on the playlists page
    When I follow "Create playlist"
    And I fill in "Name" with "Electro"
    And I press "Create"
    Then I should see "Electro" within "ul>li"

  Scenario: Edit playlist
    Given a playlist named Electro
    And I am on the playlists page
    When I follow "Electro"
    And I fill in "Name" with "Rock"
    And I press "Save"
    Then I should see "Rock"
