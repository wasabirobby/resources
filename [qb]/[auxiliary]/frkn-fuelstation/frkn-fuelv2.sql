CREATE TABLE IF NOT EXISTS `frkn_fuel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `fuel_name` varchar(50) NOT NULL,
  `coordinat` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tanker` int(50) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `gas_station_revenue` int(11) DEFAULT NULL,
  `tanker_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4;


DELETE FROM `frkn_fuel`;

INSERT INTO `frkn_fuel` (`id`, `owner`, `fuel_name`, `coordinat`, `price`, `tanker`, `level`, `gas_station_revenue`, `tanker_limit`) VALUES
	(1, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 9605, 4000),
	(2, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 3000, 2000),
	(3, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(4, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(5, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(6, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(7, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(8, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(9, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(10, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(11, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(12, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(13, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(14, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(15, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(16, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(17, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(18, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(19, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(20, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(21, 'This place has no owner', 'Gas Station\r\n', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(22, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(23, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(24, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(25, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(26, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000),
	(27, 'This place has no owner', 'Gas Station', '{x = 643.69,   y = 268.32,  z = 103.14}', 39150, 2000, 1, 15000, 6000);



CREATE TABLE IF NOT EXISTS `frkn_fuel_employe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '0',
  `station_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4;


DELETE FROM `frkn_fuel_employe`;

INSERT INTO `frkn_fuel_employe` (`id`, `citizenid`, `name`, `station_id`) VALUES
	(65, 'WBH06910', 'FURKAN', 9);



CREATE TABLE IF NOT EXISTS `frkn_fuel_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fuel` varchar(50) NOT NULL DEFAULT '0',
  `player_name` varchar(50) NOT NULL DEFAULT '0',
  `vehicle` varchar(50) NOT NULL DEFAULT '0',
  `plate` varchar(50) NOT NULL DEFAULT '0',
  `price` varchar(50) NOT NULL DEFAULT '0',
  `station` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=573 DEFAULT CHARSET=utf8mb4;


DELETE FROM `frkn_fuel_history`;

INSERT INTO `frkn_fuel_history` (`id`, `fuel`, `player_name`, `vehicle`, `plate`, `price`, `station`) VALUES
	(549, '35', 'FURKAN', 'T20', '68AAR583', '525', '9'),
	(550, '0', 'FURKAN', 'T20', '68AAR583', '0', '9'),
	(551, '0', 'FURKAN', 'T20', '68AAR583', '0', '9'),
	(552, '35', 'FURKAN', 'T20', '01XFH289', '525', '9'),
	(553, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(554, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(555, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(556, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(557, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(558, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(559, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(560, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(561, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(562, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(563, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(564, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(565, '50', 'FURKAN', 'T20', '01XFH289', '750', '9'),
	(566, '50', 'FURKAN', 'T20', '01XFH289', '750', '8'),
	(567, '50', 'FURKAN', 'T20', '01XFH289', '750', '8'),
	(568, '50', 'FURKAN', 'T20', '01XFH289', '750', '8'),
	(569, '50', 'FURKAN', 'T20', '01XFH289', '750', '8'),
	(570, '50', 'FURKAN', 'T20', '84CJW275', '750', '9'),
	(571, '50', 'FURKAN', 'T20', '84CJW275', '750', '9'),
	(572, '50', 'FURKAN', 'T20', '84CJW275', '750', '9');

ALTER TABLE users
ADD frkn_fuelstation_control INT(11) NOT NULL DEFAULT 0;








