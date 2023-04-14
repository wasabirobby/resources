CREATE TABLE `3core_investments` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`type` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`index` INT(11) NOT NULL DEFAULT '0',
	`time` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=0
;