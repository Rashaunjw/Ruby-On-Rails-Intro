Feature: find movies with same director
  As a moviegoer
  So that I can find movies with similar themes
  I want to find movies by the same director

  Background:
    Given the following movies exist:
      | title              | rating | release_date | director          |
      | Alien              | R      | 1979-05-25   | Ridley Scott      |
      | Blade Runner       | R      | 1982-06-25   | Ridley Scott      |
      | Star Wars          | PG     | 1977-05-25   | George Lucas      |
      | THX-1138           | R      | 1971-03-11   | George Lucas      |

  Scenario: add director to existing movie
    Given I am on the edit page for "Alien"
    When I fill in "Director" with "Ridley Scott"
    And I press "Update Movie"
    Then I should be on the movie page for "Alien"
    And I should see "Ridley Scott"

  Scenario: find movies with same director
    Given I am on the movie page for "Alien"
    When I follow "Find Movies With Same Director"
    Then I should be on the Similar Movies page for "Alien"
    And I should see "Alien"
    And I should see "Blade Runner"
    And I should not see "Star Wars"
    And I should not see "THX-1138"

  Scenario: director has no info
    Given I am on the movie page for "Star Wars"
    And I follow "Find Movies With Same Director"
    Then I should be on the movies page
    And I should see "Star Wars has no director info"



