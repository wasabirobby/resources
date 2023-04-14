-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mer. 30 nov. 2022 à 13:04
-- Version du serveur : 10.5.15-MariaDB-0+deb11u1
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `SA`
--

-- --------------------------------------------------------

--
-- Structure de la table `global_blips`
--

CREATE TABLE `global_blips` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT 'blip',
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `streetName` varchar(50) NOT NULL DEFAULT '0',
  `sprite` smallint(6) NOT NULL DEFAULT 0,
  `scale` float NOT NULL DEFAULT 0,
  `alpha` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `color` smallint(6) NOT NULL DEFAULT 0,
  `ticked` bit(1) NOT NULL DEFAULT b'0',
  `outline` bit(1) NOT NULL DEFAULT b'0',
  `display` tinyint(3) NOT NULL DEFAULT 0,
  `identifier` varchar(80) DEFAULT NULL,
  `type` varchar(10) NOT NULL,
  `height` float NOT NULL DEFAULT 50,
  `width` float NOT NULL DEFAULT 50
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `global_blips`
--

INSERT INTO `global_blips` (`id`, `name`, `x`, `y`, `z`, `streetName`, `sprite`, `scale`, `alpha`, `color`, `ticked`, `outline`, `display`, `identifier`, `type`, `height`, `width`) VALUES
(1, 'Diamond Casino', 2155.42, 2155.2, 9.6626, '', 89, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(2, 'Gouv', 2615.66, 1208.6, 9.82031, '', 419, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(3, 'Station essence', 2149.95, 2743.54, 15.1465, '', 361, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(4, 'Rockford', 983.955, 2409.73, 11.941, '', 590, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(5, 'Station essence', 953.417, 2359, 9.81226, '', 361, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(6, 'Redline Tuners', 925.302, 2221.66, 25.68, '', 289, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(7, 'Weazel News', 1090.8, 1786.98, 9.81396, '', 590, 1, 255, 1, b'0', b'0', 2, NULL, 'coords', 50, 50),
(8, 'The Four Dragons', 2029.45, 1008.12, 9.82043, '', 89, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(9, 'Chick Fil A', 2495.14, 1286.52, 15.8845, '', 59, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(10, 'Vanilla Unicorn', 1071.24, 2306.59, 15.5599, '', 93, 1, 255, 8, b'0', b'0', 2, NULL, 'coords', 50, 50),
(11, 'Maisonette 10', 2803.13, 2259.22, 10.7663, '', 93, 1, 255, 7, b'0', b'0', 2, NULL, 'coords', 50, 50),
(12, 'LVPD', 2828.25, 894.293, 25.153, '', 60, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(13, 'Eglise', 2490.09, 920.393, 10.0249, '', 176, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(14, 'Ammunation', 2177.95, 965.878, 9.82019, '', 110, 1, 255, 1, b'0', b'0', 2, NULL, 'coords', 50, 50),
(15, 'Caligula Casino', 2179.36, 1677.66, 19.3942, '', 89, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(16, 'Hotel', 1723.33, -1634.9, 19.219, '', 476, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(17, 'Hopital', 2031.46, -1406.17, 22.1172, '', 61, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(18, 'Garage', -2032.8, 162.289, 32.9358, '', 446, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(19, 'Pay N Spray', -1901.8, 284.816, 48.2567, '', 72, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(21, 'Pacific Bank', -1899.45, 1160.94, 44.4546, '', 108, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(22, 'Otto\'s Auto', -1640.94, 1204.91, 6.24255, '', 225, 1, 255, 1, b'0', b'0', 2, NULL, 'coords', 50, 50),
(23, 'UWU Cafe', -1529.78, 1012.28, 15.9667, '', 52, 1, 255, 8, b'0', b'0', 2, NULL, 'coords', 50, 50),
(24, 'San Fierro Medical Center', -2658.02, 645.066, 65.0927, '', 61, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(25, 'CityHall', -2776.79, 378.097, 28.4926, '', 419, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(27, 'Sushi', -2163.66, 130.217, 54.0925, '', 59, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(28, 'Station essence', -1683.64, 419.497, 11.4429, '', 361, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(29, 'Pearls Restaurant', 372.277, -2065.21, 16.999, '', 411, 1, 255, 26, b'0', b'0', 2, NULL, 'coords', 50, 50),
(30, 'McDonald\'s', -73.1292, -1577.88, 9.8251, '', 78, 1, 255, 5, b'0', b'0', 2, NULL, 'coords', 50, 50),
(31, 'Cafe Amazon', 387.913, -1929.5, 6.84045, '', 59, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(32, '7Eleven', 388.167, -1899.7, 14.3055, '', 508, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(33, 'Beach Club', 829.133, -2243.87, 19.8807, '', 93, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(34, 'Alhambra', 1839.55, -1681.16, 28.1201, '', 93, 1, 255, 8, b'0', b'0', 2, NULL, 'coords', 50, 50),
(35, 'Benny\'s', 1875.26, -1766.56, 24.3577, '', 446, 1, 255, 23, b'0', b'0', 2, NULL, 'coords', 50, 50),
(36, 'Beach Gym', 657.103, -1873.53, 4.46143, '', 311, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(37, 'Station essence', 1939.06, -1770.95, 17.9495, '', 361, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(38, 'Liberty Walk', 2046.21, -1827.09, 20.183, '', 446, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(39, 'Verona Mall', 1123.25, -1439.53, 14.7609, '', 475, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(40, 'Dunkin', 1036.08, -1347.57, 17.0748, '', 59, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(42, 'Ammunation', 1374.25, -1280.05, 32.5391, '', 110, 1, 255, 1, b'0', b'0', 2, NULL, 'coords', 50, 50),
(43, 'Tribunal', 1479.95, -1774.83, 15.6708, '', 79, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(44, 'LSPD', 1555, -1675.24, 27.401, '', 60, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(45, 'VespucciPD', 1700.07, -1787.69, 12.6036, '', 60, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(46, 'Restaurant', 1497.94, -1587.77, 12.3818, '', 59, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(47, 'Poppeye', 1400.51, -1685.54, 19.863, '', 267, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(48, '247', 1113.88, -924.712, 56.886, '', 59, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(49, 'Station essence', 993.847, -929.599, 46.5998, '', 361, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(50, 'School', 683.434, -1267.81, 12.5626, '', 120, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(52, 'Public Toilet', 534.867, -1816.33, 5.58289, '', 1, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(53, 'Bahama Mamas', 1314.26, -1164.45, 35.6311, '', 93, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(54, 'Shopping Center', -1049.62, -998.38, 152.696, '', 59, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(55, 'Pillbox', 1658.6, -1399.19, 12.5681, '', 61, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(56, 'Apple Store', 1764.84, -1342.19, 18.6331, '', 76, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(57, 'Appartment', 1565.94, -1342.04, 233.071, '', 475, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(58, 'Fire Station', 1752.15, -1468.78, 12.599, '', 436, 1, 255, 1, b'0', b'0', 2, NULL, 'coords', 50, 50),
(59, 'The Pig Pen', 2422.32, -1221.28, 28.5026, '', 93, 1, 255, 8, b'0', b'0', 2, NULL, 'coords', 50, 50),
(60, 'White Widow', 1671.27, 1850.61, 24.302, '', 140, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(61, 'Bank', 2198.65, 1475.54, 15.3278, '', 108, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(62, 'Airport', 1686.85, -2215.73, 27.6544, '', 90, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(63, 'Airport', 1684.28, -2241.96, 19.9771, '', 90, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(64, 'Wang Car', -1972.96, 295.17, 34.173, '', 227, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(65, 'Pay N Spray', -2426.2, 1026.8, 57.2646, '', 72, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(67, 'Victim', 466.046, -1501.13, 41.5781, '', 73, 1, 255, 1, b'0', b'0', 3, NULL, 'coords', 50, 50),
(68, 'Pharma', 1108.6, -1276.54, 12.4115, '', 61, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(69, 'Bank', 2310.73, -11.3692, 31.5305, '', 108, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(70, 'Library', 1465.03, -1012.27, 60.1874, '', 77, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(71, 'Crypto Arena', 2711.82, -1697.26, 35.6816, '', 518, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(72, 'Fuel', 80.2169, -242.982, 45.3729, '', 361, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(73, 'Liquor Store', 253.703, -57.5952, 4.88342, '', 52, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(74, 'Bank', 1284.11, -1327.78, 12.5538, '', 108, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(75, 'Hood Building', 1299.13, -1275.75, 12.5522, '', 475, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(76, 'Chalet', 414.428, -982.559, 98.1194, '', 414, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(77, 'Villa', 2989.81, -1334.68, 20, '', 414, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(78, 'Red Roses Holland', 2264.67, -2048.89, 12.5505, '', 226, 1, 255, 1, b'0', b'0', 2, NULL, 'coords', 50, 50),
(79, 'Cookies', -239.875, 2605.31, 69.1902, '', 140, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(80, 'Gym', 2224.12, -1727.22, 20, '', 311, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(81, 'Lake House', 2142.84, -95.0327, 1.79126, '', 411, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(82, 'Auto Repairs', 87.8794, 1074.47, 16.9603, '', 446, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(83, 'Limeys', 1832.32, -1397.88, 12.6682, '', 93, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(84, 'SandyPD', 622.37, -570.5, 25.1282, '', 60, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(85, 'Motel', 2216.51, -1172.46, 24.7194, '', 375, 1, 255, 9, b'0', b'0', 2, NULL, 'coords', 50, 50),
(86, 'Barber', 2263.5, -1674.14, 20, '', 71, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(87, 'BurgerShot', 1195.82, -915.092, 42.4615, '', 106, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(88, 'Luxury Auto', 929.51, -1531.68, 33.1693, '', 225, 1, 255, 5, b'0', b'0', 2, NULL, 'coords', 50, 50),
(89, 'BurgerShot', 796.808, -1618.38, 18.5338, '', 106, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(90, 'BurgerShot', -2337.81, -151.9, 39.5856, '', 106, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(91, 'BurgerShot', -2341.08, 1006.97, 54.9194, '', 106, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(92, 'Maison', 2186.54, -1448.57, 0, '', 414, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(93, 'Maison', 2186.62, -1478.13, 0, '', 414, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(94, 'Maison', 2156.17, -1439.5, 0, '', 414, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(95, 'Maison', 2155.1, -1410.66, 0, '', 414, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(96, 'Maison', 2129.99, -1324.79, 0, '', 414, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(97, 'Maison', 2206.77, -1242, 0, '', 414, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(98, 'Boat Dealer', 280.49, -1785.78, 31.8568, '', 404, 1, 255, 1, b'0', b'0', 2, NULL, 'coords', 50, 50),
(99, 'Leopolds', 555.822, -1508.09, 13.5494, '', 73, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(100, 'Maison', 2492.81, -1695.21, 22.0968, '', 414, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(101, 'Integrity', 1423.05, -1189.3, 194.037, '', 407, 0.84, 255, 5, b'0', b'0', 2, NULL, 'coords', 50, 50),
(103, 'Villa Staff', -1954.22, 669.071, 151.832, '', 1, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50),
(104, 'BurgerShot', 2164.41, 2800.14, 11.1793, '', 106, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(106, 'Fuel', 2631.35, 1104.56, 9.8147, '', 361, 1, 255, 1, b'0', b'0', 2, NULL, 'coords', 50, 50),
(107, 'BurgerShot', 2469.24, 2013.35, 10.1157, '', 106, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(108, 'Heroes Motors', 2214.89, 1394.17, 9.8175, '', 348, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(109, 'Subway', 2184.65, 1395.41, 15.6391, '', 120, 1, 255, 2, b'0', b'0', 2, NULL, 'coords', 50, 50),
(111, 'Icebox', 2620.31, -1380.18, 1, '', 617, 1, 255, 3, b'0', b'0', 2, NULL, 'coords', 50, 50),
(112, 'Garage', 1842.09, -1855.39, 1, '', 1, 1, 255, 66, b'0', b'0', 2, NULL, 'coords', 50, 50);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `global_blips`
--
ALTER TABLE `global_blips`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `global_blips`
--
ALTER TABLE `global_blips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
