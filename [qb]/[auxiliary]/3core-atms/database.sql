CREATE TABLE `3core_atms` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`owner` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`location` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`balance` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=0
;