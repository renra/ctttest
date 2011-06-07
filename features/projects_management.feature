Feature: Projects management
  In order to track progress of the project I work on
  As a Project manager
  I want be able to manage projects

  Scenario: I should be able to create project
    Given the following managers:
      | First name | Last name | Email                   |
      | Petr       | Janda     | petr@cttinnovations.com |

	And I am logged in as "petr@cttinnovations.com"
    When I go to projects page
	And I follow "New project"
	And I fill in "Title" with "Joyncare"
	And I fill in "Client" with "CTT Innovations"
	And I fill in "Due date" with "2011-07-01"
	And I press "Save"
	
	Then I should be on projects page
	And I should see "Project was successfully created"
	And I should see "Joyncare"
	
  Scenario: I should be able to delete project
    Given the following managers:
      | First name | Last name | Email                   |
      | Petr       | Janda     | petr@cttinnovations.com |

    And the following projects:
      | Title    |
      | Joyncare |
  
	And I am logged in as "Sergey"
    When I go to Projects page
	And I follow "Joyncare"
	And I press "Delete"
	Then I should be on projects page
	And I should see "Project was successfully deleted"
	And I should not see "Joyncare"
	
	
  Scenario: I should be able to rename project
	#TO-DO
  
  

  
