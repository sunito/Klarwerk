CREATE TABLE `diagramme` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `beschreibung` text,
  `zeit_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `diaquen` (
  `id` int(11) NOT NULL auto_increment,
  `quelle_id` int(11) default NULL,
  `diagramm_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `einheiten` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `beschreibung` text,
  `min` float default NULL,
  `max` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `messpunkte` (
  `id` int(11) NOT NULL auto_increment,
  `zeit` datetime default NULL,
  `wert` varchar(255) default NULL,
  `quelle_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `quellen` (
  `id` int(11) NOT NULL auto_increment,
  `adresse` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `typ` varchar(255) default NULL,
  `beschreibung` text,
  `einheit_id` int(11) default NULL,
  `status` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `zeiten` (
  `id` int(11) NOT NULL auto_increment,
  `bis` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `dauer` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20081014081525');

INSERT INTO schema_migrations (version) VALUES ('20081014093131');

INSERT INTO schema_migrations (version) VALUES ('20081015055814');

INSERT INTO schema_migrations (version) VALUES ('20081015095207');

INSERT INTO schema_migrations (version) VALUES ('20081015102104');

INSERT INTO schema_migrations (version) VALUES ('20081029065621');

INSERT INTO schema_migrations (version) VALUES ('20081126091212');