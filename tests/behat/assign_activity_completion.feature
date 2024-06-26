@theme @theme_snap
Feature: View activity activity header and completion information in activities
  In order to have visibility of assignment completion requirements

  Background:
    Given I skip because "It will be reviewed on the ticket INT-19878"
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | student1 | Vinnie    | Student1 | student1@example.com |
      | teacher1 | Darrell   | Teacher1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | enablecompletion | showcompletionconditions |
      | Course 1 | C1        | 1                | 1                        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | student1 | C1     | student        |
      | teacher1 | C1     | editingteacher |
    And the following "activity" exists:
      | activity                 | assign        |
      | course                   | C1            |
      | idnumber                 | mh1           |
      | name                     | Music history |
      | section                  | 1             |
      | completion               | 1             |
      | grade[modgrade_type]     | point         |
      | grade[modgrade_point]    | 100           |

  Scenario: View automatic completion items as a teacher
    Given I am on the "Music history" "assign activity editing" page logged in as teacher1
    And I expand all fieldsets
    And I set the following fields to these values:
      | Completion tracking | Show activity as complete when conditions are met |
      | Require view        | 1                                                 |
      | completionusegrade  | 1                                                 |
      | completionsubmit    | 1                                                 |
    And I press "Save and display"
    Then ".activity-header" "css_element" should exist
    And "Music history" should have the "View" completion condition
    And "Music history" should have the "Make a submission" completion condition
    And "Music history" should have the "Receive a grade" completion condition

  @javascript
  Scenario: View automatic completion items as a student
    Given I am on the "Music history" "assign activity editing" page logged in as teacher1
    And I expand all fieldsets
    And I set the following fields to these values:
      | assignsubmission_onlinetext_enabled | 1                                                 |
      | Completion tracking                 | Show activity as complete when conditions are met |
      | Require view                        | 1                                                 |
      | completionusegrade                  | 1                                                 |
      | completionsubmit                    | 1                                                 |
    And I press "Save and display"
    And I log out
    And I am on the "Music history" "assign activity" page logged in as student1
    And the "View" completion condition of "Music history" is displayed as "done"
    And the "Make a submission" completion condition of "Music history" is displayed as "todo"
    And the "Receive a grade" completion condition of "Music history" is displayed as "todo"
    And I am on the "Music history" "assign activity" page
    And I press "Add submission"
    And I set the field "Online text" to "History of playing with drumsticks reversed"
    And I press "Save changes"
    And I press "Submit assignment"
    And I press "Continue"
    And the "View" completion condition of "Music history" is displayed as "done"
    And the "Make a submission" completion condition of "Music history" is displayed as "done"
    And the "Receive a grade" completion condition of "Music history" is displayed as "todo"
    And I log out
    And I am on the "Music history" "assign activity" page logged in as teacher1
    And I follow "View all submissions"
    And I click on "Grade" "link" in the "Vinnie Student1" "table_row"
    And I set the field "Grade out of 100" to "33"
    And I set the field "Notify student" to "0"
    And I press "Save changes"
    And I log out
    When I am on the "Music history" "assign activity" page logged in as student1
    Then the "View" completion condition of "Music history" is displayed as "done"
    And the "Make a submission" completion condition of "Music history" is displayed as "done"
    And the "Receive a grade" completion condition of "Music history" is displayed as "done"
