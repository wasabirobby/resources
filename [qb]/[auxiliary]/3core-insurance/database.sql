CREATE TABLE `3core_insurance` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` LONGTEXT NOT NULL COLLATE 'utf8_general_ci',
	`type` LONGTEXT NOT NULL COLLATE 'utf8_general_ci',
	`upgrades` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`nextpayment` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=0
;