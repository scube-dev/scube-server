Feature: Tracks

  So that I can listen music
  As a listener
  I want to add, manage and listen some tracks

  Background:
    Given I am signed in

  Scenario: Show track
    Given a track named "Mega song"
    When I go to the track page for "Mega song"
    Then I should see "Mega song" within "h1"

  Scenario: Create track
    Given I am on the home page
    When I follow "Add a track"
    And I fill in "Name" with "Mega song"
    And I attach the file "features/fixtures/test.mp3" to "File"
    And I press "Upload"
    Then I should see "Mega song" within "h1"

  Scenario: Listen track
    Given a track named "Mega song"
    When I go to the track page for "Mega song"
    Then I should see an audio player
    And it should provide an audio stream for "Mega song"
