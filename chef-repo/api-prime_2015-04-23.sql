# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: api.prime.sentientdecisionscience.com (MySQL 5.5.37-0ubuntu0.12.04.1)
# Database: api-prime
# Generation Time: 2015-04-23 13:07:38 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `access`;

CREATE TABLE `access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `acl_id` int(11) DEFAULT NULL,
  `obj` varchar(100) DEFAULT NULL,
  `method` varchar(100) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `logged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table acl
# ------------------------------------------------------------

DROP TABLE IF EXISTS `acl`;

CREATE TABLE `acl` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `developer` varchar(100) DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `starts` datetime DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `keyphrase` varchar(100) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `added` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table apps
# ------------------------------------------------------------

DROP TABLE IF EXISTS `apps`;

CREATE TABLE `apps` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `code` varchar(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table campaigns
# ------------------------------------------------------------

DROP TABLE IF EXISTS `campaigns`;

CREATE TABLE `campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `confirmation_url` varchar(500) DEFAULT NULL,
  `results_url` varchar(500) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table clients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_key` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `zip` varchar(11) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `client_type` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table clients_complete_sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clients_complete_sessions`;

CREATE TABLE `clients_complete_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT '0',
  `project_key` varchar(100) DEFAULT NULL,
  `session_id` char(64) DEFAULT NULL,
  `total_completes` int(11) DEFAULT '1',
  `last_updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_key_UNIQUE` (`project_key`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table countries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `iso2` char(2) DEFAULT NULL,
  `short_name` varchar(80) NOT NULL DEFAULT '',
  `long_name` varchar(80) NOT NULL DEFAULT '',
  `iso3` char(3) DEFAULT NULL,
  `numcode` varchar(6) DEFAULT NULL,
  `un_member` varchar(12) DEFAULT NULL,
  `calling_code` varchar(8) DEFAULT NULL,
  `cctld` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table dynamic_primes_requests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dynamic_primes_requests`;

CREATE TABLE `dynamic_primes_requests` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `request_id` varchar(200) NOT NULL,
  `project_key` varchar(200) NOT NULL,
  `exercise` int(11) DEFAULT NULL,
  `primes` mediumtext NOT NULL,
  `added` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `custom_data` mediumtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `request_id_project_key_exercise` (`request_id`,`project_key`,`exercise`),
  KEY `project_key` (`project_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exercises
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exercises`;

CREATE TABLE `exercises` (
  `project_key` varchar(50) NOT NULL,
  `exercise_num` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `active` bit(1) DEFAULT b'1',
  `seconds_before_prime` decimal(4,2) NOT NULL DEFAULT '1.00',
  `prime_seconds` decimal(4,2) NOT NULL DEFAULT '1.00',
  `sort_expiration_seconds` decimal(4,2) NOT NULL DEFAULT '0.00' COMMENT '0 means sort target does not expire',
  `accuracy_mean` decimal(2,2) NOT NULL DEFAULT '0.90',
  `accuracy_stdev` decimal(2,2) NOT NULL DEFAULT '0.10',
  `speed_mean` decimal(3,2) NOT NULL DEFAULT '0.90',
  `speed_stdev` decimal(3,2) NOT NULL DEFAULT '0.90',
  `instructions` mediumtext NOT NULL,
  `instructions_touchscreen` mediumtext,
  `amt_completed_label` varchar(50) NOT NULL,
  `positive_label` varchar(50) NOT NULL,
  `positive_sound` varchar(100) NOT NULL,
  `negative_label` varchar(50) NOT NULL,
  `negative_sound` varchar(100) NOT NULL,
  `randomize_tasks` bit(1) NOT NULL DEFAULT b'1',
  `pctg_task_display` decimal(5,2) NOT NULL DEFAULT '100.00',
  `repeated_measures` tinyint(4) NOT NULL DEFAULT '1',
  `include_practice` bit(1) DEFAULT NULL,
  `practice_instructions` mediumtext,
  `practice_instructions_touchscreen` mediumtext,
  `practice_repeated_measures` tinyint(4) DEFAULT NULL,
  `randomize_exercise` bit(1) DEFAULT NULL,
  `automatically_resize_images` bit(1) DEFAULT b'0',
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`project_key`,`exercise_num`,`lang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table industry_benchmarks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `industry_benchmarks`;

CREATE TABLE `industry_benchmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `industry_label` varchar(100) NOT NULL,
  `industry_source` varchar(100) NOT NULL,
  `index_value` decimal(9,6) NOT NULL,
  `N` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table keys
# ------------------------------------------------------------

DROP TABLE IF EXISTS `keys`;

CREATE TABLE `keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(40) NOT NULL,
  `level` int(2) NOT NULL,
  `ignore_limits` tinyint(1) NOT NULL DEFAULT '0',
  `is_private_key` tinyint(1) NOT NULL DEFAULT '0',
  `ip_addresses` text,
  `date_created` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table languages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `languages`;

CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iso` varchar(25) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table limits
# ------------------------------------------------------------

DROP TABLE IF EXISTS `limits`;

CREATE TABLE `limits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `count` int(10) NOT NULL,
  `hour_started` int(11) NOT NULL,
  `api_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `method` varchar(6) NOT NULL,
  `params` text,
  `api_key` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `time` int(11) NOT NULL,
  `authorized` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table mp_user_results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mp_user_results`;

CREATE TABLE `mp_user_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Archetype` int(11) DEFAULT NULL,
  `Archetype_value` varchar(255) DEFAULT NULL,
  `willingness` decimal(8,2) DEFAULT NULL,
  `knowledge` int(11) DEFAULT NULL,
  `response_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table optimize_image
# ------------------------------------------------------------

DROP TABLE IF EXISTS `optimize_image`;

CREATE TABLE `optimize_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_key` varchar(32) NOT NULL,
  `exercise_num` int(11) NOT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_completed` bit(1) DEFAULT b'0',
  `email_id` varchar(100) NOT NULL,
  `completed_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_key_exercise_num` (`project_key`,`exercise_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table password_requests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `password_requests`;

CREATE TABLE `password_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_date` timestamp NULL DEFAULT NULL,
  `login` varchar(100) DEFAULT NULL,
  `Client_id` int(11) DEFAULT NULL,
  `request_key` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table post_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `post_log`;

CREATE TABLE `post_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `pid` varchar(100) DEFAULT NULL,
  `rid` varchar(100) DEFAULT NULL,
  `body` mediumtext,
  `response` mediumtext,
  `forensics` mediumtext,
  `duration` varchar(255) DEFAULT NULL,
  `sent` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table primes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `primes`;

CREATE TABLE `primes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `project_key` varchar(50) NOT NULL,
  `exercise` int(11) NOT NULL,
  `source` varchar(255) NOT NULL,
  `raw_source` varchar(255) DEFAULT NULL,
  `audio_source` varchar(255) DEFAULT NULL,
  `focus` bit(1) DEFAULT b'0',
  `idx` int(11) NOT NULL,
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_project_exercise_file_name` (`client_id`,`project_key`,`exercise`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table project_custom_props
# ------------------------------------------------------------

DROP TABLE IF EXISTS `project_custom_props`;

CREATE TABLE `project_custom_props` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_key` varchar(128) NOT NULL,
  `exercise_num` int(11) DEFAULT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table project_results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `project_results`;

CREATE TABLE `project_results` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_key` char(64) NOT NULL,
  `exercise` smallint(6) NOT NULL,
  `source_label` varchar(256) NOT NULL,
  `up_bucket` varchar(64) NOT NULL,
  `down_bucket` varchar(64) NOT NULL,
  `task_type` varchar(64) NOT NULL,
  `index_value` decimal(13,10) NOT NULL,
  `respondents` int(11) NOT NULL DEFAULT '1',
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table projects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projects`;

CREATE TABLE `projects` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `lang` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `legacy` varchar(100) DEFAULT NULL,
  `project_id` varchar(100) NOT NULL DEFAULT '1',
  `project_key` varchar(32) NOT NULL DEFAULT '1',
  `description` varchar(255) DEFAULT NULL,
  `label1` varchar(255) DEFAULT NULL,
  `label2` varchar(255) DEFAULT NULL,
  `loading_label` varchar(255) DEFAULT NULL,
  `launched` bit(1) DEFAULT NULL,
  `active` tinyint(11) DEFAULT '1',
  `added` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL,
  `launched_date` datetime DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `EndofSurvey` char(10) DEFAULT NULL,
  `ButtonLabel` varchar(255) DEFAULT NULL,
  `RedirectToPage` text,
  `ShowResult` char(5) DEFAULT NULL,
  `project_type` varchar(20) DEFAULT NULL,
  `version_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table purchase_completes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `purchase_completes`;

CREATE TABLE `purchase_completes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` varchar(100) DEFAULT NULL,
  `order_id` varchar(45) DEFAULT NULL,
  `login` varchar(100) DEFAULT NULL,
  `api_key` varchar(100) DEFAULT NULL,
  `variant_id` varchar(100) DEFAULT NULL,
  `Product_title` varchar(255) DEFAULT NULL,
  `request_date` datetime DEFAULT NULL,
  `no_completes` int(11) DEFAULT NULL,
  `total_studies` int(11) DEFAULT '0',
  `amount_paid` double DEFAULT '0',
  `paid_date` datetime DEFAULT NULL,
  `is_paid` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table purchase_details
# ------------------------------------------------------------

DROP TABLE IF EXISTS `purchase_details`;

CREATE TABLE `purchase_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` varchar(100) DEFAULT NULL,
  `order_id` varchar(45) DEFAULT NULL,
  `login` varchar(100) DEFAULT NULL,
  `api_key` varchar(100) DEFAULT NULL,
  `variant_id` varchar(100) DEFAULT NULL,
  `Product_title` varchar(255) DEFAULT NULL,
  `request_date` datetime DEFAULT NULL,
  `no_completes` int(11) DEFAULT NULL,
  `total_studies` int(11) DEFAULT '0',
  `amount_paid` double DEFAULT '0',
  `paid_date` datetime DEFAULT NULL,
  `is_paid` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table respondent_results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `respondent_results`;

CREATE TABLE `respondent_results` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_key` char(64) NOT NULL,
  `response_id` varchar(128) NOT NULL,
  `exercise` smallint(6) NOT NULL,
  `source_label` varchar(256) NOT NULL,
  `up_bucket` varchar(64) NOT NULL,
  `down_bucket` varchar(64) NOT NULL,
  `task_type` varchar(64) NOT NULL,
  `index_value` decimal(13,10) NOT NULL,
  `sessions` int(11) NOT NULL DEFAULT '1',
  `session_length` int(11) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `project_key` (`project_key`),
  KEY `response_id` (`response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table respondents
# ------------------------------------------------------------

DROP TABLE IF EXISTS `respondents`;

CREATE TABLE `respondents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table responses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `responses`;

CREATE TABLE `responses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table results_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `results_cache`;

CREATE TABLE `results_cache` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` varchar(100) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  `raw` mediumtext,
  `logged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table results_pending_estimation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `results_pending_estimation`;

CREATE TABLE `results_pending_estimation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_id` char(64) NOT NULL DEFAULT '',
  `response_id` varchar(128) NOT NULL DEFAULT '',
  `project_id` varchar(128) NOT NULL DEFAULT '',
  `exercise` smallint(6) NOT NULL,
  `step_uid` varchar(256) NOT NULL DEFAULT '',
  `task_order` int(11) NOT NULL,
  `prime_name` varchar(256) DEFAULT NULL,
  `prime_time` int(11) DEFAULT NULL,
  `target_type` varchar(64) NOT NULL DEFAULT 'affpr',
  `task_name` varchar(256) NOT NULL DEFAULT '',
  `task_time` int(11) NOT NULL,
  `task_result` varchar(32) NOT NULL DEFAULT '',
  `response_type` varchar(64) NOT NULL DEFAULT 'unknown',
  `response_intensity` mediumtext,
  `repeat_id` int(11) NOT NULL DEFAULT '1',
  `selected_bucket` varchar(64) DEFAULT NULL,
  `selected_bucket_orientation` varchar(64) DEFAULT NULL,
  `rejected_bucket` varchar(64) DEFAULT NULL,
  `rejected_bucket_orientation` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table results_pending_estimation_backup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `results_pending_estimation_backup`;

CREATE TABLE `results_pending_estimation_backup` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `session_id` char(64) NOT NULL DEFAULT '',
  `response_id` varchar(128) NOT NULL DEFAULT '',
  `project_id` varchar(128) NOT NULL DEFAULT '',
  `exercise` smallint(6) NOT NULL,
  `step_uid` varchar(256) NOT NULL DEFAULT '',
  `task_order` int(11) NOT NULL,
  `prime_name` varchar(256) DEFAULT NULL,
  `prime_time` int(11) DEFAULT NULL,
  `target_type` varchar(64) NOT NULL DEFAULT 'affpr',
  `task_name` varchar(256) NOT NULL DEFAULT '',
  `task_time` int(11) NOT NULL,
  `task_result` varchar(32) NOT NULL DEFAULT '',
  `response_type` varchar(64) NOT NULL DEFAULT 'unknown',
  `response_intensity` mediumtext,
  `repeat_id` int(11) NOT NULL DEFAULT '1',
  `selected_bucket` varchar(64) DEFAULT NULL,
  `selected_bucket_orientation` varchar(64) DEFAULT NULL,
  `rejected_bucket` varchar(64) DEFAULT NULL,
  `rejected_bucket_orientation` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table session_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session_cache`;

CREATE TABLE `session_cache` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hashed` varchar(255) DEFAULT NULL,
  `pid` varchar(100) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  `exstr` varchar(100) DEFAULT NULL,
  `data` mediumtext,
  `tstamp` varchar(50) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table session_pause_results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session_pause_results`;

CREATE TABLE `session_pause_results` (
  `session_id` char(64) NOT NULL DEFAULT '',
  `response_id` varchar(128) NOT NULL DEFAULT '',
  `project_id` varchar(128) NOT NULL DEFAULT '',
  `step_uid` varchar(256) NOT NULL DEFAULT '',
  `pause_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table session_post_pause_task_results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session_post_pause_task_results`;

CREATE TABLE `session_post_pause_task_results` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_id` char(64) NOT NULL DEFAULT '',
  `response_id` varchar(128) NOT NULL DEFAULT '',
  `project_id` varchar(128) NOT NULL DEFAULT '',
  `exercise` smallint(6) NOT NULL,
  `step_uid` varchar(256) NOT NULL DEFAULT '',
  `prime_name` varchar(256) DEFAULT NULL,
  `prime_time` int(11) DEFAULT NULL,
  `target_type` varchar(64) NOT NULL DEFAULT 'affpr',
  `task_name` varchar(256) NOT NULL DEFAULT '',
  `task_time` int(11) NOT NULL,
  `task_result` varchar(32) NOT NULL DEFAULT '',
  `response_type` varchar(64) NOT NULL DEFAULT 'unknown',
  `response_intensity` mediumtext,
  `repeat_id` int(11) NOT NULL DEFAULT '1',
  `selected_bucket` varchar(64) DEFAULT NULL,
  `selected_bucket_orientation` varchar(64) DEFAULT NULL,
  `rejected_bucket` varchar(64) DEFAULT NULL,
  `rejected_bucket_orientation` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table session_requests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session_requests`;

CREATE TABLE `session_requests` (
  `session_id` char(64) NOT NULL DEFAULT '',
  `response_id` varchar(128) NOT NULL DEFAULT '',
  `project_id` varchar(128) NOT NULL DEFAULT '',
  `session_reqest_timestamp` datetime NOT NULL,
  `session_reqest_ip` varchar(15) NOT NULL DEFAULT '',
  `session_reqest_user_agent` text,
  `session_reqest_screen` text,
  `used_timestamp` datetime DEFAULT NULL,
  `version_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table session_results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session_results`;

CREATE TABLE `session_results` (
  `session_id` char(64) NOT NULL DEFAULT '',
  `response_id` varchar(128) NOT NULL DEFAULT '',
  `project_id` varchar(128) NOT NULL DEFAULT '',
  `session_results_timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table session_task_results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session_task_results`;

CREATE TABLE `session_task_results` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_id` char(64) NOT NULL DEFAULT '',
  `response_id` varchar(128) NOT NULL DEFAULT '',
  `project_id` varchar(128) NOT NULL DEFAULT '',
  `exercise` smallint(6) NOT NULL,
  `step_uid` varchar(256) NOT NULL DEFAULT '',
  `task_order` int(11) NOT NULL,
  `prime_name` varchar(256) DEFAULT NULL,
  `prime_time` int(11) DEFAULT NULL,
  `target_type` varchar(64) NOT NULL DEFAULT 'affpr',
  `task_name` varchar(256) NOT NULL DEFAULT '',
  `task_time` int(11) NOT NULL,
  `task_result` varchar(32) NOT NULL DEFAULT '',
  `response_type` varchar(64) NOT NULL DEFAULT 'unknown',
  `response_intensity` mediumtext,
  `repeat_id` int(11) NOT NULL DEFAULT '1',
  `selected_bucket` varchar(64) DEFAULT NULL,
  `selected_bucket_orientation` varchar(64) DEFAULT NULL,
  `rejected_bucket` varchar(64) DEFAULT NULL,
  `rejected_bucket_orientation` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `response_id` (`response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table session_task_results_backup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session_task_results_backup`;

CREATE TABLE `session_task_results_backup` (
  `id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table setting_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `setting_groups`;

CREATE TABLE `setting_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `app` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table setting_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `setting_items`;

CREATE TABLE `setting_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `app` int(11) DEFAULT NULL,
  `grp` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `short` varchar(100) DEFAULT NULL,
  `legacy` varchar(100) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `def` varchar(255) DEFAULT NULL,
  `min_val` varchar(255) DEFAULT NULL,
  `max_val` varchar(255) DEFAULT NULL,
  `display` smallint(11) DEFAULT NULL,
  `visible` tinyint(11) DEFAULT NULL,
  `active` tinyint(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table setting_values
# ------------------------------------------------------------

DROP TABLE IF EXISTS `setting_values`;

CREATE TABLE `setting_values` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client` int(11) DEFAULT NULL,
  `app` int(11) DEFAULT NULL,
  `project` int(11) DEFAULT NULL,
  `setting` int(11) DEFAULT NULL,
  `val` varchar(255) DEFAULT NULL,
  `min_val` varchar(255) DEFAULT NULL,
  `max_val` varchar(255) DEFAULT NULL,
  `active` tinyint(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table signup_requests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `signup_requests`;

CREATE TABLE `signup_requests` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(200) DEFAULT NULL,
  `signup_key` varchar(32) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `campaign_code` varchar(50) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table survey_link_templates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `survey_link_templates`;

CREATE TABLE `survey_link_templates` (
  `option_name` varchar(255) NOT NULL,
  `template` longtext,
  PRIMARY KEY (`option_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Dump of table tasks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tasks`;

CREATE TABLE `tasks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `target_type` varchar(5) DEFAULT NULL,
  `client_id` varchar(50) NOT NULL,
  `project_key` varchar(50) NOT NULL,
  `exercise` int(11) NOT NULL,
  `source` varchar(255) NOT NULL,
  `raw_source` varchar(255) DEFAULT NULL,
  `bucket` varchar(10) DEFAULT NULL,
  `focus` bit(1) DEFAULT b'0',
  `idx` int(11) NOT NULL,
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) unsigned NOT NULL,
  `login` varchar(100) NOT NULL COMMENT 'Cannot update this!  It is the salt for the password MD5 hash!',
  `password` blob NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `type` varchar(10) NOT NULL DEFAULT 'user',
  `status` varchar(10) NOT NULL DEFAULT 'active',
  `api_key` varchar(100) NOT NULL DEFAULT 'active' COMMENT 'Default value should be MD5(concat(UUID(), login))',
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id_login` (`client_id`,`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table versions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `versions`;

CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_number` varchar(45) DEFAULT NULL,
  `ui_version` varchar(45) DEFAULT NULL,
  `cp_version` varchar(45) DEFAULT NULL,
  `lamp_api_version` varchar(45) DEFAULT NULL,
  `description` text,
  `created_on` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT b'0',
  `is_current` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table video_thumbnail_requests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `video_thumbnail_requests`;

CREATE TABLE `video_thumbnail_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_key` varchar(100) DEFAULT NULL,
  `video_index` int(11) DEFAULT '0',
  `video_url` tinytext,
  `video_name` varchar(100) DEFAULT NULL,
  `is_completed` bit(1) DEFAULT b'0',
  `completed_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table video_thumbnails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `video_thumbnails`;

CREATE TABLE `video_thumbnails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_key` varchar(100) DEFAULT NULL,
  `video_index` int(11) DEFAULT '0',
  `thumbnail_url` tinytext,
  `height` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `slide_resize` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table whitelist_ip
# ------------------------------------------------------------

DROP TABLE IF EXISTS `whitelist_ip`;

CREATE TABLE `whitelist_ip` (
  `ipaddress` varchar(100) NOT NULL,
  UNIQUE KEY `ipaddress_UNIQUE` (`ipaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table zscores
# ------------------------------------------------------------

DROP TABLE IF EXISTS `zscores`;

CREATE TABLE `zscores` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `app` int(11) DEFAULT NULL,
  `code` varchar(25) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `active` tinyint(11) DEFAULT '1',
  `added` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




--
-- Dumping routines (PROCEDURE) for database 'api-prime'
--
DELIMITER ;;

# Dump of PROCEDURE spAddClientAndUser
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spAddClientAndUser` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spAddClientAndUser`(IN `signup_key` varchar(50), IN `login` varchar(100) charset utf8, IN `password` BLOB, IN `first_name` varchAR(50) charset utf8, IN `last_name` varchar(50) charset utf8, IN `title` varchar(50) charset utf8, IN `organization` varchar(50) charset utf8, IN `type` varchar(10))
BEGIN

		#salted hash for the unique client key:
		set @new_client_key = MD5(concat(UUID(), organization));

	if not exists (select 1 from users where users.login = login) then
		
		insert clients (company, client_key)
		values (organization, @new_client_key);
		
		insert users (client_id, login, password, first_name, last_name, title, type)
		select c.id, login, password, first_name, last_name, title, type
		from clients c where c.client_key = @new_client_key;
		
		update signup_requests
		set status = 'confirmed'
		where signup_key = signup_requests.signup_key;
		
	end if;

	select u.* 
	from users u
	inner join (select id from clients where client_key = @new_client_key) c on u.client_id = c.id;
		

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spAddProject
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spAddProject` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spAddProject`(IN `api_key` varchar(50), IN `project_id` varchar(50), IN `description` VARCHAR(255), IN project_type VARCHAR(20))
BEGIN
DECLARE versionid int;
DECLARE projectkey varchar(100);
set projectkey = MD5(concat(UUID(), project_id));
select id into versionid from versions where is_current = 1 limit 1;
	INSERT INTO projects 
		(client_id, 
		app_id, 
		project_id,  
		project_key, 
		description, 
		active, 
		loading_label, 
		created_by,project_type,
		ShowResult,
		version_id)
	select 
		client_id, 
		1,
		project_id, 
		projectkey,
		description,
		1,
		'Loading',
		u.login,
		project_type,
		case  when lower(project_type) = 'trial' then 'no' else '' end,
		versionid
	from users u 
	inner join clients c on u.client_id = c.id
	where u.api_key = api_key;

select project_key from projects where project_key = projectkey;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spAddProjectEO
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spAddProjectEO` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spAddProjectEO`(IN `api_key` varchar(50), IN `project_id` varchar(50), IN `description` VARCHAR(255), IN project_type VARCHAR(5))
BEGIN
DECLARE versionid int;
DECLARE projectkey varchar(100);
set projectkey = MD5(concat(UUID(), project_id));
select id into versionid from versions where is_current = 1 limit 1;
	INSERT INTO projects 
		(client_id, 
		app_id, 
		project_id,  
		project_key, 
		description, 
		active, 
		loading_label, 
		created_by,project_type,
		ShowResult,
		version_id)
	select 
		client_id, 
		1,
		project_id, 
		projectkey,
		description,
		1,
		'Loading',
		u.login,
		project_type,
		case  when lower(project_type) = 'trial' then 'no' else '' end,
		versionid
	from users u 
	inner join clients c on u.client_id = c.id
	where u.api_key = api_key;

select project_key from projects where project_key = projectkey;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spAllImagesOfProject
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spAllImagesOfProject` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spAllImagesOfProject`(IN project_key varchar(50))
BEGIN

select source from tasks where tasks.project_key= project_key and source like'http%'
union all
select source from primes where primes.project_key= project_key  and source like'http%';

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spAllImagesOfProjectExercise
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spAllImagesOfProjectExercise` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spAllImagesOfProjectExercise`(IN project_key varchar(50),IN exercise_num INT)
BEGIN

select source,raw_source from tasks where tasks.project_key= project_key and exercise = exercise_num and source like'http%'
union all
select source,raw_source from primes where primes.project_key= project_key and exercise = exercise_num  and source like'http%';

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spAttribute _Associations
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spAttribute _Associations` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spAttribute _Associations`(IN project_key VARCHAR(32),IN exercise_num INT)
BEGIN
select
	p.name as item_label,
	p.source as item_source,
	pr.index_value as value,
	pr.down_bucket as attribute_label,
	pr.up_bucket as attribute_opposite
from 
	(select * from project_results pr where pr.project_key = project_key and pr.exercise >= exercise_num) pr
	join (select * from primes) p on p.project_key = pr.project_key and p.exercise = pr.exercise and pr.source_label = fnAlphaNumeric(p.name)
order by focus desc limit 3;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spConfirmedSignUpStatus
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spConfirmedSignUpStatus` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spConfirmedSignUpStatus`(IN `signup_key` varchar(50), IN campaign_code VARCHAR(50))
BEGIN
IF EXISTS(select 1 from  signup_requests where signup_requests.signup_key = signup_key and signup_requests.campaign_code = campaign_code and signup_requests.status ='pending') THEN
begin
		SET SQL_SAFE_UPDATES=0;
	    update signup_requests
		set status = 'confirmed'
		where signup_requests.signup_key = signup_key and signup_requests.campaign_code = campaign_code;
		SET SQL_SAFE_UPDATES=1;
select signup_key,email,confirmation_url from signup_requests sr 
left join
	campaigns cp 	
		on 
	sr.campaign_code = cp.code 
where sr.signup_key = signup_key and sr.campaign_code = campaign_code;
end;
end if;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spConfirmedSignUpStatusEO
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spConfirmedSignUpStatusEO` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`da-systems`@`%`*/ /*!50003 PROCEDURE `spConfirmedSignUpStatusEO`(IN `signup_key` varchar(50), IN campaign_code VARCHAR(50))
BEGIN
IF EXISTS(select 1 from  signup_requests where signup_requests.signup_key = signup_key and signup_requests.campaign_code = campaign_code) THEN
begin
		SET SQL_SAFE_UPDATES=0;
	    update signup_requests
		set status = 'confirmed'
		where signup_requests.signup_key = signup_key and signup_requests.campaign_code = campaign_code;
		SET SQL_SAFE_UPDATES=1;
select signup_key,confirmation_url from signup_requests sr 
left join
	campaigns cp 	
		on 
	sr.campaign_code = cp.code 
where sr.signup_key = signup_key and sr.campaign_code = campaign_code;
end;
end if;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spCopyExercise
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spCopyExercise` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spCopyExercise`(IN `project_key` varchar(50), IN `exercise_name` VARCHAR(50), IN `copy_exercise` INT,IN exercise_position INT)
BEGIN

declare total_exercise int;
SET SQL_SAFE_UPDATES = 0;
select count(1) into total_exercise from exercises where exercises.project_key = project_key;

/* Adjust exercise position to fit new exercise */

if ( copy_exercise >= exercise_position) then
begin
set copy_exercise = copy_exercise + 1;
end;
end if;

if (total_exercise >= exercise_position ) then
begin

update exercises 
set exercise_num = exercise_num + 1
where exercises.exercise_num >= exercise_position and exercises.project_key = project_key
order by exercise_num desc;


update tasks 
set exercise = exercise + 1
where tasks.exercise >= exercise_position and tasks.project_key = project_key
order by exercise desc;

update  primes 
set exercise = exercise + 1
where primes.exercise >= exercise_position and primes.project_key = project_key
order by exercise desc;

update  project_custom_props 
set exercise_num = exercise_num + 1
where project_custom_props.exercise_num >= exercise_position and project_custom_props.project_key = project_key
order by exercise_num desc;


end;
end if;
	
/* copy the exercise */
	insert into exercises
			(project_key, 
			exercise_num, 
			name, 
			positive_label, 
			negative_label, 
			seconds_before_prime, 
			prime_seconds, 
			sort_expiration_seconds, 
			accuracy_mean, 
			accuracy_stdev,
			speed_mean,
			speed_stdev,
			instructions,
			instructions_touchscreen,
			amt_completed_label,
			positive_sound,
			negative_sound,
			randomize_tasks,
			pctg_task_display,
			repeated_measures,
			include_practice,
			practice_instructions,
			practice_instructions_touchscreen,
			practice_repeated_measures,
			randomize_exercise,
			automatically_resize_images
)
		select e.project_key, 
			exercise_position, 
			exercise_name,
			e.positive_label, 
			e.negative_label, 
			e.seconds_before_prime, 
			e.prime_seconds, 
			e.sort_expiration_seconds, 
			e.accuracy_mean, 
			e.accuracy_stdev,
			e.speed_mean,
			e.speed_stdev,
			e.instructions,
			e.instructions_touchscreen,
			e.amt_completed_label,
			e.positive_sound,
			e.negative_sound,
			e.randomize_tasks,
			e.pctg_task_display,
			e.repeated_measures,
			e.include_practice,
			e.practice_instructions,
			e.practice_instructions_touchscreen,
			e.practice_repeated_measures,
			e.randomize_exercise,
			e.automatically_resize_images
			from exercises e where e.project_key = project_key and e.exercise_num = copy_exercise;


/* copy tasks (targets) */

insert into tasks
			(client_id, project_key, target_type, name,label, exercise, bucket, idx, source,raw_source,focus)
		select p.client_id, project_key, t.target_type, t.name,t.label, exercise_position, t.bucket, t.idx, t.source,t.raw_source,t.focus
			from projects p
			inner join tasks t 
			on p.project_key = t.project_key
			where p.project_key = project_key and t.exercise = copy_exercise ;


/* copy primes */

insert into primes
			(client_id, project_key, name, label, exercise, idx, source,raw_source,audio_source,focus)
		select p.client_id, project_key, pr.name, pr.label, exercise_position, pr.idx, pr.source,pr.raw_source,pr.audio_source,pr.focus
			from projects p
			inner join primes pr
			on pr.project_key = p.project_key
			where p.project_key = project_key and pr.exercise = copy_exercise ;

/*copy project exercise custom properties*/
Insert into project_custom_props
			(project_key, exercise_num, `key`, value)
		select p.project_key, exercise_position, p.key, p.value
			from project_custom_props p
			where p.project_key = project_key and p.exercise_num = copy_exercise ;



SET SQL_SAFE_UPDATES = 1;

select project_key;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spCopyProject
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spCopyProject` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spCopyProject`(IN `project_key` varchar(32),IN `project_id` varchar(50),IN email varchar(50),IN client_id INT)
BEGIN
DECLARE Newprojectkey varchar(100);
set Newprojectkey = MD5(concat(UUID(), project_id));
INSERT INTO projects 
		(client_id, 
		app_id, 
		project_id, 
		project_key, 
		description, 
		active, 
		loading_label, 
		launched,EndofSurvey,ButtonLabel,RedirectToPage,ShowResult,lang,
		created_by,project_type,version_id)
	select 
		client_id, 
		p.app_id,
		project_id, 
		Newprojectkey,
		p.description,
		p.active,
		p.loading_label,
		p.launched,p.EndofSurvey,p.ButtonLabel,p.RedirectToPage,p.ShowResult,p.lang,
		email,
		p.project_type,
        p.version_id
	from projects p 
	where p.project_key = project_key;

  /* copy the exercise */
	insert into exercises
			(project_key, 
			exercise_num, 
			name, 
			positive_label, 
			negative_label, 
			seconds_before_prime, 
			prime_seconds, 
			sort_expiration_seconds, 
			accuracy_mean, 
			accuracy_stdev,
			speed_mean,
			speed_stdev,
			instructions,
			instructions_touchscreen,
			amt_completed_label,
			positive_sound,
			negative_sound,
			randomize_tasks,
			pctg_task_display,
			repeated_measures,
			include_practice,
			practice_instructions,
			practice_instructions_touchscreen,
			practice_repeated_measures,
			randomize_exercise,
			automatically_resize_images
)
		select Newprojectkey, 
			e.exercise_num, 
			e.name,
			e.positive_label, 
			e.negative_label, 
			e.seconds_before_prime, 
			e.prime_seconds, 
			e.sort_expiration_seconds, 
			e.accuracy_mean, 
			e.accuracy_stdev,
			e.speed_mean,
			e.speed_stdev,
			e.instructions,
			e.instructions_touchscreen,
			e.amt_completed_label,
			e.positive_sound,
			e.negative_sound,
			e.randomize_tasks,
			e.pctg_task_display,
			e.repeated_measures,
			e.include_practice,
			e.practice_instructions,
			e.practice_instructions_touchscreen,
			e.practice_repeated_measures,
			e.randomize_exercise,
			e.automatically_resize_images
			from exercises e where e.project_key = project_key;


/* copy tasks (targets) */

insert into tasks
			(client_id, project_key, target_type, name,label, exercise, bucket, idx, source,raw_source,focus)
		  select p.client_id, Newprojectkey, t.target_type, t.name,t.label, t.exercise, t.bucket, t.idx, 
          CASE  WHEN t.source LIKE '%http%' THEN replace(t.source,project_key,Newprojectkey) ELSE t.source END as source,t.raw_source,
		    t.focus
			from projects p
			inner join tasks t 
			on p.project_key = t.project_key
			where p.project_key = project_key;


/* copy primes */

insert into primes
			(client_id, project_key, name, label, exercise, idx, source,raw_source,audio_source,focus)
		select p.client_id, Newprojectkey, pr.name, pr.label, pr.exercise, pr.idx, 
			CASE  WHEN pr.source LIKE '%http%' THEN replace(pr.source,project_key,Newprojectkey) ELSE pr.source END as source,pr.raw_source,pr.audio_source,
			pr.focus
			from projects p
			inner join primes pr
			on pr.project_key = p.project_key
			where p.project_key = project_key;

/*copy project custom properties*/
Insert into project_custom_props
			(project_key, exercise_num, `key`, value)
		select Newprojectkey, p.exercise_num, p.key, p.value
			from project_custom_props p
			where p.project_key = project_key  ;

/*select project_key from projects where project_key = Newprojectkey;*/
select Newprojectkey as project_key ;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spDeleteProjectCustomProperties
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spDeleteProjectCustomProperties` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spDeleteProjectCustomProperties`(IN `id` INT)
BEGIN  
delete from project_custom_props where project_custom_props.id = id;
end */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spExportResponseData
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spExportResponseData` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spExportResponseData`(IN `project_key` VARCHAR(100))
    READS SQL DATA
BEGIN


select 
	response_id as ID, 
	ex_prime_attribute_measure as VarName, 
	response_time as ResponseTime,
	task_result as TaskResult,
	task_type as TaskType,
	selected_bucket as SelectedBucket,
	selected_bucket_orientation as SelectedBucketLocation,
	exercise as Exercise,
	repeat_id as RepeatedMeasure,
	prime_name as PrimeName,
	task_name as TargetName
from
(
	#select standard responses - no dynamic primes:
		select 
			str.response_id, 
			concat('E', str.exercise, '_', fnAlphaNumeric(str.prime_name), '_', fnAlphaNumeric(str.task_name), '_', 'M', str.repeat_id) as ex_prime_attribute_measure,
			avg(str.task_time) as response_time,
			str.task_result,
			case str.target_type when 'affpr' then 'sa' else str.target_type end as task_type,
			str.selected_bucket,
			str.selected_bucket_orientation,
			str.exercise,
			str.repeat_id,
			str.prime_name,
			str.task_name
		from 
			session_task_results str
		where 
			str.project_id = project_key
		group by 
			str.response_id, 
			concat('E', '_', str.exercise, '_', str.prime_name, '_', str.task_name, '_', 'M', str.repeat_id)
	UNION ALL
	#select dynamic prime responses:
		select 
			str.response_id, 
			replace(concat('E', str.exercise, '_', fnAlphaNumeric(str.prime_name), '_', fnAlphaNumeric(str.task_name), '_', 'M', str.repeat_id), ' ', '-') as ex_prime_attribute_measure,
			avg(str.task_time) as response_time,
			str.task_result,
			case str.target_type when 'affpr' then 'sa' else str.target_type end,
			str.selected_bucket,
			str.selected_bucket_orientation,
			str.exercise,
			str.repeat_id,
			str.prime_name,
			str.task_name
		from 
			session_task_results str
			join (select * from dynamic_primes_requests dpr where dpr.project_key = project_key) dpr on str.project_id = dpr.request_id
		group by 
			str.response_id, 
			concat('E', '_', str.exercise, '_', fnAlphaNumeric(str.prime_name), '_', fnAlphaNumeric(str.task_name), '_', 'M', str.repeat_id)
) responses;
# where task_result != 'timeout';




END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spFocalItemLove
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spFocalItemLove` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spFocalItemLove`(IN `project_key` varchar(50), IN `exercise_num` INT)
BEGIN
select * from 
(
	select
	avg(pr.index_value) as value, 
	p.name as label,
	p.source
	from project_results pr
	join 
	primes p on pr.project_key = p.project_key 
	and pr.exercise = p.exercise
	and pr.source_label = fnAlphaNumeric(p.name)
	where
	pr.project_key= project_key and pr.exercise= exercise_num 
	group by p.source
	order by focus desc
) t1
/*union
select * from
(
	select 
		i.index_value, 
		concat('<i>', i.industry_label, ' Industry Love</i><br/>Calculated by Sentient<br/>(N = ', format(i.N,0), ')') label, 
		concat('<i>', i.industry_label, ' Industry Love</i><br/>Calculated by Sentient<br/>(N = ', format(i.N,0), ')') source 
	from industry_benchmarks i
	order by rand()
	limit 1
) t2*/;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetAllLanguages
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetAllLanguages` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetAllLanguages`()
BEGIN
select * from languages  order by title;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetAllUserPurchase
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetAllUserPurchase` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetAllUserPurchase`(IN api_key varchar(100))
BEGIN

DECLARE cClientID int;
select client_id into cClientID from users where users.api_key = api_key;
/*
select * from purchase_completes where purchase_completes.api_key in 
		(select api_key from users where users.client_id = cClientID) 
order by paid_date desc;*/
SELECT 
    order_id,
    login,
    api_key,
    request_date,
    paid_date,
    GROUP_CONCAT(product_title, concat(' - $', amount_paid)
        SEPARATOR ' --new_line-- ') as Product_title,
    sum(amount_paid) as amount_paid
FROM
    purchase_completes where purchase_completes.api_key in 
		(select api_key from users where users.client_id = cClientID) 
GROUP BY order_id , paid_date order by paid_date desc;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetAllUserPurchaseold
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetAllUserPurchaseold` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetAllUserPurchaseold`(IN api_key varchar(100))
BEGIN
select * from purchase_details where purchase_details.api_key = api_key order by paid_date desc;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetAllversions
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetAllversions` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetAllversions`()
BEGIN
select * from versions where is_active = 1 order by id desc;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetAllVideosForThumbnails
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetAllVideosForThumbnails` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetAllVideosForThumbnails`()
BEGIN
SELECT vtr.*,p.project_id as project_name,p.created_by as login FROM video_thumbnail_requests vtr
left join
	projects p
on vtr.project_key = p.project_key
 WHERE vtr.is_completed = 0;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetCompletedStatus
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetCompletedStatus` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetCompletedStatus`(IN `project_key` VARCHAR(64), IN `response_id` VARCHAR(128), OUT `isFound` boolean)
BEGIN
IF EXISTS(select 1 from session_results where session_results.project_id = project_key and session_results.response_id = response_id) THEN
	BEGIN
		set isFound  = true;
	END;
	else
	BEGIN
		set isFound  = false;
	END;
END IF;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetDynamicPrimesRequest
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetDynamicPrimesRequest` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetDynamicPrimesRequest`(IN `request_id` varchar(100) charset utf8, IN `exercise` int)
    READS SQL DATA
select * from dynamic_primes_requests dpr
	where dpr.request_id = request_id and (dpr.exercise = exercise) */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetExportCompletedInfo
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetExportCompletedInfo` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetExportCompletedInfo`(IN `project_key` varchAR(50), IN `api_key` VARCHAR(50))
BEGIN
	select u.login, p.project_id, p.description
	from (select * from users where users.api_key = api_key) u
	inner join (select * from projects p where p.project_key = project_key) p on u.client_id = p.client_id;
	
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetOptimizeImageDetails
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetOptimizeImageDetails` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetOptimizeImageDetails`()
BEGIN
Select 
o.id,
o.project_key,
o.exercise_num,
o.width,
o.height,
o.email_id,
p.project_id as project_name,
e.name as exercise_name
 from optimize_image o 
left join
projects p on
p.project_key = o.project_key
left join exercises e on
e.project_key = o.project_key and e.exercise_num = o.exercise_num
where o.is_completed = false;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetOTS
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetOTS` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetOTS`(IN project_key VARCHAR(128), IN resp_id VARCHAR(128))
BEGIN
IF EXISTS (SELECT 1 FROM project_custom_props pcp WHERE pcp.`key`='OTS_results' AND pcp.project_key=project_key) THEN
	SELECT * FROM respondent_results rr WHERE rr.project_key = project_key AND rr.response_id = resp_id;
END IF;


END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetPendingResults
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetPendingResults` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetPendingResults`(IN `session_id` varchar(100))
BEGIN
declare p_key varchar(50);
declare trialtype varchar(255);
set p_key := (select case when p.project_key is null then dpr.project_key else p.project_key end
		from ( select distinct rpe.project_id from results_pending_estimation rpe where rpe.session_id = session_id
		) rpe
		left join projects p on rpe.project_id = p.project_key
		left join dynamic_primes_requests dpr on rpe.project_id = dpr.request_id
		limit 1);
set trialtype := (select value from project_custom_props pcp where pcp.project_key = p_key and `key` = 'type');

select 
	case trialtype 
		when 'adtest' then left(response_id, length(response_id)-2)
		else response_id 
	end as ID, 
	ex_prime_attribute_measure as VarName, 
	response_time as ResponseTime,
	task_result as TaskResult,
	task_type as TaskType,
	selected_bucket as SelectedBucket,
	selected_bucket_orientation as SelectedBucketLocation,
	exercise as Exercise,
	repeat_id as RepeatedMeasure,
	case trialtype
		when 'adtest' then concat(prime_name, right(response_id,2))
		else prime_name
	end as PrimeName,
	task_name as TargetName,
	response_type as ResponseType,
	response_intensity as Intensity,
	p_key as ProjectKey
from
(
	#select standard responses - no dynamic primes:
		select 
			rpe.response_id, 
			concat(
				'E', 
				rpe.exercise, 
				'_', 
				fnAlphaNumeric(
					case trialtype
						when 'adtest' then concat(rpe.prime_name, right(response_id,2))
						else rpe.prime_name
					end), 
				'_', 
				fnAlphaNumeric(rpe.task_name), '_', 'M', rpe.repeat_id) as ex_prime_attribute_measure,
			avg(rpe.task_time) as response_time,
			rpe.task_result,
			case rpe.target_type when 'affpr' then 'sa' else rpe.target_type end as task_type,
			rpe.selected_bucket,
			rpe.selected_bucket_orientation,
			rpe.exercise,
			rpe.repeat_id,
			fnAlphaNumeric(rpe.prime_name) as prime_name,
			fnAlphaNumeric(rpe.task_name) as task_name,
			rpe.response_type,
			rpe.response_intensity,
			p_key
		from 
			results_pending_estimation rpe
		where 
			rpe.session_id = session_id
		group by 
			rpe.response_id, 
			concat('E', '_', rpe.exercise, '_', rpe.prime_name, '_', rpe.task_name, '_', 'M', rpe.repeat_id)
/*	UNION ALL
	#select dynamic prime responses:
		select 
			rpe.response_id, 
			concat('E', rpe.exercise, '_', fnAlphaNumeric(rpe.prime_name), '_', fnAlphaNumeric(rpe.task_name), '_', 'M', rpe.repeat_id) as ex_prime_attribute_measure,
			avg(rpe.task_time) as response_time,
			rpe.task_result,
			case rpe.target_type when 'affpr' then 'sa' else rpe.target_type end,
			rpe.selected_bucket,
			rpe.selected_bucket_orientation,
			rpe.exercise,
			rpe.repeat_id,
			fnAlphaNumeric(rpe.prime_name) as prime_name,
			fnAlphaNumeric(rpe.task_name) as task_name,
			rpe.response_type,
			rpe.response_intensity,
			dpr.project_key as project_id
		from 
			results_pending_estimation rpe
			join (select * from dynamic_primes_requests dpr where dpr.project_key = project_key) dpr on rpe.project_id = dpr.request_id
		group by 
			rpe.response_id, 
			concat('E', '_', rpe.exercise, '_', rpe.prime_name, '_', rpe.task_name, '_', 'M', rpe.repeat_id)
*/) responses;
#where task_result != 'timeout'$$
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetProjectCustomProperties
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetProjectCustomProperties` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetProjectCustomProperties`(IN `project_key` VARCHAR(100),IN exercise_num INT)
BEGIN  
SELECT id,project_key,exercise_num,`key`,value from project_custom_props where project_custom_props.project_key = project_key AND project_custom_props.exercise_num = exercise_num;
end */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetProjectDetails
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetProjectDetails` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetProjectDetails`(IN `project_key` varCHAR(50))
BEGIN
/*
select *
from projects
where projects.project_key = project_key;*/
select p.*,count(vtr.video_url) as total_video
from projects p
left join video_thumbnail_requests vtr
on p.project_key = vtr.project_key
where p.project_key = project_key;


END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetProjectExerciseLabels
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetProjectExerciseLabels` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetProjectExerciseLabels`(IN `project_key` VARCHAR(50))
BEGIN
	select 
		p.project_key as projectID,
		p.exercise as exercise,
		p.name as labelID,
		p.label as labelValue,
		'p' as labelType
	from primes p 
	inner join exercises e on e.project_key = p.project_key and p.exercise = e.exercise_num
	where
		p.project_key = project_key
	having p.exercise in (select distinct str.exercise from session_task_results str where str.project_id = project_key)
union all
	select 
		t.project_key as projectID,
		t.exercise as exercise,
		t.name as labelID,
		case t.bucket 
			when 'top' then e.negative_label 
			when 'bottom' then e.positive_label 
			end as labelValue,
		't' as labelType
	from tasks t
	inner join exercises e on t.project_key = e.project_key and t.exercise = e.exercise_num
	where
		t.project_key = project_key
	having t.exercise in (select distinct str.exercise from session_task_results str where str.project_id = project_key);
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetProjectExercises
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetProjectExercises` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetProjectExercises`(IN `project_key` varchar(50))
BEGIN

select 
e . project_key ,
    e . exercise_num ,
    e . lang_id ,
    e . name ,
    e . active ,
    e . seconds_before_prime ,
    e . prime_seconds ,
    e . sort_expiration_seconds ,
    e . accuracy_mean ,
    e . accuracy_stdev ,
    e . speed_mean ,
    e . speed_stdev ,
   replace(replace(e.instructions,'<br/>','\n'),'<br>','\n') as instructions,
   replace(replace(e.instructions_touchscreen,'<br/>','\n'),'<br>','\n') as instructions_touchscreen,
    e . amt_completed_label ,
    e . positive_label ,
    e . positive_sound ,
    e . negative_label ,
    e . negative_sound ,
    e . randomize_tasks ,
    e . pctg_task_display ,
    e . repeated_measures ,
    e . include_practice ,
    e . practice_instructions ,
	replace(replace(e. practice_instructions,'<br/>','\n'),'<br>','\n') as practice_instructions,
    replace(replace(e. practice_instructions_touchscreen,'<br/>','\n'),'<br>','\n') as practice_instructions_touchscreen,
    e . practice_repeated_measures ,
    e . randomize_exercise ,
	e.automatically_resize_images,
    e . added ,
    e . deleted 
from exercises e 
inner join projects p on e.project_key = p.project_key
where p.project_key = project_key
order by e.exercise_num;

select p.* 
from primes p 
inner join (select * from projects where projects.project_key = project_key) proj on p.project_key = proj.project_key
where p.deleted is null
order by p.exercise, p.name;

select t.* 
from tasks t 
inner join (select * from projects where projects.project_key = project_key) proj on t.project_key = proj.project_key
where t.deleted is null
order by t.exercise, t.bucket, t.name;
SELECT id,project_key,exercise_num,`key`,value from project_custom_props where project_custom_props.project_key = project_key;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetProjectExerciseUIData
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetProjectExerciseUIData` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetProjectExerciseUIData`(IN `project_key` varchar(50), IN `exercise` smallint)
    COMMENT 'this returns the data required for the XML sent to the UI; it ne'
BEGIN
/*
	select from projects on project_key.
	
	if project_key is not found, it may be the request_id from a dynamic primes request, so 
	see if the data is in there, filtering out any prime names that are not in the 
	pipe-delimited string field.

*/

	if exists (select 1 from exercises e where e.project_key = project_key and e.exercise_num = exercise) then
		select e.*, concat_ws('|', e.positive_label, e.negative_label) as 'bucketlabels', e.include_practice + 0 as inc_practice 
		from exercises e 
		where e.project_key = project_key and e.exercise_num = exercise;
	else
		select e.*, concat_ws('|', e.positive_label, e.negative_label) as 'bucketlabels', e.include_practice + 0 as inc_practice, dpr.primes as dynamic_primes
		from exercises e
		inner join (select * from dynamic_primes_requests dpr where dpr.request_id = project_key and dpr.exercise = exercise) dpr on e.project_key = dpr.project_key
		where e.exercise_num = exercise;
		select dpr.project_key into project_key from dynamic_primes_requests dpr where dpr.request_id = project_key and dpr.exercise = exercise;
	end if;
	
	select * from primes p where p.project_key = project_key and p.exercise = exercise order by p.idx;
	select t.*, 
		case t.bucket when 'top' then 'false' when 'bottom' then 'true' else t.bucket end as 'value' 
	from tasks t where t.project_key = project_key and t.exercise = exercise order by t.idx;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetProjectExerciseUIDataWithPrimeFilter
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetProjectExerciseUIDataWithPrimeFilter` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetProjectExerciseUIDataWithPrimeFilter`(IN `project_key` varchar(50), IN `exercise` INT, IN `prime_names` varchar(1000))
BEGIN
/*
	select from projects on project_key.
	
	if project_key is not found, it may be the request_id from a dynamic primes request, so 
	see if the data is in there, filtering out any prime names that are not in the 
	pipe-delimited string field.
	
	Also accommodates prime_filter argument which will filter primes based on
	a pipe-delimited list of prime names.

*/

set prime_names = concat('^', prime_names , '$');

	if exists (select 1 from exercises e where e.project_key = project_key and e.exercise_num = exercise) then
		select e.*, concat_ws('|', e.positive_label, e.negative_label) as 'bucketlabels', e.include_practice + 0 as inc_practice 
		from exercises e 
		where e.project_key = project_key and e.exercise_num = exercise;
	else
		select e.*, concat_ws('|', e.positive_label, e.negative_label) as 'bucketlabels', e.include_practice + 0 as inc_practice, dpr.primes as dynamic_primes
		from exercises e
		inner join (select * from dynamic_primes_requests dpr where dpr.request_id = project_key and dpr.exercise = exercise) dpr on e.project_key = dpr.project_key
		where e.exercise_num = exercise;
		select dpr.project_key into project_key from dynamic_primes_requests dpr where dpr.request_id = project_key and dpr.exercise = exercise;
	end if;
	
	select * 
	from primes p 
	where p.project_key = project_key and p.exercise = exercise 
	and (prime_names is null or p.name REGEXP prime_names)
	order by p.idx;
	
	select t.*, 
		case t.bucket when 'top' then 'false' when 'bottom' then 'true' else t.bucket end as 'value' 
	from tasks t where t.project_key = project_key and t.exercise = exercise order by t.idx;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetProjects
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetProjects` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetProjects`(IN `api_key` VARCHAR(50))
BEGIN
select p.* 
from (select * from projects where client_id is not null) p
join (select * from users u where u.api_key = api_key) u on p.client_id = u.client_id or u.`type` = 'admin';
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetPurchaseExist
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetPurchaseExist` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetPurchaseExist`(IN purchase_id varchar(100))
BEGIN
select * from purchase_completes where purchase_completes.purchase_id = purchase_id ;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetRespondentsPerExerciseByProject
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetRespondentsPerExerciseByProject` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetRespondentsPerExerciseByProject`(IN `project_key` varchar(128))
BEGIN
SELECT exer.name AS yAxis,IFNULL(COUNT(sessionres.sessioncount),0) AS xAxis FROM(
(select name,project_key,exercise_num from exercises where exercises.project_key = project_key) as exer
left join
(
SELECT  str.Exercise,count(str.session_id) sessioncount
FROM session_task_results str
where str.project_id= project_key
GROUP BY str.Exercise,str.session_id) as sessionres
on sessionres.Exercise = exer.exercise_num) GROUP BY exer.name order by exer.exercise_num desc;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetResponseByProject
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetResponseByProject` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetResponseByProject`(IN `project_key` varchar(128))
BEGIN
declare first_date timestamp;
declare sfirst_date timestamp;
declare last_date timestamp;
set @my_var=0;
/*select 
	min(session_results_timestamp)
	#,max(session_results_timestamp) 
	into 
	first_date
	#,last_date
	from  
	session_results 
	where 
	project_id=project_key 
	or 
	project_id in (select dpr.request_id from dynamic_primes_requests dpr where dpr.project_key = project_key);
*/

select added - INTERVAL 5 HOUR /* one more hour back, so we can see the completes rise from 0 */
into first_date
from projects p
where p.project_key = project_key;

set last_date = now() - interval 4 hour;
set sfirst_date := first_date;
set @df = datediff(last_date,first_date);

if @df is null then
select 
	null as xAxis,
    null as yAxis limit 0;
end if;

if @df < 1 then #Execute when day diffrence is <1
begin
	SELECT  
		case when AllHours.Hours <= 10 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ',CONCAT(AllHours.Hours + 1,'' ,'AM')) 
			 when AllHours.Hours  = 11 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ','12PM')
			 when AllHours.Hours = 23 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ','12AM')
			else CONCAT(left(monthname(first_date),3),' ',day(first_date),' ',CONCAT(AllHours.Hours - 11 ,'' ,'PM')) end as xAxis,
		cast(count(distinct session_id) as char) as yAxis
	 FROM 
	   (
			 SELECT  0 AS Hours
			 UNION ALL SELECT  1 UNION ALL SELECT  2 UNION ALL SELECT  3
			 UNION ALL SELECT  4 UNION ALL SELECT  5 UNION ALL SELECT  6
			 UNION ALL SELECT  7 UNION ALL SELECT  8 UNION ALL SELECT  9
			 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
			 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
			 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18
			 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21
			 UNION ALL SELECT 22 UNION ALL SELECT 23
	  )      AS AllHours 
	left join
	(
	select 
		session_id,session_results_timestamp
	from 
		session_results sr
	where 
		(sr.project_id = project_key
	or 
		sr.project_id 
		in 
			(select dpr.request_id from dynamic_primes_requests dpr where dpr.project_key = project_key))
	and 
		(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))

	) as SessionValue
on hour(`session_results_timestamp`) = AllHours.Hours 

group by AllHours.Hours;

end;
END if;
if @df >= 1 && @df <= 30 then #Execute when day diffrence is >= 1 and <= 30
begin
SET @@session.sql_notes = 0;

DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);

while sfirst_date <= last_date 
do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 1 day);
end while;


SELECT  CONCAT(left(monthname(rdate),3),' ', day(rdate)) AS xAxis,yAxis
 FROM 
  dtRange drn
		left join
		(
		select 
			date(session_results_timestamp) as rspdate,
			cast(count(distinct session_id) as char) as yAxis
		from session_results sr
		where (sr.project_id = project_key
		or sr.project_id in 
			(select dpr.request_id 
				from dynamic_primes_requests dpr 
				where 
				dpr.project_key = project_key))
				and 
			(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))
			group by date(session_results_timestamp)
		) as SessionValue
on  date(drn.rdate) = date(rspdate)
order by drn.rdate;
end;
END if;

if @df >= 31 && @df <= 90 then #Execute when day diffrence is >=31 and <= 90
begin

SET @@session.sql_notes = 0;
DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);
while sfirst_date <= date_add(last_date,interval 7 day) 
do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 7 day);
end while;

SELECT  distinct week(rdate),cast(date(rdate) as char) AS xAxis,yAxis
 FROM 
  dtRange drn
	left join
	(
	select 
		date(session_results_timestamp) as rspdate,
		cast(count(distinct session_id) as char) as yAxis
	from session_results sr
		where (sr.project_id = project_key
		or sr.project_id in 
		(select dpr.request_id 
		from dynamic_primes_requests dpr 
		where 
		dpr.project_key = project_key))
		and 
		(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))
		group by week(session_results_timestamp)
	) as SessionValue
on  week(drn.rdate) = week(rspdate)
order by drn.rdate;
end;
END if;
if @df >90 then #Execute when day diffrence is ?= 90
begin
SET @@session.sql_notes = 0;
DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);
doloop : while  year(sfirst_date) <= year(last_date)
 do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 1 month);
	if month(sfirst_date) > month(last_date) &&  year(sfirst_date) = year(last_date) then
		leave doloop;
	end if;
end while;

SELECT  distinct month(rdate), concat(left(monthname(rdate),3),' ',year(rdate)) AS xAxis,yAxis
 FROM 
  dtRange drn
	left join
	(
	select 
		date(session_results_timestamp) as rspdate, 
		cast(count(distinct session_id) as char) as yAxis
	from 
		session_results sr
	where 
	(sr.project_id = project_key
	or sr.project_id in 
	(select 
		dpr.request_id 
		from 
			dynamic_primes_requests dpr 
		where dpr.project_key = project_key))
		and 
		(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))
	group by month(session_results_timestamp)
    ) as SessionValue
on  month(drn.rdate) = month(rspdate)
order by drn.rdate;
end;
END if;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetResponseByProject_old
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetResponseByProject_old` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetResponseByProject_old`(IN `project_key` varchar(128))
BEGIN
declare first_date timestamp;
declare sfirst_date timestamp;
declare last_date timestamp;
set @my_var=0;
select 
	min(session_results_timestamp),
	max(session_results_timestamp) 
	into 
	first_date,
	last_date
	from  
	session_results 
	where 
	project_id=project_key 
	or 
	project_id in (select dpr.request_id from dynamic_primes_requests dpr where dpr.project_key = project_key);


set sfirst_date := first_date;
set @df = datediff(last_date,first_date);

if @df is null then
select 
	null as xAxis,
    null as yAxis limit 0;
end if;

if @df < 1 then #Execute when day diffrence is <1
begin
	SELECT  
		case when AllHours.Hours <= 10 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ',CONCAT(AllHours.Hours + 1,'' ,'AM')) 
			 when AllHours.Hours  = 11 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ','12PM')
			 when AllHours.Hours = 23 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ','12AM')
			else CONCAT(left(monthname(first_date),3),' ',day(first_date),' ',CONCAT(AllHours.Hours - 11 ,'' ,'PM')) end as xAxis,
		cast(count(distinct session_id) as char) as yAxis
	 FROM 
	   (
			 SELECT  0 AS Hours
			 UNION ALL SELECT  1 UNION ALL SELECT  2 UNION ALL SELECT  3
			 UNION ALL SELECT  4 UNION ALL SELECT  5 UNION ALL SELECT  6
			 UNION ALL SELECT  7 UNION ALL SELECT  8 UNION ALL SELECT  9
			 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
			 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
			 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18
			 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21
			 UNION ALL SELECT 22 UNION ALL SELECT 23
	  )      AS AllHours 
	left join
	(
	select 
		session_id,session_results_timestamp
	from 
		session_results sr
	where 
		(sr.project_id = project_key
	or 
		sr.project_id 
		in 
			(select dpr.request_id from dynamic_primes_requests dpr where dpr.project_key = project_key))
	and 
		(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))

	) as SessionValue
on hour(`session_results_timestamp`) = AllHours.Hours 

group by AllHours.Hours;

end;
END if;
if @df >= 1 && @df <= 30 then #Execute when day diffrence is >= 1 and <= 30
begin
SET @@session.sql_notes = 0;

DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);

while sfirst_date <= last_date 
do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 1 day);
end while;


SELECT  CONCAT(left(monthname(rdate),3),' ', day(rdate)) AS xAxis,yAxis
 FROM 
  dtRange drn
		left join
		(
		select 
			date(session_results_timestamp) as rspdate,
			cast(count(distinct session_id) as char) as yAxis
		from session_results sr
		where (sr.project_id = project_key
		or sr.project_id in 
			(select dpr.request_id 
				from dynamic_primes_requests dpr 
				where 
				dpr.project_key = project_key))
				and 
			(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))
			group by date(session_results_timestamp)
		) as SessionValue
on  date(drn.rdate) = date(rspdate)
order by drn.rdate;
end;
END if;

if @df >= 31 && @df <= 90 then #Execute when day diffrence is >=31 and <= 90
begin

SET @@session.sql_notes = 0;
DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);
while sfirst_date <= date_add(last_date,interval 7 day) 
do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 7 day);
end while;

SELECT  distinct week(rdate),cast(date(rdate) as char) AS xAxis,yAxis
 FROM 
  dtRange drn
	left join
	(
	select 
		date(session_results_timestamp) as rspdate,
		cast(count(distinct session_id) as char) as yAxis
	from session_results sr
		where (sr.project_id = project_key
		or sr.project_id in 
		(select dpr.request_id 
		from dynamic_primes_requests dpr 
		where 
		dpr.project_key = project_key))
		and 
		(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))
		group by week(session_results_timestamp)
	) as SessionValue
on  week(drn.rdate) = week(rspdate)
order by drn.rdate;
end;
END if;
if @df >90 then #Execute when day diffrence is ?= 90
begin
SET @@session.sql_notes = 0;
DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);
doloop : while  year(sfirst_date) <= year(last_date)
 do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 1 month);
	if month(sfirst_date) > month(last_date) &&  year(sfirst_date) = year(last_date) then
		leave doloop;
	end if;
end while;

SELECT  distinct month(rdate), concat(left(monthname(rdate),3),' ',year(rdate)) AS xAxis,yAxis
 FROM 
  dtRange drn
	left join
	(
	select 
		date(session_results_timestamp) as rspdate, 
		cast(count(distinct session_id) as char) as yAxis
	from 
		session_results sr
	where 
	(sr.project_id = project_key
	or sr.project_id in 
	(select 
		dpr.request_id 
		from 
			dynamic_primes_requests dpr 
		where dpr.project_key = project_key))
		and 
		(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))
	group by month(session_results_timestamp)
    ) as SessionValue
on  month(drn.rdate) = month(rspdate)
order by drn.rdate;
end;
END if;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetResponseByProject_TrialProjects
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetResponseByProject_TrialProjects` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetResponseByProject_TrialProjects`(IN `project_key` varchar(128))
BEGIN
declare first_date timestamp;
declare sfirst_date timestamp;
declare last_date timestamp;
set @my_var=0;

/*select max(last_updated)- INTERVAL 4 HOUR 
	into 
	last_date
	from  
	respondent_results rr
	where 
	rr.project_key = project_key;
*/

set last_date = now() - interval 4 hour;
/* take current time as last date */


select added - INTERVAL 5 HOUR /* one more hour back, so we can see the completes rise from 0 */
into first_date
from projects p
where p.project_key = project_key;

set sfirst_date := first_date;
set @df = datediff(last_date,first_date);

if @df is null then
BEGIN
select 
	null as xAxis,
    null as yAxis limit 0;
END;


elseif @df < 1 then #Execute when day diffrence is <1
begin
	SELECT  
		case when AllHours.Hours <= 10 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ',CONCAT(AllHours.Hours + 1,'' ,'AM')) 
			 when AllHours.Hours  = 11 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ','12PM')
			 when AllHours.Hours = 23 then CONCAT(left(monthname(first_date),3),' ',day(first_date),' ','12AM')
			else CONCAT(left(monthname(first_date),3),' ',day(first_date),' ',CONCAT(AllHours.Hours - 11 ,'' ,'PM')) end as xAxis,
		cast(count(distinct response_id) as char) as yAxis
	 FROM 
	   (
			SELECT * FROM (
					 SELECT  0 AS Hours
					 UNION ALL SELECT  1 UNION ALL SELECT  2 UNION ALL SELECT  3
					 UNION ALL SELECT  4 UNION ALL SELECT  5 UNION ALL SELECT  6
					 UNION ALL SELECT  7 UNION ALL SELECT  8 UNION ALL SELECT  9
					 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
					 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
					 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18
					 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21
					 UNION ALL SELECT 22 UNION ALL SELECT 23
					) AS cHours  where Hours <= hour(last_date) 
/* Hours <= hour(now() - INTERVAL 4 HOUR) for, if the last update is today, so it will fetch only up to current hours, 
last_updated < now() for the projects that have the difference < 1 day but last response was yesterday, so it will fetch 
complete hours */
	  )      AS AllHours 
	left join
	(
	select 
		rr.response_id, rr.last_updated - INTERVAL 4 HOUR as last_updated
	from 
		respondent_results rr
	where 
		rr.project_key = project_key
	and 
		(rr.last_updated - INTERVAL 4 HOUR  >= first_date and rr.last_updated - INTERVAL 4 HOUR <= last_date)
		/*(date(rr.last_updated) >= date(first_date) and date(rr.last_updated) <= date(last_date))*/

	) as SessionValue on hour(`last_updated`) = AllHours.Hours 
	where AllHours.Hours >= hour(first_date)
group by AllHours.Hours;
/*having AllHours.Hours <= hour(now() - INTERVAL 4 HOUR)   <-- Parvez, please change this so we account for projects less than a day old that were created the previous day */ 
/* Comment By Parvez */
/* see the changes and comments on line Number 56 onwards.*/
end;

elseif @df >= 1 && @df <= 30 then #Execute when day diffrence is >= 1 and <= 30
begin
SET @@session.sql_notes = 0;

DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);

while date(sfirst_date) <= date(now() - INTERVAL 4 HOUR) 
do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 1 day);
end while;


SELECT  CONCAT(left(monthname(rdate),3),' ', day(rdate)) AS xAxis, case when yAxis is null then 0 else yAxis end as yAxis
 FROM 
  dtRange drn
		left join
		(
		select 
			date(last_updated) as rspdate,
			cast(count(distinct rr.response_id ) as char) as yAxis
		from respondent_results rr
		where rr.project_key = project_key
/*				and 
			(date(last_updated) >= date(first_date) and date(last_updated) <= date(last_date)) */
			group by date(last_updated)
		) as SessionValue
on date(drn.rdate) = date(rspdate)
order by drn.rdate;
end;


elseif @df >= 31 && @df <= 90 then #Execute when day diffrence is >=31 and <= 90.  We don't execute until the current date in this case - only until the date of the last response
begin

SET @@session.sql_notes = 0;
DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);
while sfirst_date <= date_add(last_date,interval 7 day) 
do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 7 day);
end while;

SELECT  distinct week(rdate),cast(date(rdate) as char) AS xAxis,yAxis
 FROM 
  dtRange drn
	left join
	(
	select 
		date(session_results_timestamp) as rspdate,
		cast(count(distinct session_id) as char) as yAxis
	from session_results sr
		where (sr.project_id = project_key
		or sr.project_id in 
		(select dpr.request_id 
		from dynamic_primes_requests dpr 
		where 
		dpr.project_key = project_key))
		and 
		(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))
		group by week(session_results_timestamp)
	) as SessionValue
on  week(drn.rdate) = week(rspdate)
order by drn.rdate;
end;

elseif @df >90 then #Execute when day diffrence is ?= 90
begin
SET @@session.sql_notes = 0;
DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate timestamp);
doloop : while  year(sfirst_date) <= year(last_date)
 do
	insert into dtRange(rdate) values (sfirst_date);
	set sfirst_date = date_add(sfirst_date,interval 1 month);
	if month(sfirst_date) > month(last_date) &&  year(sfirst_date) = year(last_date) then
		leave doloop;
	end if;
end while;

SELECT  distinct month(rdate), concat(left(monthname(rdate),3),' ',year(rdate)) AS xAxis,yAxis
 FROM 
  dtRange drn
	left join
	(
	select 
		date(session_results_timestamp) as rspdate, 
		cast(count(distinct session_id) as char) as yAxis
	from 
		session_results sr
	where 
	(sr.project_id = project_key
	or sr.project_id in 
	(select 
		dpr.request_id 
		from 
			dynamic_primes_requests dpr 
		where dpr.project_key = project_key))
		and 
		(date(session_results_timestamp) >= date(first_date) and date(session_results_timestamp) <= date(last_date))
	group by month(session_results_timestamp)
    ) as SessionValue
on  month(drn.rdate) = month(rspdate)
order by drn.rdate;
end;
END if;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetResponseDates
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetResponseDates` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetResponseDates`(IN `project_key` varchar(50), IN `start_date` DATETIME, IN `end_date` DATETIME)
BEGIN
	select sr.response_id, max(used_timestamp) 'response_date'
	from session_requests sr
	where sr.project_id = project_key
	and sr.used_timestamp is not null
	group by sr.response_id
	having (start_date is null or response_date >= start_date) and (end_date is null or response_date <= end_date);
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetSignupRequest
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetSignupRequest` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetSignupRequest`(IN `signup_key` varCHAR(50))
BEGIN
	select signup_key, email
	from signup_requests sr
	where sr.signup_key = signup_key 
	and (sr.`status` = 'pending'
		or sr.email in (
			'areid@sentientdecisionscience.com',
			'ctaylor@sentientdecisionscience.com',
			'suvendu.banik@digitalavenues.com',
			'subrata.mukherjee@digitalavenues.com'
			)
		);
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetSignupRequestAll
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetSignupRequestAll` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetSignupRequestAll`(IN signup_key VARCHAR(50))
BEGIN
	SELECT signup_key, email, status, campaign_code, company_name  
	FROM signup_requests sr
	WHERE sr.signup_key = signup_key;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetSurveylengthHistogram
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetSurveylengthHistogram` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetSurveylengthHistogram`(IN `project_key` varchar(128))
BEGIN
declare maxdiff int;
declare smaxdiff int;
declare mindiff int;
declare rgap int;
/*set project_key := 'f3f76839ce97c0760a69a5fb396ebc1a';*/
set maxdiff =  (select max(timestampdiff(minute,srt.session_reqest_timestamp,sr.session_results_timestamp))
from session_requests srt
inner join session_results sr
on srt.session_id = sr.session_id where sr.project_id= project_key);

set smaxdiff := maxdiff;
/*
set mindiff := (select min(timestampdiff(minute,srt.session_reqest_timestamp,sr.session_results_timestamp))
from session_requests srt
inner join session_results sr
on srt.session_id = sr.session_id where sr.project_id=  project_key);
*/
set rgap := (select  miv from (
select (timestampdiff(minute,srt.session_reqest_timestamp,sr.session_results_timestamp)) as miv
from session_requests srt
inner join session_results sr
on srt.session_id = sr.session_id where sr.project_id=  project_key) as d 
where miv > 0
order by miv limit 1);
/*if mindiff = 0 then*/
set mindiff = rgap;
/*end if;*/

SET @@session.sql_notes = 0;
DROP TEMPORARY TABLE IF EXISTS dtRange;
CREATE TEMPORARY TABLE dtRange (rdate int);
while mindiff <= maxdiff do
insert into dtRange(rdate) values (mindiff);
set mindiff = mindiff + rgap;
end while;



DROP TEMPORARY TABLE IF EXISTS dtSession;
CREATE TEMPORARY TABLE dtSession AS (
select sr.session_id  as session_id,
timestampdiff(minute,srt.session_reqest_timestamp,sr.session_results_timestamp) as timeDiff
from session_requests srt
inner join session_results sr
on srt.session_id = sr.session_id where sr.project_id= project_key
);


SELECT (cast(dr.rdate as char))  as xAxis, 
(
select
COUNT(session_id) from  dtSession  
 where timeDiff  BETWEEN dr.rdate
 AND dr.rdate + rgap
 ) as yAxis
 FROM dtRange dr;

/*
SELECT count(session_id) as xAxis,rdate as yAxis
FROM 
(
select sr.session_id  as xAxis,
timestampdiff(minute,srt.session_reqest_timestamp,sr.session_results_timestamp) as timeDiff
from session_requests srt
inner join session_results sr
on srt.session_id = sr.session_id where sr.project_id= project_key
) as c
LEFT JOIN dtRange e on c.timeDiff BETWEEN dtRange.rdate AND dtRange.rdate;*/
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetSurveyLinkTemplates
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetSurveyLinkTemplates` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetSurveyLinkTemplates`()
BEGIN
select option_name,template from survey_link_templates;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetUser
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetUser` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetUser`(IN `api_key` varchar(100))
BEGIN

declare c_client_id int;
select users.client_id into c_client_id from users where users.api_key = api_key limit 1 ;
set c_client_id = 70;
select * from (
	select users.*,c.company from users 
left join clients c on c.id = users.client_id
where users.api_key = api_key and lower(users.type) != 'trial'  AND users.type != 'NonTrialusers'
	
) as userd 
inner join
(select sum(Coalesce(purchase_completes.no_completes,0)) as no_completes,sum(Coalesce(purchase_completes.total_studies,0)) as total_studies from purchase_completes where purchase_completes.api_key in (select users.api_key from users where users.client_id = c_client_id)
) as completes

inner join
(
/*
select sum(rr.sessions) as comp_session
from clients c
inner join projects p 
on c.id = p.client_id
inner join respondent_results rr 
on p.project_key = rr.project_key and rr.sessions IS NOT NULL AND rr.sessions <> 0
where c.id=client_id) as cp;
*/
select sum(total_completes) as comp_session from clients_complete_sessions where clients_complete_sessions.client_id = c_client_id) as cp;


END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetUserOld
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetUserOld` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spGetUserOld`(IN `api_key` INT)
BEGIN
select * from users u where u.api_key = api_key;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spGetVideoThumbnails
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spGetVideoThumbnails` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spGetVideoThumbnails`(IN project_key VARCHAR(100))
BEGIN
/*
SELECT vtr.video_url,vt.* FROM video_thumbnail_requests vtr
left join  video_thumbnails vt on vtr.project_key = vt.project_key
 WHERE vtr.project_key = project_key;
select vt.*,vtr.video_url,vtr.video_name from video_thumbnails vt 
left join video_thumbnail_requests vtr
on vtr.project_key = vt.project_key
and
vtr.video_index = vt.video_index
 WHERE vt.project_key = project_key;*/
select vt.id,vtr.project_key,vtr.video_index,vt.thumbnail_url,vt.height,vt.width,vt.slide_resize,vtr.video_url,vtr.video_name from 
 video_thumbnail_requests vtr
left join
video_thumbnails vt 
on vtr.project_key = vt.project_key
and
vtr.video_index = vt.video_index
 WHERE vtr.project_key = project_key;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spInsertProject
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spInsertProject` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spInsertProject`(IN `projectId` varchar(100) charset utf8, IN `projectDescription` varchar(200) charset utf8, IN `createdBy` varchar(100) charset utf8)
BEGIN
if NOT EXISTS (select 1 from projects where project_id = projectId) then
	insert into projects (project_id, description, created_by) values (projectId, projectDescription, createdBy);
end if  ;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spLogin
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spLogin` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spLogin`(IN `login` varchar(100) charset utf8, IN `password` BLOB)
BEGIN

declare cclient_id int;
select users.client_id into cclient_id from users where users.login = login and users.password = password and lower(users.type) != 'trial' limit 1 ;

select * from (
	select * from
		(
		select users.*,clients.company from
		 users ,clients  WHERE users.client_id = clients.id   and lower(users.type) != 'trial' 
		) NonTrialusers  where NonTrialusers.login = login and NonTrialusers.password = password AND NonTrialusers.type != 'NonTrialusers'
) as userd
inner join
(select sum(Coalesce(purchase_completes.no_completes,0)) as no_completes,sum(Coalesce(purchase_completes.total_studies,0)) as total_studies from purchase_completes where purchase_completes.api_key in (select users.api_key from users where users.client_id = cclient_id)
) as completes

inner join
(
/*
select sum(rr.sessions) as comp_session
from clients c
inner join projects p 
on c.id = p.client_id
inner join respondent_results rr 
on p.project_key = rr.project_key and rr.sessions IS NOT NULL AND rr.sessions <> 0
where c.id=client_id) as cp;
*/
select sum(total_completes) as comp_session from clients_complete_sessions where clients_complete_sessions.client_id = cclient_id) as cp;





/* old code
left join
(select sum(Coalesce(purchase_completes.no_completes,0)) as no_completes,sum(Coalesce(purchase_completes.total_studies,0)) as total_studies,api_key as ukey from purchase_completes group by purchase_completes.api_key) completes
on completes.ukey = userd.api_key
inner join(
/*
select sum(rr.sessions) as comp_session
from clients c
inner join projects p 
on c.id = p.client_id
inner join respondent_results rr 
on p.project_key = rr.project_key and rr.sessions IS NOT NULL AND rr.sessions <> 0
where c.id=client_id) as cp;

select sum(total_completes) as comp_session from clients_complete_sessions where clients_complete_sessions.client_id = client_id) as cp;
*/
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spLoginEO
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spLoginEO` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spLoginEO`(IN `login` varchar(100) charset utf8, IN `password` BLOB)
BEGIN
/*
select * from
(
select * from
 users WHERE lower(users.type) != 'trial' 
) NonTrialusers  where NonTrialusers.login = login and NonTrialusers.password = password;
*/
select * from
(
select users.*,clients.company from
 users ,clients  WHERE users.client_id = clients.id and lower(users.type) != 'trial' 
) NonTrialusers  where NonTrialusers.login = login and NonTrialusers.password = password;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spLogin_16-03-2013
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spLogin_16-03-2013` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spLogin_16-03-2013`(IN `login` varchar(100) charset utf8, IN `password` BLOB)
BEGIN

declare client_id int;
select users.client_id into client_id from users where users.login = login and users.password = password and lower(users.type) != 'trial' limit 1 ;

select * from (
	select * from
		(
		select users.*,clients.company from
		 users ,clients  WHERE users.client_id = clients.id   and lower(users.type) != 'trial' 
		) NonTrialusers  where NonTrialusers.login = login and NonTrialusers.password = password AND NonTrialusers.type != 'NonTrialusers'
) as userd
left join
(select sum(Coalesce(purchase_details.no_completes,0)) as no_completes,sum(Coalesce(purchase_details.total_studies,0)) as total_studies,api_key as ukey from purchase_details group by purchase_details.api_key) completes
on completes.ukey = userd.api_key
inner join
(
select ifnull(sum(comp_session), 0) as comp_session from
(
	select pr.project_key, max(pr.respondents) as comp_session
	from projects p 
	inner join project_results pr
	on p.project_key = pr.project_key
	where p.client_id = client_id
	group by pr.project_key
) t1
) as cp;


END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spMoveCATasksToNeutral
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spMoveCATasksToNeutral` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spMoveCATasksToNeutral`(IN `project_key` varchar(50), IN `exercise` int)
BEGIN
SET SQL_SAFE_UPDATES = 0;
update tasks
 set tasks.bucket = 'neutral' , tasks.target_type='affpr' where  tasks.project_key = project_key and tasks.exercise = exercise and tasks.target_type='ca';
SET SQL_SAFE_UPDATES = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spRemoveExercise
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spRemoveExercise` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spRemoveExercise`(IN `project_key` varchar(50), IN `exercise` INT)
BEGIN
SET SQL_SAFE_UPDATES = 0;
delete from exercises 
where exercises.exercise_num = exercise and exercises.project_key = project_key;

update exercises 
set exercise_num = exercise_num - 1
where exercises.exercise_num > exercise and exercises.project_key = project_key;

delete from primes 
where primes.exercise = exercise and primes.project_key = project_key;

delete from tasks
where tasks.exercise = exercise and tasks.project_key = project_key;

update tasks 
set tasks.exercise = tasks.exercise - 1
where tasks.exercise > exercise and tasks.project_key = project_key;

update primes 
set primes.exercise = primes.exercise - 1
where primes.exercise > exercise and primes.project_key = project_key;

Delete from project_custom_props where project_custom_props.project_key= project_key
and project_custom_props.exercise_num= exercise;

update project_custom_props 
set project_custom_props.exercise_num = project_custom_props.exercise_num - 1
where project_custom_props.exercise_num > exercise and project_custom_props.project_key = project_key;


SET SQL_SAFE_UPDATES = 1;




END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spRemoveMultiplePrimes
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spRemoveMultiplePrimes` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spRemoveMultiplePrimes`(IN `project_key` VARCHAR(100), IN `exercise` INT, IN `PrimeIDs` varchar(100))
BEGIN
/*	set @sql = concat("update primes set primes.audio_source='",audio_source,"' WHERE primes.project_key='",project_key,"' and primes.exercise='",exercise,"' and primes.id in (",PrimeIDs,")");
    PREPARE q FROM @sql;
    execute q;*/
set sql_safe_updates = 0;
delete from primes  where primes.project_key = project_key and primes.exercise = exercise and FIND_IN_SET(primes.id,  PrimeIDs);
set sql_safe_updates = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spRemovePrime
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spRemovePrime` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spRemovePrime`(IN `project_key` varchar(100), IN `prime_id` INT)
BEGIN
delete from primes 
where id = prime_id and primes.project_key = project_key;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spRemoveTask
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spRemoveTask` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spRemoveTask`(IN `project_key` varchar(50), IN `task_id` INT)
BEGIN
delete from tasks
where id = task_id and tasks.project_key = project_key;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spReplacePrimeImage
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spReplacePrimeImage` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spReplacePrimeImage`(IN `id` INT, IN `source` varchar(255))
BEGIN
SET SQL_SAFE_UPDATES = 0;
	update primes
	set primes.source = source, primes.raw_source = source 
	where primes.id = id;
SET SQL_SAFE_UPDATES = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spReplaceTaskImage
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spReplaceTaskImage` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spReplaceTaskImage`(IN `id` INT, IN `source` varchar(255))
BEGIN
SET SQL_SAFE_UPDATES = 0;
	update tasks
	set tasks.source = source, tasks.raw_source = source 
	where tasks.id = id;
SET SQL_SAFE_UPDATES = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spResults_Associations
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spResults_Associations` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spResults_Associations`(IN `project_key` varchar(50), IN `exercise_num` INT)
BEGIN
select
	p.name as focal_item_label,
	p.source as focal_item_source,
	pr.index_value as value,
	pr.down_bucket as label,
	pr.up_bucket as opposite
from 
	(select * from project_results pr where pr.project_key = project_key and pr.exercise >= exercise_num) pr
	join (select * from primes where focus = 1) p on p.project_key = pr.project_key and p.exercise = pr.exercise and pr.source_label = fnAlphaNumeric(p.name)
order by focus desc;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spResults_RevPrimeAssociatons
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spResults_RevPrimeAssociatons` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spResults_RevPrimeAssociatons`(IN `project_key` varchar(50), IN `exercise_num` INT)
BEGIN
select 
	pr.source_label as label, 
	p.source as source,
	pr.index_value as value, 
	t.name as focal_item_label,
	t.source as focal_item_source
from (select * from project_results pr where pr.project_key = project_key and pr.exercise >= exercise_num) pr
join (select * from tasks t where focus = 1 and t.project_key = project_key and t.exercise >= exercise_num limit 1) t on t.name = pr.down_bucket
join (select distinct name, source from primes p where p.project_key = project_key and p.exercise = exercise_num) p on p.name = pr.source_label;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaTaskToCA
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaTaskToCA` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaTaskToCA`(IN `project_key` varchar(50), IN `exercise` int)
BEGIN
SET SQL_SAFE_UPDATES = 0;
update tasks
 set tasks.bucket = '' , tasks.target_type='ca' where  tasks.project_key = project_key and tasks.exercise = exercise and tasks.target_type !='ca';
SET SQL_SAFE_UPDATES = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveClient
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveClient` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveClient`(IN api_key VARCHAR(100),IN company VARCHAR(100),IN client_key VARCHAR(50),IN ipaddress VARCHAR(100),IN client_type VARCHAR(5),OUT code int ,OUT description  varchar(255))
Toplevel : BEGIN
if (ipaddress != null || length(ipaddress) > 0) then
begin
   /* IF not EXISTS(select 1 from  whitelist_ip where  whitelist_ip.ipaddress = ipaddress) THEN*/
	if fnCheckWhitelist_ip(ipaddress) = false then
		BEGIN
			set code  = 1;
			SET description  = 'Unauthorized Access with ip';
		    leave Toplevel;
		END;
	END IF;
end;
end if;
/* check for type admin */
IF not EXISTS(select 1 from  users where  users.type = 'admin' and users.api_key = api_key and users.status ='active') THEN
		BEGIN
			set code  = 1;
			SET description  = 'Unauthorized Access with role';
			leave Toplevel;
		END;
	END IF;

IF length(trim(company)) = 0 then
		BEGIN
			set code  = 1;
			SET description  = 'Company cannot be blank';
			leave Toplevel;
		END;
	END IF;


IF EXISTS(select 1 from  clients where  clients.client_key = client_key) THEN
		BEGIN
			update  clients
				set clients.company = company,client_type = client_type
			 where	clients.client_key = client_key;
			set code  = 0;
		  SET description  = client_key;	
			
		END;
		else
		BEGIN
		INSERT INTO clients(client_key,company,client_type) values (client_key,company,client_type);
		set code  = 0;
		SET description  = client_key;	
		END;
		
	END IF;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveDynamicPrimesRequest
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveDynamicPrimesRequest` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spSaveDynamicPrimesRequest`(IN `request_id` varchar(200) charset utf8, IN `project_key` varchar(50), IN `exercise` INT, IN `primes` text  charset utf8)
    MODIFIES SQL DATA
BEGIN
		insert into dynamic_primes_requests 
			(request_id, project_key, exercise, primes)
		values 
			(request_id, project_key, exercise, primes)
		on duplicate key update
			project_key = project_key, primes = primes, exercise = exercise;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveDynamicPrimesRequestV2
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveDynamicPrimesRequestV2` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveDynamicPrimesRequestV2`(IN `request_id` varchar(200) charset utf8, IN `project_key` varchar(50), IN `exercise` INT, IN `primes` text  charset utf8, IN `custom_data` MEDIUMTEXT)
    MODIFIES SQL DATA
BEGIN
		insert into dynamic_primes_requests 
			(request_id, project_key, exercise, primes,custom_data)
		values 
			(request_id, project_key, exercise, primes,custom_data)
		on duplicate key update
			project_key = project_key, primes = primes, exercise = exercise, custom_data=custom_data;
			

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveOptimizeImageCompleted
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveOptimizeImageCompleted` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveOptimizeImageCompleted`(IN id INT)
BEGIN
update  optimize_image
set is_completed = true,
completed_date = NOW()
where optimize_image.id = id;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveOptimizeImageDetails
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveOptimizeImageDetails` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveOptimizeImageDetails`(IN project_key VARCHAR(32),IN exercise_num INT,IN width INT,IN height INT,IN email_id VARCHAR(100))
BEGIN
INSERT INTO optimize_image(project_key,exercise_num,width,height,created_date,is_completed,email_id)
values (project_key,exercise_num,width,height,now(),false,email_id);
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSavePassword
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSavePassword` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSavePassword`(IN `login` VARCHAR(100),IN Client_id int, ppassword BLOB,IN UserLoggedin BIT)
BEGIN  


if UserLoggedin = false and  Client_id = 0 then
begin
select p.login,p.Client_id into login,Client_id from password_requests p where p.request_key = login;
end;
end if;

if UserLoggedin = false and Client_id != 0 then
begin
select p.login,p.Client_id into login,Client_id from users p where p.api_key = login;
end;
end if;


select login;
select client_id;
set sql_safe_updates = 0;
UPDATE users
SET 
 password = ppassword
WHERE 
 users.login = login and users.Client_id = Client_id;
delete from password_requests where password_requests.login = login and password_requests.Client_id = Client_id;
set sql_safe_updates = 1;
  END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSavePasswordEO
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSavePasswordEO` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSavePasswordEO`(IN `login` VARCHAR(100),IN Client_id int, ppassword BLOB,IN UserLoggedin BIT)
BEGIN  

if UserLoggedin = false then
begin
select p.login,p.Client_id into login,Client_id from password_requests p where p.request_key = login;
end;
end if;
select login;
select client_id;
set sql_safe_updates = 0;
UPDATE users
SET 
 password = ppassword
WHERE 
 users.login = login and users.Client_id = Client_id;
delete from password_requests where password_requests.login = login and password_requests.Client_id = Client_id;
set sql_safe_updates = 1;
  END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSavePasswordRequest
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSavePasswordRequest` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSavePasswordRequest`(IN login VARCHAR(100), IN Client_Id int,INOUT newid varchar(100))
BEGIN  
set newid = MD5(concat(UUID(), login));
	if not exists (select 1 from password_requests 
             WHERE password_requests.login =  login and password_requests.Client_id = Client_Id) then
INSERT INTO password_requests(created_date,login,Client_id,request_key) 
 values(now(),login,Client_Id,newid);  
select newid;
else
BEGIN
set sql_safe_updates = 0;
update password_requests  set created_date = now() where password_requests.login = login and password_requests.Client_id = Client_Id;
set newid = (select request_key from password_requests where password_requests.login = login and password_requests.Client_id = Client_Id);
set sql_safe_updates = 1;
select newid;
END;
end if;
end */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSavePrime
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSavePrime` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSavePrime`(IN `project_key` VARCHAR(100), IN `exercise` INT, IN `source` varchar(255), IN `name` varchar(100), IN `label` varchar(100),IN focus BIT, IN `idx` smALLINT,IN raw_source VARCHAR(255),IN audio_source VARCHAR(255))
BEGIN

declare newid int;
set newid = (select id from primes where primes.client_id = (select client_id from projects where projects.project_key = project_key) and primes.project_key = project_key and primes.source = source and primes.exercise = exercise);
		insert into primes
			(client_id, project_key, name, label, exercise, idx, source,raw_source,audio_source,focus)
		select p.client_id, p.project_key, name, label, exercise, idx, source,raw_source,audio_source,focus
			from projects p
			where p.project_key = project_key
		on duplicate key update
			name = name, label = label, source = source,raw_source=raw_source,audio_source=audio_source,focus= focus, idx = idx;
if newid is null or newid = 0 then
begin
set newid = (select last_insert_id());
if focus = true then
begin
update primes
 set primes.focus = 0 where  primes.project_key = project_key and primes.exercise = exercise and id != newid;
end;
end if;
end;
end if;
select  id from primes where primes.id = newid;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSavePrimeData
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSavePrimeData` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSavePrimeData`(IN `id` INT, IN `name` varchar(100), IN `label` varchar(100), IN `idx` INT,IN focus BIT)
BEGIN

if label = '' or label is null then
select primes.label into label from primes where primes.id = id;
end if;

	update primes
	set name = name, label = label, idx = idx, focus= focus
	where primes.id = id;
IF focus = TRUE then
begin
declare projectkey varchar(100);
declare exercise_num int;
select project_key,exercise into projectkey,exercise_num from primes where primes.id = id;
 update primes
 set primes.focus = 0 where  primes.project_key= projectkey and  primes.exercise = exercise_num and primes.id != id;
end;
end if;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveProject
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveProject` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveProject`(IN `project_key` varchar(32), IN `title` varchar(100), IN `description` varchar(255), IN `loading_label` varchar(255), IN `launched` bit, IN `active` tinyint, IN `deleted` datetime, IN `EndofSurvey` char(10), IN `ButtonLabel` VARCHAR(255), IN `RedirectToPage` text, IN `ShowResult` CHAR(5), IN `lang` int, IN `launched_date` DATETIME, IN `version_id` INT)
BEGIN
SET SQL_SAFE_UPDATES = 0;
update projects
	set projects.title = title,
	projects.project_id = title,
	description = description,
	loading_label = loading_label,
	launched = launched,
	active = active,
	deleted = deleted,
	EndofSurvey = EndofSurvey,
	ButtonLabel	= ButtonLabel,
	RedirectToPage = RedirectToPage,
	ShowResult = ShowResult,	
	lang = lang,
	launched_date = launched_date,
	version_id = version_id		
where projects.project_key = project_key;
SET SQL_SAFE_UPDATES = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveProjectCustomProperties
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveProjectCustomProperties` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveProjectCustomProperties`(IN `project_key` VARCHAR(128),IN exercise_num INT, IN `key` VARCHAR(255),IN `value` VARCHAR(255),IN `id` INT)
BEGIN  

	if (id = 0) then
INSERT INTO project_custom_props(project_key,exercise_num,`key`,`value`) 
 values(project_key,exercise_num,`key`,`value`);  
else
BEGIN
update project_custom_props  set project_custom_props.key = `key`,
project_custom_props.value = value where project_custom_props.id = id;
END;
end if;

end */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveProjectExercise
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveProjectExercise` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveProjectExercise`(IN `project_key` VARCHAR(50), IN `exercise_num` INT, IN `name` varchar(100),IN `randomize_exercise` bit,  IN `seconds_before_prime` decimal(4,2), IN `positive_label` varchar(50), IN `negative_label` varchar(50), IN `positive_sound` VARCHAR(100), IN `negative_sound` varchar(100), IN `prime_seconds` decimal(4,2), IN `sort_expiration_seconds` decimal(4,2), IN `accuracy_mean` decimal(2,2), IN `accuracy_stdev` decimal(2,2), IN `speed_mean` decimal(3,2), IN `speed_stdev` decimal(3,2), IN `instructions` text, IN `instructions_touchscreen` text,IN `pctg_task_display` decimal(3,2), IN `randomize_tasks` bit, IN `repeated_measures` tinyint,IN `include_practice` bit,IN `practice_instructions` text ,IN `practice_instructions_touchscreen` text ,IN `practice_repeated_measures` tinyint,IN automatically_resize_images BIT)
BEGIN
if positive_sound = '' or positive_sound is null then
select exercises.positive_sound into positive_sound from exercises where exercises.project_key = project_key and exercises.exercise_num = exercise_num;
end if;
if negative_sound = '' or negative_sound is null then
select exercises.negative_sound into negative_sound from exercises where exercises.project_key = project_key and exercises.exercise_num = exercise_num;
end if;
		insert into exercises
			(project_key, 
			exercise_num, 
			name, 
			positive_label, 
			negative_label, 
			seconds_before_prime, 
			prime_seconds, 
			sort_expiration_seconds, 
			accuracy_mean, 
			accuracy_stdev,
			speed_mean,
			speed_stdev,
			instructions,
			instructions_touchscreen,
			amt_completed_label,
			positive_sound,
			negative_sound,
			randomize_tasks,
			pctg_task_display,
			repeated_measures,
			include_practice,
			practice_instructions,
			practice_instructions_touchscreen,
			practice_repeated_measures,
			randomize_exercise,
			automatically_resize_images
)
		select p.project_key, 
			exercise_num, 
			name,
			positive_label, 
			negative_label, 
			seconds_before_prime, 
			prime_seconds, 
			sort_expiration_seconds, 
			accuracy_mean, 
			accuracy_stdev,
			speed_mean,
			speed_stdev,
			instructions,
			instructions_touchscreen,
			/*replace(instructions,'<br/>','\n'),
			replace(instructions_touchscreen,'<br/>','\n'),*/
			'',
			positive_sound,
			negative_sound,
			randomize_tasks,
			pctg_task_display,
			repeated_measures,
			include_practice,
			practice_instructions,
			practice_instructions_touchscreen,
			practice_repeated_measures,
			randomize_exercise,
			automatically_resize_images
			from projects p where p.project_key = project_key
		on duplicate key update
			name = name, 
			seconds_before_prime = seconds_before_prime, 
			prime_seconds = prime_seconds, 
			sort_expiration_seconds = sort_expiration_seconds,
			accuracy_mean = accuracy_mean, 
			accuracy_stdev = accuracy_stdev,
			speed_mean = speed_mean,
			speed_stdev = speed_stdev,
			/*instructions = replace(instructions,'<br/>','\n'),
			instructions_touchscreen = replace(instructions_touchscreen,'<br/>','\n'),*/
			instructions = instructions,
			instructions_touchscreen = instructions_touchscreen,
			amt_completed_label = amt_completed_label,
			positive_label = positive_label,
			positive_sound = positive_sound,
			negative_label = negative_label,
			negative_sound = negative_sound,
			randomize_tasks = randomize_tasks,
			pctg_task_display = pctg_task_display,
			repeated_measures = repeated_measures,
			include_practice  = include_practice,
			practice_instructions = practice_instructions,
			practice_instructions_touchscreen = practice_instructions_touchscreen,
			practice_repeated_measures = practice_repeated_measures,
			randomize_exercise		=	randomize_exercise,
			automatically_resize_images = automatically_resize_images;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveProjectExerciseLabel
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveProjectExerciseLabel` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spSaveProjectExerciseLabel`(IN `project_key` VARCHAR(50), IN `exercise` INT, IN `label_id` VARCHAR(50), IN `label_value` TEXT, IN `label_type` CHAR(1))
BEGIN
	INSERT INTO prime_target_labels 
		(label_value, project_key, exercise, label_id, label_type)
	values 
		(label_value, project_key, exercise, label_id, label_type)
	ON DUPLICATE KEY UPDATE 
		label_value = label_value;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveProjectExerciseV2
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveProjectExerciseV2` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveProjectExerciseV2`(IN project_key VARCHAR(50), IN exercise_num INT, IN name varchar(100),IN randomize_exercise bit,  IN seconds_before_prime decimal(4,2), IN positive_label varchar(50), IN negative_label varchar(50), IN positive_sound VARCHAR(100), IN negative_sound varchar(100), IN prime_seconds decimal(4,2), IN sort_expiration_seconds decimal(4,2), IN accuracy_mean decimal(2,2), IN accuracy_stdev decimal(2,2), IN speed_mean decimal(3,2), IN speed_stdev decimal(3,2), IN instructions text, IN pctg_task_display decimal(3,2), IN randomize_tasks bit, IN repeated_measures tinyint,IN include_practice bit,IN practice_instructions text ,IN practice_repeated_measures tinyint)
BEGIN
		insert into exercises
			(project_key, 
			exercise_num, 
			name, 

			positive_label, 
			negative_label, 
			seconds_before_prime, 
			prime_seconds, 
			sort_expiration_seconds, 
			accuracy_mean, 
			accuracy_stdev,
			speed_mean,
			speed_stdev,
			instructions,
			amt_completed_label,
			positive_sound,
			negative_sound,
			randomize_tasks,
			pctg_task_display,
			repeated_measures,
			include_practice,
			practice_instructions,
			practice_repeated_measures,
			randomize_exercise
)
		select p.project_key, 
			exercise_num, 
			name,
			positive_label, 
			negative_label, 
			seconds_before_prime, 
			prime_seconds, 
			sort_expiration_seconds, 
			accuracy_mean, 
			accuracy_stdev,
			speed_mean,
			speed_stdev,
			instructions,
			'',
			positive_sound,
			negative_sound,
			randomize_tasks,
			pctg_task_display,
			repeated_measures,
			include_practice,
			practice_instructions,
			practice_repeated_measures,
			randomize_exercise
			from projects p where p.project_key = project_key
		on duplicate key update
			name = name, 
			seconds_before_prime = seconds_before_prime, 
			prime_seconds = prime_seconds, 
			sort_expiration_seconds = sort_expiration_seconds,
			accuracy_mean = accuracy_mean, 
			accuracy_stdev = accuracy_stdev,
			speed_mean = speed_mean,
			speed_stdev = speed_stdev,
			instructions = instructions,
			amt_completed_label = amt_completed_label,
			positive_label = positive_label,
			positive_sound = positive_sound,
			negative_label = negative_label,
			negative_sound = negative_sound,
			randomize_tasks = randomize_tasks,
			pctg_task_display = pctg_task_display,
			repeated_measures = repeated_measures,
			include_practice  = include_practice,
			practice_instructions = practice_instructions,
			practice_repeated_measures = practice_repeated_measures,
			randomize_exercise		=	randomize_exercise;	
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveResultsPendingEstimation
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveResultsPendingEstimation` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveResultsPendingEstimation`(IN proj_id varchar(128), IN sess_id VARCHAR(64))
BEGIN  
	INSERT INTO results_pending_estimation SELECT * FROM session_task_results WHERE project_id = proj_id AND session_id = sess_id;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveSessionResults
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveSessionResults` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 PROCEDURE `spSaveSessionResults`(IN `project_key` char(64), IN `response_id` varchar(128), IN `exercise` smallint, IN `source_label` varchar(256), IN `task_type` varchar(64), IN `index_value` decimal(13,10), IN `session_id` char(64), IN `up_bucket` char(64), IN `down_bucket` char(64))
BEGIN

	declare new_respondent bit;
	DECLARE c_client_id INT;
/* Calculate the session length */
	declare session_length time;
	set session_length := (select timediff(used_timestamp, session_reqest_timestamp) from session_requests sr where sr.session_id = session_id);

/* If this index value for this RESPONDENT already exists, update the row for this respondent.  Else, insert it. */	
	if not exists (select 1 from respondent_results rr where rr.project_key = project_key and rr.response_id = response_id and rr.exercise = exercise and rr.source_label = source_label and up_bucket = up_bucket and down_bucket = down_bucket) THEN 
		insert into respondent_results 
			(project_key, response_id, exercise, source_label, up_bucket, down_bucket, task_type, index_value, session_length, last_updated)
		values 
			(project_key, response_id, exercise, source_label, up_bucket, down_bucket, task_type, index_value, session_length, now());
		set new_respondent = true;
	else
		update respondent_results rr
		set rr.index_value = (rr.index_value * rr.sessions + index_value) / (rr.sessions + 1),
		rr.session_length = (rr.session_length * rr.sessions + session_length) / (rr.sessions + 1),
		rr.sessions = rr.sessions + 1,
		last_updated = now()
		where rr.project_key = project_key
		and rr.response_id = response_id
		and rr.exercise = exercise
		and rr.source_label = source_label
		and rr.up_bucket = up_bucket
		and rr.down_bucket = down_bucket;
		set new_respondent = false;
	end if;

/* If the index value for this PROJECT'S [prime|target]/bucket combination already exists, update the row.  Else, insert it. */	
	if not exists (select 1 from project_results pr where pr.project_key = project_key and pr.exercise = exercise and pr.source_label = source_label and pr.up_bucket = up_bucket and pr.down_bucket = down_bucket) THEN 
		insert into project_results 
			(project_key, exercise, source_label, up_bucket, down_bucket, task_type, index_value, last_updated)
		values 
			(project_key, exercise, source_label, up_bucket, down_bucket, task_type, index_value, now());
	else 
		/* ONLY UPDATE THE PROJECT LEVEL RESULTS IF NOT A TRIAL PROJECT WITH MORE THAN 20 RESPONDENTS */
		update project_results pr
		set pr.index_value = (pr.index_value * pr.respondents + index_value) / (pr.respondents + 1),
		pr.respondents = pr.respondents + if(new_respondent, 1, 0),
		last_updated = now()
		where pr.project_key = project_key
		and pr.exercise = exercise
		and pr.source_label = source_label
		and pr.up_bucket = up_bucket
		and pr.down_bucket = down_bucket;
	end if;

/* Delete these Pending task-level results after having written the respondent-level and project-level results */
	delete from results_pending_estimation 
	where results_pending_estimation.session_id = session_id 
	and results_pending_estimation.exercise = exercise 
	and (
		(results_pending_estimation.target_type in ('ca') and results_pending_estimation.task_name = source_label)
		or (results_pending_estimation.target_type in ('sa', 'affpr') and results_pending_estimation.prime_name = source_label)
	);

/* update flat table clients_complete_sessions */

select client_id into c_client_id from projects where projects.project_key = project_key;

	if exists (select 1 from clients_complete_sessions cc where cc.project_key = project_key) THEN /* if project exist  and old project having some data in*/
		

		/*insert into clients_complete_sessions 
			(client_id, project_key,session_id,last_updated_on)
		values 
			(c_client_id,project_key,session_id,now());*/
	     IF not exists (select 1 from clients_complete_sessions cc where cc.project_key = project_key and cc.session_id = session_id)	 then	/* if it a first call from rscript*/
				update clients_complete_sessions cc
				set cc.total_completes = (cc.total_completes + 1),
				cc.last_updated_on = now(),
				cc.session_id = session_id
				where cc.project_key = project_key;
				
	  

		end if;
else
insert into clients_complete_sessions /* if its a new project */
			(client_id, project_key,session_id,last_updated_on)
		values 
			(c_client_id,project_key,session_id,now());
	end if;


/* End */


END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveSignupRequest
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveSignupRequest` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveSignupRequest`(IN `email` varchar(100),IN campaign_code VARCHAR(50),IN company_name VARCHAR(255))
Toplevel : BEGIN

IF not EXISTS(select 1 from  campaigns where  campaigns.code = campaign_code) THEN
begin
select '' as signup_key , 'Invalid campaign code'  as confirmation_url ;
leave Toplevel;
end;
end if;


IF EXISTS(select 1 from  signup_requests where  signup_requests.email = email and signup_requests.campaign_code = campaign_code) THEN
begin
select '' as signup_key , 'Already registered for this campaign' as confirmation_url ;
leave Toplevel;
end;
end if;

	insert into signup_requests (email, signup_key, status,campaign_code,company_name)
	values (email, MD5(UUID()),'pending',campaign_code,company_name);

	select signup_key from signup_requests sr where sr.email = email and sr.campaign_code = campaign_code;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveSurveyLinkTemplates
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveSurveyLinkTemplates` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveSurveyLinkTemplates`(IN option_name VARCHAR(255),IN template LONGTEXT)
BEGIN
insert into survey_link_templates(option_name,template)
values (option_name,template)
ON duplicate KEY
UPDATE 
survey_link_templates.option_name = option_name,
survey_link_templates.template = template;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveTask
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveTask` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveTask`(IN `project_key` varchar(50), IN `exercise` int, IN `source` varchar(255) charset utf8, IN `name` varchar(50)  charset utf8, IN label VARCHAR(50) CHARSET UTF8 ,IN `idx` smallint, IN `bucket` varchar(10), IN `target_type` varchar(5),IN focus BIT,IN raw_source VARCHAR(255))
BEGIN
declare newid int;
		insert into tasks
			(client_id, project_key, target_type, name,label, exercise, bucket, idx, source,raw_source,focus)
		select p.client_id, p.project_key, target_type, name,label, exercise, bucket, idx, source,raw_source,focus
			from projects p
			where p.project_key = project_key
		/*on duplicate key update
			name = name, bucket = bucket, source = source, idx = idx, target_type = target_type*/;
set newid = (select last_insert_id());
if focus = true then
begin
SET SQL_SAFE_UPDATES = 0;
update tasks

 set tasks.focus = 0 where  tasks.project_key = project_key and tasks.exercise = exercise and id != newid;
SET SQL_SAFE_UPDATES = 1;
end;
end if;


select  id from tasks where id = newid;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveTaskData
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveTaskData` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveTaskData`(IN `id` INT, IN `name` varchar(50),IN label VARCHAR(50),  IN `idx` smallint,IN focus BIT)
BEGIN
 
declare projectkey varchar(100);
declare exercise_num int;

if label = '' or label is null then
select tasks.label into label from tasks where tasks.id = id;
end if;
SET SQL_SAFE_UPDATES = 0;
	update tasks 
	set name = name,label= label, idx = idx,focus = focus
	where tasks.id = id;

IF focus = TRUE then
begin
select project_key,exercise into projectkey,exercise_num from tasks where tasks.id = id;
 update tasks
 set tasks.focus = 0 where  tasks.project_key= projectkey and  tasks.exercise = exercise_num and tasks.id != id;
end;
end if;
SET SQL_SAFE_UPDATES = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveUsedTimestamp
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveUsedTimestamp` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveUsedTimestamp`(IN sess_id VARCHAR(64), proj_id VARCHAR(128), resp_id VARCHAR(128))
BEGIN  
set sql_safe_updates = 0;
UPDATE session_requests 
SET 
	used_timestamp = now()  
WHERE 
	session_id = sess_id AND project_id = proj_id AND response_id = resp_id;
set sql_safe_updates = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveUser
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveUser` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveUser`(IN `client_key` varchar(100), IN `login` VARCHAR(100), IN `password` BLOB, IN `type` varchar(10), IN `status` varchar(10),IN api_key VARCHAR(100))
Toplevel : BEGIN
/* check for type admin */
IF not EXISTS(select 1 from  users where  users.type = 'admin' and users.api_key = api_key and users.status ='active') THEN
		BEGIN
			SELECT 0 AS id,'Unauthorized Access ' AS status;
			leave Toplevel;
		END;
	END IF;

IF  EXISTS(select 1 from  users where  users.login = login and users.password = password) THEN
		BEGIN
			SELECT 0 AS id,'The combination of Email-id and password exists. Please try another.' AS status;
			leave Toplevel;
		END;
	END IF;


	INSERT INTO users
		(client_id, login, password, api_key, type, status)
	values 
		( (select id from clients where clients.client_key = client_key)
, login, password, MD5(concat(UUID(), login)), type, status)
	ON DUPLICATE KEY UPDATE 
	users.password = password, users.type = type, users.status = status, deleted = deleted;
select 
	 u.id
	,u.login
	,u.api_key
	,u.type
	,u.status
	,c.company
	,c.client_key 
		from users u
	left join	
     		 clients c
   on u.client_id = c.id
where 
  u.client_id = c.id and u.login = login limit 1;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveVideoThumbnailRequests
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveVideoThumbnailRequests` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveVideoThumbnailRequests`(IN project_key VARCHAR(100),IN video_index INT,IN video_url TINYTEXT,IN video_name VARCHAR(100))
BEGIN
INSERT INTO video_thumbnail_requests (project_key,video_index,video_url,video_name)
values (project_key,video_index,video_url,video_name);
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveVideoThumbnailRequestsCompleted
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveVideoThumbnailRequestsCompleted` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveVideoThumbnailRequestsCompleted`(IN id INT,IN project_key VARCHAR(100))
BEGIN
UPDATE video_thumbnail_requests 
	SET 
		is_completed = 1,
		completed_date = now()
	WHERE 
		video_thumbnail_requests.id = id AND video_thumbnail_requests.project_key = project_key;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spSaveVideoThumbnails
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spSaveVideoThumbnails` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spSaveVideoThumbnails`(IN project_key VARCHAR(100),IN video_index INT,IN thumbnail_url TINYTEXT,IN height INT,IN width INT,IN slide_resize BIT)
BEGIN
INSERT INTO video_thumbnails (project_key,video_index,thumbnail_url,height,width,slide_resize)
VALUES (project_key,video_index,thumbnail_url,height,width,slide_resize);
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spUpdatePrimeAudio
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spUpdatePrimeAudio` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spUpdatePrimeAudio`(IN `project_key` VARCHAR(100), IN `exercise` INT, IN `audio_source` varchar(255), IN `PrimeIDs` varchar(100))
BEGIN
/*	set @sql = concat("update primes set primes.audio_source='",audio_source,"' WHERE primes.project_key='",project_key,"' and primes.exercise='",exercise,"' and primes.id in (",PrimeIDs,")");
    PREPARE q FROM @sql;
    execute q;*/
set sql_safe_updates = 0; 
update primes set primes.audio_source = audio_source where primes.project_key = project_key and primes.exercise = exercise and FIND_IN_SET(primes.id,  PrimeIDs);
set sql_safe_updates = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spUpdateUserDetails
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spUpdateUserDetails` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spUpdateUserDetails`(IN first_name VARCHAR(50),IN last_name VARCHAR(50),IN title VARCHAR(50),IN company VARCHAR(50),IN api_key VARCHAR(100),IN client_id INT)
BEGIN
SET SQL_SAFE_UPDATES = 0;
UPDATE users
	set
		users.first_name = first_name,
		users.last_name = last_name,
		users.title = title
	where 
		users.api_key = api_key;
IF ROW_COUNT() > 0 THEN
UPDATE clients
	set
		clients.company = company
	where clients.id = client_id;
END IF;
SET SQL_SAFE_UPDATES = 1;
select * from (
	select users.*,c.company from users 
left join clients c on c.id = users.client_id
where users.api_key = api_key and lower(users.type) != 'trial'  AND users.type != 'NonTrialusers'
	
) as userd 

inner join
(select sum(Coalesce(purchase_completes.no_completes,0)) as no_completes,sum(Coalesce(purchase_completes.total_studies,0)) as total_studies from purchase_completes where purchase_completes.api_key in (select users.api_key from users where users.client_id = client_id)
) as completes

inner join
(
/*
select sum(rr.sessions) as comp_session
from clients c
inner join projects p 
on c.id = p.client_id
inner join respondent_results rr 
on p.project_key = rr.project_key and rr.sessions IS NOT NULL AND rr.sessions <> 0
where c.id=client_id) as cp;
*/
select sum(total_completes) as comp_session from clients_complete_sessions where clients_complete_sessions.client_id = client_id) as cp;





/* old code
left join
(select sum(Coalesce(purchase_completes.no_completes,0)) as no_completes,sum(Coalesce(purchase_completes.total_studies,0)) as total_studies,
api_key as ukey from purchase_completes group by purchase_completes.api_key having purchase_completes.api_key= api_key) completes
on completes.ukey = userd.api_key
inner join
(
/*
select sum(rr.sessions) as comp_session
from clients c
inner join projects p 
on c.id = p.client_id
inner join respondent_results rr 
on p.project_key = rr.project_key and rr.sessions IS NOT NULL AND rr.sessions <> 0
where c.id=client_id) as cp;

select sum(total_completes) as comp_session from clients_complete_sessions where clients_complete_sessions.client_id = client_id) as cp;
*/
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spUpdateUserToSaasUser
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spUpdateUserToSaasUser` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spUpdateUserToSaasUser`(IN api_key VARCHAR(100))
BEGIN
SET SQL_SAFE_UPDATES = 0;
UPDATE users
	set
		users.type = 'saasuser'
	where 
		users.api_key = api_key and users.type = 'saastrial';
SET SQL_SAFE_UPDATES = 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spValidatePasswordRequest
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spValidatePasswordRequest` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spValidatePasswordRequest`(IN `apiKey` varchar(100))
BEGIN
	SELECT *,first_name FROM  password_requests
inner join users
on users.login = password_requests.login
		WHERE password_requests.request_key = apiKey AND created_date >= DATE_SUB(NOW(), INTERVAL 1 DAY);

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE spValidateUser
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `spValidateUser` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `spValidateUser`(IN `login` varchar(100))
BEGIN
IF not EXISTS(select * from users u where u.login = login and lower(u.type) != 'trial'  and status = 'active') THEN
		BEGIN
	Select 
	 u.id
	,u.login
	,u.api_key
	,u.type
	,u.status
	,c.company
	,c.client_key 
	,u.client_id
		from users u
	left join	
     		 clients c
   on u.client_id = c.id where u.login = login and  lower(u.type) = 'trial' and status = 'active';
		END;
else
begin
select 
	 u.id
	,u.login
	,u.api_key
	,u.type
	,u.status
	,c.company
	,c.client_key 
	,u.client_id
		from users u
	left join	
     		 clients c
   on u.client_id = c.id
 where u.login = login and lower(u.type) != 'trial'  and status = 'active';
end;
	END IF;

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE sp_mpSaveUserResults
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `sp_mpSaveUserResults` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 PROCEDURE `sp_mpSaveUserResults`(IN Archetype INT,IN Archetype_value VARCHAR(255),IN willingness DECIMAL(8,2), IN knowledge INT,IN response_id VARCHAR(128),OUT percentage DECIMAL)
BEGIN
declare same_archetype_count  int;
declare total_count  int;
DECLARE old_same_archetype_count INT;
DECLARE total_old_records INT;
INSERT INTO mp_user_results
(
`Archetype`,
`Archetype_value`,
`willingness`,
`knowledge`,
`response_id`)
VALUES
(Archetype,
Archetype_value,
willingness,
knowledge,
response_id
);
IF LAST_INSERT_ID() <> 0 THEN
BEGIN
SET total_old_records = 7237; /* total old records */
SET old_same_archetype_count = fnGetArcheTypeOldUserCount(Archetype); /* total old records for this archeType */
SET total_count = (select count(*) from mp_user_results); /* total records in this table */
SET same_archetype_count = (select count(mp_user_results.Archetype)  from mp_user_results where mp_user_results.Archetype = Archetype); /* total records in this table for this archeType */
SET percentage = FORMAT(((old_same_archetype_count + same_archetype_count) * 100 ) / (total_old_records + total_count),0);
END;
END IF;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
DELIMITER ;

--
-- Dumping routines (FUNCTION) for database 'api-prime'
--
DELIMITER ;;

# Dump of FUNCTION calculateVelocity
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `calculateVelocity` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 FUNCTION `calculateVelocity`(`x` MEDIUMTEXT) RETURNS decimal(19,16)
    NO SQL
BEGIN
RETURN Glength(
		linestring(
			point(0,0),
			point(
				substring_index(trimIntensity(x), ',', 1),
				substring_index(substring_index(trimIntensity(x), ',', -2), ',', 1)
				)
			)
		) / substring_index(trimIntensity(x), ',', -1);
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of FUNCTION fnAlphaNumeric
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `fnAlphaNumeric` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 FUNCTION `fnAlphaNumeric`(`x` varchar(50)) RETURNS varchar(50) CHARSET utf8
BEGIN
	set @x = x;
	set @x = replace(@x, '_', '');
	set @x = replace(@x, ',', '');
	set @x = replace(@x, '\'', '');
	set @x = replace(@x, '"', '');
	return @x;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of FUNCTION fnCheckWhitelist_ip
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `fnCheckWhitelist_ip` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 FUNCTION `fnCheckWhitelist_ip`(ipaddress varchar(100)) RETURNS bit(1)
BEGIN
declare retvalue bit;
IF EXISTS(select 1 from  whitelist_ip where  whitelist_ip.ipaddress = ipaddress) THEN
	BEGIN
	 set retvalue = true;
	END;
	else
	BEGIN
		set retvalue = false;
	END;
END IF;
return retvalue;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of FUNCTION fnGetArcheTypeOldUserCount
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `fnGetArcheTypeOldUserCount` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`digital-avenues`@`%`*/ /*!50003 FUNCTION `fnGetArcheTypeOldUserCount`(Archetype INT) RETURNS int(11)
BEGIN
declare retvalue INT;

 CASE Archetype
      WHEN 1 THEN set retvalue = 2277;
      WHEN 2 THEN set retvalue = 1496;
	  WHEN 3 THEN set retvalue = 353;
      WHEN 4 THEN set retvalue = 587;
	  WHEN 5 THEN set retvalue = 1317;
      WHEN 6 THEN set retvalue = 1207;
      
    END CASE;
return retvalue;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of FUNCTION fnToEDT
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `fnToEDT` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 FUNCTION `fnToEDT`(`x` TIMESTAMP) RETURNS datetime
BEGIN
	set @x := @x - interval 4 hour;
	RETURN @x;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of FUNCTION trimIntensity
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `trimIntensity` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`dba`@`%`*/ /*!50003 FUNCTION `trimIntensity`(`x` MEDIUMTEXT) RETURNS varchar(255) CHARSET utf8
RETURN substring_index(replace(trim(LEADING '[' from trim(TRAILING ']' from x)), '],[', '|'), '|', -1) */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
