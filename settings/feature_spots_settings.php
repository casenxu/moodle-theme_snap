<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

defined('MOODLE_INTERNAL') || die;// Main settings.

$snapsettings = new admin_settingpage('themesnapfeaturespots', get_string('featurespots', 'theme_snap'));

// Feature spots settings.
// Feature spot instructions.
$name = 'theme_snap/fs_instructions';
$heading = new lang_string('featurespots', 'theme_snap');
$description = get_string('featurespotshelp', 'theme_snap');
$setting = new admin_setting_heading($name, $heading, $description);
$snapsettings->add($setting);

// Feature spots heading.
$name = 'theme_snap/fs_heading';
$title = new lang_string('featurespotsheading', 'theme_snap');
$description = '';
$setting = new admin_setting_configtext($name, $title, $description, '', PARAM_RAW, 50);
$snapsettings->add($setting);

// Feature spot images.
$name = 'theme_snap/fs_one_image';
$title = new lang_string('featureoneimage', 'theme_snap');
$opts = array('accepted_types' => array('.png', '.jpg', '.gif', '.webp', '.svg'));
$setting = new admin_setting_configstoredfile($name, $title, $description, 'fs_one_image', 0, $opts);
$snapsettings->add($setting);

$name = 'theme_snap/fs_two_image';
$title = new lang_string('featuretwoimage', 'theme_snap');
$opts = array('accepted_types' => array('.png', '.jpg', '.gif', '.webp', '.svg'));
$setting = new admin_setting_configstoredfile($name, $title, $description, 'fs_two_image', 0, $opts);
$snapsettings->add($setting);

$name = 'theme_snap/fs_three_image';
$title = new lang_string('featurethreeimage', 'theme_snap');
$opts = array('accepted_types' => array('.png', '.jpg', '.gif', '.webp', '.svg'));
$setting = new admin_setting_configstoredfile($name, $title, $description, 'fs_three_image', 0, $opts);
$snapsettings->add($setting);

// Feature spot titles.
$name = 'theme_snap/fs_one_title';
$title = new lang_string('featureonetitle', 'theme_snap');
$description = '';
$setting = new admin_setting_configtext($name, $title, $description, '');
$snapsettings->add($setting);

$name = 'theme_snap/fs_two_title';
$title = new lang_string('featuretwotitle', 'theme_snap');
$setting = new admin_setting_configtext($name, $title, $description, '');
$snapsettings->add($setting);

$name = 'theme_snap/fs_three_title';
$title = new lang_string('featurethreetitle', 'theme_snap');
$setting = new admin_setting_configtext($name, $title, $description, '');
$snapsettings->add($setting);

// Feature spot title links.

$name = 'theme_snap/fs_one_title_link';
$title = new lang_string('featureonetitlelink', 'theme_snap');
$description = new lang_string('featuretitlelinkdesc', 'theme_snap');
$setting = new admin_setting_configtext($name, $title, $description, '');
$snapsettings->add($setting);

$name = 'theme_snap/fs_two_title_link';
$title = new lang_string('featuretwotitlelink', 'theme_snap');
$description = new lang_string('featuretitlelinkdesc', 'theme_snap');
$setting = new admin_setting_configtext($name, $title, $description, '');
$snapsettings->add($setting);

$name = 'theme_snap/fs_three_title_link';
$title = new lang_string('featurethreetitlelink', 'theme_snap');
$description = new lang_string('featuretitlelinkdesc', 'theme_snap');
$setting = new admin_setting_configtext($name, $title, $description, '');
$snapsettings->add($setting);

// Feature spot title checkbox new window links.

$name = 'theme_snap/fs_one_title_link_cb';
$title = new lang_string('featureonetitlecb', 'theme_snap');
$description = new lang_string('featuretitlecbdesc', 'theme_snap');
$setting = new admin_setting_configcheckbox($name, $title, $description, 0);
$snapsettings->add($setting);

$name = 'theme_snap/fs_two_title_link_cb';
$title = new lang_string('featuretwotitlecb', 'theme_snap');
$description = new lang_string('featuretitlecbdesc', 'theme_snap');
$setting = new admin_setting_configcheckbox($name, $title, $description, 0);
$snapsettings->add($setting);

$name = 'theme_snap/fs_three_title_link_cb';
$title = new lang_string('featurethreetitlecb', 'theme_snap');
$description = new lang_string('featuretitlecbdesc', 'theme_snap');
$setting = new admin_setting_configcheckbox($name, $title, $description, 0);
$snapsettings->add($setting);

// Feature spot text.
$name = 'theme_snap/fs_one_text';
$description = '';
$title = new lang_string('featureonetext', 'theme_snap');
$setting = new admin_setting_configtextarea($name, $title, $description, '');
$snapsettings->add($setting);

$name = 'theme_snap/fs_two_text';
$title = new lang_string('featuretwotext', 'theme_snap');
$setting = new admin_setting_configtextarea($name, $title, $description, '');
$snapsettings->add($setting);

$name = 'theme_snap/fs_three_text';
$title = new lang_string('featurethreetext', 'theme_snap');
$setting = new admin_setting_configtextarea($name, $title, $description, '');
$snapsettings->add($setting);

$settings->add($snapsettings);
