# This file is part of Moodle - http://moodle.org/
#
# Moodle is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Moodle is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Moodle.  If not, see <http://www.gnu.org/licenses/>.
#
# Tests for Snap personal menu.
#
# @package    theme_snap
# @copyright  Copyright (c) 2016 Moodlerooms Inc. (http://www.moodlerooms.com)
# @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later


@theme @theme_snap
Feature: When the moodle theme is set to Snap, students and teachers can open a personal menu which features a
  deadlines column showing deadlines for activities and the submission / attempt status thereof.

  Background:
    Given the following config values are set as admin:
      | theme | snap |
    And the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1 | 0 | 1 |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |

  @javascript
  Scenario: Student sees correct submission status against deadlines when 1 out of 2 assignments are submitted by student.
    Given the following "activities" exist with relative dates:
      | activity | course | idnumber | name             | intro             | assignsubmission_onlinetext_enabled | assignfeedback_comments_enabled | section | duedate                      |
      | assign   | C1     | assign1  | Test assignment1 | Test assignment 1 | 1                                   | 1                               | 1       | the timestamp of tomorrow    |
      | assign   | C1     | assign2  | Test assignment2 | Test assignment 2 | 1                                   | 1                               | 1       | the timestamp of next week   |
    And I log in as "student1" (theme_snap)
    And I open the personal menu
    And I should see "Not Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:first-of-type" "css_element"
    And I should see "Not Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:nth-of-type(2)" "css_element"
    And I follow "Course 1"
    And I follow "Topic 1"
    And I wait until "#section-1" "css_element" is visible
    And I should see "Test assignment1"
    And I follow "Not Submitted"
    When I press "Add submission"
    And I set the following fields to these values:
      | Online text | I'm the student submission |
    And I press "Save changes"
    And I press "Submit assignment"
    And I press "Continue"
    And I open the personal menu
    And I should see "Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:first-of-type" "css_element"
    And I should not see "Not Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:first-of-type" "css_element"
    And I should see "Not Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:nth-of-type(2)" "css_element"

  @javascript
  Scenario: Users see no submission status data against deadlines for hidden activities.
    Given the following "activities" exist with relative dates:
      | activity | course | idnumber | name             | intro             | assignsubmission_onlinetext_enabled | assignfeedback_comments_enabled | section | duedate                      |
      | assign   | C1     | assign1  | Test assignment1 | Test assignment 1 | 1                                   | 1                               | 1       | the timestamp of tomorrow    |
      | assign   | C1     | assign2  | Test assignment2 | Test assignment 2 | 1                                   | 1                               | 1       | the timestamp of next week   |
    And I log in as "teacher1" (theme_snap)
    And I open the personal menu
    And I should see "Test assignment1"
    And I should see "Test assignment2"
    And I log out (theme_snap)
    And I log in as "student1" (theme_snap)
    And I open the personal menu
    And I should see "Test assignment1"
    And I should see "Test assignment2"
    And I log out (theme_snap)
    And I log in as "admin" (theme_snap)
    And I click on "#admin-menu-trigger" "css_element"
    # Core code throws errors from the Calendar and Upcoming Events block, so hide those too.
    And I navigate to "Manage blocks" node in "Site administration > Plugins > Blocks"
    And I click on "Hide" "link" in the "Calendar" "table_row"
    And I click on "Hide" "link" in the "Upcoming events" "table_row"
    And I click on "#admin-menu-trigger" "css_element"
    And I navigate to "Manage activities" node in "Site administration > Plugins > Activity modules"
    And I click on "Hide" "link" in the "Assignment" "table_row"
    And I log out (theme_snap)
    And I log in as "teacher1" (theme_snap)
    And I open the personal menu
    And I should see "You have no upcoming deadlines"
    And I log out (theme_snap)
    And I log in as "student1" (theme_snap)
    And I open the personal menu
    And I should see "You have no upcoming deadlines"

  @javascript
  Scenario: Student and Teacher  see no submission status data against deadlines for disabled modules.
    Given the following "activities" exist with relative dates:
      | activity | course | idnumber | name             | intro             | assignsubmission_onlinetext_enabled | assignfeedback_comments_enabled | section | duedate                      |
      | assign   | C1     | assign1  | Test assignment1 | Test assignment 1 | 1                                   | 1                               | 1       | the timestamp of tomorrow    |
      | assign   | C1     | assign2  | Test assignment2 | Test assignment 2 | 1                                   | 1                               | 1       | the timestamp of next week   |
    Given the following config values are set as admin:
      | theme | snap |
    And I log in as "teacher1" (theme_snap)
    And I open the personal menu
    And I should not see "Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:first-of-type" "css_element"
    And I should not see "Not Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:first-of-type" "css_element"
    And I should not see "Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:nth-of-type(2)" "css_element"
    And I should not see "Not Submitted" in the "#snap-personal-menu-deadlines div.snap-media-object:nth-of-type(2)" "css_element"
