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
# Tests for toggle course section visibility in non edit mode in snap.
#
# @package    theme_snap
# @copyright  2015 Guy Thomas <gthomas@moodlerooms.com>
# @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later

@theme @theme_snap
Feature: When the moodle theme is set to Snap, teachers can toggle the visibility of course sections in read mode and
  edit mode.

  Background:
    Given the following config values are set as admin:
      | theme | snap |
    And the following "courses" exist:
      | fullname | shortname | category | format |
      | Course 1 | C1        | 0        | topics |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | admin | C1 | editingteacher |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |

  @javascript
  Scenario: In read mode, teacher hides section.
    Given I log in as "teacher1" (theme_snap)
    And I open the personal menu
    And I follow "Course 1"
    And I follow "Topic 2"
    Then "#section-2" "css_element" should exist
    And "#section-2.hidden" "css_element" should not exist
    And I click on "#section-2 .snap-visibility.snap-hide" "css_element"
    And I wait until "#section-2 .snap-visibility.snap-show" "css_element" exists
    Then "#section-2.hidden" "css_element" should exist
    # Note, the Not published to students message is in the 3rd element of the TOC because element 1 is section 0.
    And I should see "Not published to students" in the "#chapters li:nth-of-type(3)" "css_element"
    Given I click on "#section-2 .snap-visibility.snap-show" "css_element"
    And I wait until "#section-2 .snap-visibility.snap-hide" "css_element" exists
    Then "#section-2.hidden" "css_element" should not exist
    And I should not see "Not published to students" in the "#chapters li:nth-of-type(3)" "css_element"

  @javascript
  Scenario: In read mode, student cannot hide section.
    Given I log in as "student1" (theme_snap)
    And I open the personal menu
    And I follow "Course 1"
    And I follow "Topic 2"
    Then "#section-2 .snap-visibility" "css_element" should not exist
