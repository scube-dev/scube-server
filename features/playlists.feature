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
