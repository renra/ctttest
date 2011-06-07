Feature: Todo lists management
  In order to track what need to be done
  As a Project manager or Developer
  I want to be able to manage todo list

  Background:
    Given the following developers:
      | First name | Last name | Email                     |
      | Sergey     | Goncharov | sergey@cttinnovations.com |

	And the following projects:
	  | Title    |
	  | Joyncare |
	
	And I am logged in as "Sergey"
	
  Scenario: I should be able to create to-do list
  	And I am on "Joyncare" project page
    
    Then I should see "To-do Lists"
    When I click "Add To-do List"
    And I fill in "Title" with "Project requirements"
    And I fill in "Description" with "All necessary tasks to be done for project requirements analysis."
	And I fill in "Due data" with "2011-08-01"
	And I press "Save"

  	Then I should be on "Joyncare" project page
    And I should see "To-Do list was successfully created"
    And I should see "Project requirements"

  Scenario: I should be able to delete to-do list if there is no task inside

  Scenario: I should be able to mark to-do list as finished in case there are all tasks inside finished

  Scenario: I should be able to re-open to-do list after it was finished
    

  
  
