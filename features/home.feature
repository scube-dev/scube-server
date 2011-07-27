Feature: Home

  So that I can use scube efficiently
  As a listener
  I want to access the main features and valuable content from the homepage

  Scenario: Playlist access
    Given a playlist named "Electro"
    When I am on the home page
    Then I should see "Electro" within "ul>li"

  Scenario: Last tracks added
    Given the following tracks:
      | name        | created_at          |
      | Mega song 1 | 2011-07-27 19:13:42 |
      | Mega song 2 | 2011-07-27 19:58:57 |
    When I am on the home page
    Then I should see "Mega song 2" within "ul>li:first-child"
    And I should see "Mega song 1" within "ul>li:first-child+li"
