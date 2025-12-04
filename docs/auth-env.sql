-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Hôte : ---.hosting-data.io
-- Généré le : mer. 03 déc. 2025 à 17:18
-- Version du serveur : 10.11.14-MariaDB-deb11-log
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `auth_env`
--
CREATE DATABASE IF NOT EXISTS `auth_env` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `auth_env`;

-- --------------------------------------------------------

--
-- Structure de la table `app_settings`
--

DROP TABLE IF EXISTS `app_settings`;
CREATE TABLE `app_settings` (
  `skey` varchar(100) NOT NULL,
  `svalue` text DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(64) NOT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(400) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `meta`, `ip`, `user_agent`, `created_at`) VALUES
(2, 1, 'admin.valid.update', '{\"valid_until\":\"2025-09-23 21:40:00\"}', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-18 21:40:36');

-- --------------------------------------------------------

--
-- Structure de la table `env_tokens`
--

DROP TABLE IF EXISTS `env_tokens`;
CREATE TABLE `env_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `scope` enum('DEV','HOMOL','DEV_HOMOL') NOT NULL DEFAULT 'DEV_HOMOL',
  `token` varchar(128) NOT NULL,
  `issued_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `revoked_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `env_tokens`
--

INSERT INTO `env_tokens` (`id`, `user_id`, `scope`, `token`, `issued_at`, `expires_at`, `revoked_at`) VALUES
(1, 1, 'DEV', '5945ffd0404880867d13c096bb7e8c36831385916117d091', '2025-09-15 11:53:36', '2025-09-15 19:53:36', NULL),
(2, 1, 'DEV', '880ed348f762c7d6d12c99e1a7c4dd10eb68dc005af93217', '2025-09-15 11:53:52', '2025-09-15 19:53:52', NULL),
(3, 1, 'DEV', '07f6ef837320e9e00116a998900a00f7582cceeb0dc4ed32', '2025-09-15 13:28:15', '2025-09-15 21:28:15', NULL),
(4, 1, 'DEV', 'b6eb525dbf6adec9c3b301efa2946b69ec22aac5b793d2de', '2025-09-15 13:28:27', '2025-09-15 21:28:27', NULL),
(5, 1, 'DEV', 'b0450f99678d8d829e41db5ee4adbc804f5ac0788983f310', '2025-09-15 13:28:30', '2025-09-15 21:28:30', NULL),
(6, 1, 'DEV', '939364cf9dc88c78032ac2e73971fd950822bdcb38aef3d4', '2025-09-15 16:00:21', '2025-09-16 00:00:21', NULL),
(7, 1, 'DEV', 'd0cd7166668de1510e413e44e6ebc030c4c82ac307d51d01', '2025-09-15 18:00:28', '2025-09-16 02:00:28', NULL),
(8, 1, 'DEV', '755614c3f6d52425aa3eadda2f9a3b2e56ffac8813887cd2', '2025-09-15 18:40:30', '2025-09-16 02:40:30', NULL),
(9, 1, 'DEV', '01ee663414ca5a2d4b44f7d2fe3fe68f10ca8fa88fdc88c2', '2025-09-15 20:38:38', '2025-09-16 04:38:38', NULL),
(10, 1, 'DEV', 'c408bf985e07774ac1e4e2524b22b10b85ae3fb2e638ebb8', '2025-09-15 20:43:30', '2025-09-16 04:43:30', NULL),
(11, 1, 'DEV', '84346769df5dffccc4d0b7d2b1fd9bfa05e8c2d51ffd65fe', '2025-09-15 20:43:32', '2025-09-16 04:43:32', NULL),
(12, 1, 'DEV', 'f16ed1de36cbc26321e8db6329441124f6270a814def9207', '2025-09-15 21:55:47', '2025-09-16 05:55:47', NULL),
(13, 1, 'DEV', '0241f7b9c48694ba255fac5f612d9f72a508b96faa3b8b97', '2025-09-15 22:15:32', '2025-09-16 06:15:32', NULL),
(14, 1, 'DEV', '11aa4957662b0cd44e72a1d8274c326d0774df306ba232bb', '2025-09-15 22:22:56', '2025-09-16 06:22:56', NULL),
(15, 1, 'DEV', 'ca0dc43fade805c66d72f1b31b4a81dde734b0e8b926a6b3', '2025-09-15 22:32:42', '2025-09-16 06:32:42', NULL),
(16, 1, 'DEV', '704a0e0c6f15886f0d292e5b6ed94562fa12bb7688dce00e', '2025-09-15 23:00:13', '2025-09-16 07:00:13', NULL),
(17, 1, 'DEV', 'fd5f0a2b140033ede37f2fe0c6d8556e16ba43eabd9c0d27', '2025-09-15 23:24:09', '2025-09-16 07:24:09', NULL),
(18, 1, 'DEV', 'a7a39aa515e2369cacccfe1fa2b26f94e82edc1b4941d33c', '2025-09-15 23:24:11', '2025-09-16 07:24:11', NULL),
(19, 1, 'DEV', '206ea25923d524bd1c67b1b5baeff5ec4d0c74206ce24226', '2025-09-15 23:48:50', '2025-09-16 07:48:50', NULL),
(20, 1, 'DEV', '7e79fbf958303574cfbb07ec2eeba71800dead2f21e68e9c', '2025-09-16 00:04:45', '2025-09-16 08:04:45', NULL),
(21, 1, 'DEV', '2d53225b4ec214a129ff462093ca9bcbfd9d7921176e4a35', '2025-09-16 19:48:35', '2025-09-17 03:48:35', NULL),
(22, 1, 'DEV', 'edd877a7dfd87fb31d2dd2cdf9e130dfc2f0734f37f6baa7', '2025-09-16 20:00:12', '2025-09-17 04:00:12', NULL),
(23, 1, 'DEV', '759fa4aa3679d694d8432adcf40aa507a0e99afaa61ed921', '2025-09-17 07:57:38', '2025-09-17 15:57:38', NULL),
(24, 1, 'DEV', '458d8fe73cff7d78c21daaac109fc90abfb8bd8c6d4817d1', '2025-09-17 08:28:28', '2025-09-17 16:28:28', NULL),
(25, 1, 'DEV', '56b8a60f7ac89f83c4ec4ccba5aa808df6634e8fd9830ddd', '2025-09-18 10:18:43', '2025-09-18 18:18:43', NULL),
(26, 1, 'DEV', '453f6194efcab03238d53381be9736c92ff7027d5d78f74e', '2025-09-18 11:32:07', '2025-09-18 19:32:07', NULL),
(27, 1, 'DEV', '475a81f4ec64cd6d76eb0319bb90f6512ce7472652114f22', '2025-09-18 11:41:59', '2025-09-18 19:41:59', NULL),
(28, 1, 'DEV', '414b8d31fb8da4d07319f44820b5f7d281b9bd102a03b3b4', '2025-09-18 11:52:02', '2025-09-18 19:52:02', NULL),
(29, 1, 'DEV', '99d685ac24c4cf68920cda2944828d6a788b179c14eeb197', '2025-09-18 13:39:57', '2025-09-18 21:39:57', NULL),
(30, 1, 'DEV', '0d345777bc49d9ba6bc3601a25b7a3145d0f8d68a2cdea33', '2025-09-18 13:51:14', '2025-09-18 21:51:14', NULL),
(31, 1, 'DEV', 'cb7f9da6b36b02b3cae53d1b3563b8bb1a1479f6be869e76', '2025-09-18 14:15:03', '2025-09-18 22:15:03', NULL),
(32, 1, 'DEV', 'f1d690992d588d31029d02e827c99707ba0225237517358e', '2025-09-18 14:29:33', '2025-09-18 22:29:33', NULL),
(33, 1, 'DEV', '3c2172ebcb6dfeb8c5e466a22c1b32a2f06407162a4d49c3', '2025-09-18 15:29:38', '2025-09-18 23:29:38', NULL),
(34, 1, 'DEV', '24c21e6de3db819b2c7cc82494436cd5f5442cc558a3ee3b', '2025-09-18 16:46:43', '2025-09-19 00:46:43', NULL),
(35, 1, 'DEV', '20722d9ac1dbdc066a084cc9d97fb3a9c4f7429d5cfff3eb', '2025-09-18 17:33:41', '2025-09-19 01:33:41', NULL),
(36, 1, 'DEV', 'b1638f13509b4c2f04eb6f14392612f2a6588f029d23ac9f', '2025-09-18 20:13:30', '2025-09-19 04:13:30', NULL),
(37, 1, 'DEV', '996e2443ef9e88f9caf9e4f7019169cb67d49b8b0a760ac7', '2025-09-18 20:48:22', '2025-09-19 04:48:22', NULL),
(38, 1, 'DEV', '95c14702480ed6b712a3a8d963ac4363cf65daeafea5b513', '2025-09-19 07:54:56', '2025-09-19 15:54:56', NULL),
(39, 1, 'DEV', '63612e00b89983625a980c9a8af2a87715f80c6d8c73d35f', '2025-09-19 13:43:30', '2025-09-19 21:43:30', NULL),
(40, 1, 'DEV', '69ebbab612b029b21ae5810af2e1bcf09f32bd0dd1e5fd6d', '2025-09-19 16:55:58', '2025-09-20 00:55:58', NULL),
(41, 1, 'DEV', '76b1677dc93651c4a12e36d088ba277e2853afaf26e2bd79', '2025-09-19 17:21:12', '2025-09-20 01:21:12', NULL),
(42, 1, 'DEV', 'fbd2fa0faae0d4dc618416e56368c2497c77a3cfaa7ed445', '2025-09-19 19:46:33', '2025-09-20 03:46:33', NULL),
(43, 1, 'DEV', '3957a4aae4721170f381bb862bcf2e56e8b25068391dd4c4', '2025-09-19 21:33:31', '2025-09-20 05:33:31', NULL),
(44, 1, 'DEV', '8b4eb61d2b5f610edbc7856e961796f0bddaf8f67e19f530', '2025-09-19 22:26:44', '2025-09-20 06:26:44', NULL),
(45, 1, 'DEV', 'ecb93eada61624d8ba6e6e5c8285bef0e70f8f89e2047769', '2025-09-19 23:00:11', '2025-09-20 07:00:11', NULL),
(46, 1, 'DEV', 'fb0bdaee0f79b20667d3663c97b18bd9f27635f9ff5effb8', '2025-09-20 00:28:09', '2025-09-20 08:28:09', NULL),
(47, 1, 'DEV', '68087aaa049725a82fcb0eedd983d90902275a1cca379c96', '2025-09-20 10:57:26', '2025-09-20 18:57:26', NULL),
(48, 1, 'DEV', '523baaf79fcf4ba0fb316f82ea8e1f974d8637c48b68ec13', '2025-09-20 18:51:25', '2025-09-21 02:51:25', NULL),
(49, 1, 'DEV', '752f0acf3266265f2a9b7c6e341bb9e32435784fa71428e3', '2025-09-20 23:53:25', '2025-09-21 07:53:25', NULL),
(50, 1, 'DEV', '4b267313527b98dfe32f9fdd44a49d83ea4d0af1d8421465', '2025-09-21 09:34:36', '2025-09-21 17:34:36', NULL),
(51, 1, 'DEV', 'e325dbe10d0eb24c8e4d60c804242f9e84ef87c19e7320af', '2025-09-21 14:23:24', '2025-09-21 22:23:24', NULL),
(52, 1, 'DEV', 'dcdbbd14ca3f771eb72a4f095414c7577c534a0e2e56b479', '2025-09-21 17:05:59', '2025-09-22 01:05:59', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `login_events`
--

DROP TABLE IF EXISTS `login_events`;
CREATE TABLE `login_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` enum('success','fail','locked') NOT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `login_events`
--

INSERT INTO `login_events` (`id`, `email`, `status`, `ip`, `user_agent`, `created_at`) VALUES
(1, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 11:53:36'),
(2, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 11:53:52'),
(3, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 13:28:15'),
(4, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 13:28:27'),
(5, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 13:28:30'),
(6, 'eric@corbsier.fr', 'fail', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 13:29:42'),
(7, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 16:00:21'),
(8, '', 'fail', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 16:12:29'),
(9, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 18:00:28'),
(10, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 18:40:30'),
(11, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 20:38:38'),
(12, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 20:43:30'),
(13, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 20:43:32'),
(14, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 21:55:47'),
(15, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 22:15:32'),
(16, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 22:22:56'),
(17, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 22:32:42'),
(18, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 23:00:13'),
(19, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 23:24:09'),
(20, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 23:24:11'),
(21, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-15 23:48:50'),
(22, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-16 00:04:45'),
(23, 'eric@corbisier.fr', 'success', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-16 19:48:35'),
(24, 'eric@corbisier.fr', 'success', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-16 20:00:12'),
(25, 'eric@corbisier.fr', 'success', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-17 07:57:38'),
(26, 'eric@corbisier.fr', 'success', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-17 08:28:28'),
(27, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-18 10:18:43'),
(28, 'eric.corbisier@free.fr', 'fail', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:00:55'),
(29, 'eric.corbisier@free.fr', 'fail', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:07:16'),
(30, 'eric.corbisier@free.fr', 'fail', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:10:03'),
(31, 'eric.corbisier@free.fr', 'fail', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:10:19'),
(32, 'eric.corbisier@free.fr', 'fail', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:12:38'),
(33, 'eric.corbisier@free.fr', 'fail', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:13:50'),
(34, 'eric.corbisier@free.fr', 'fail', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:14:34'),
(35, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-18 11:32:07'),
(36, 'eric@corbisier.fr', 'success', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:41:59'),
(37, 'eric@corbisier.fr', 'success', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 11:52:02'),
(38, 'eric@corbisier.fr', 'success', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 13:39:57'),
(39, 'eric@corbisier.fr', 'success', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 13:51:14'),
(40, 'eric@corbisier.fr', 'success', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 14:15:03'),
(41, 'eric@corbisier.fr', 'success', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 14:29:33'),
(42, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-18 15:29:38'),
(43, 'eric@corbisier.fr', 'success', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 16:46:43'),
(44, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 17:33:41'),
(45, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-18 20:13:30'),
(46, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-18 20:48:22'),
(47, 'eric@corbisier.fr', 'success', '2a04:cec0:1035:2fa:0:5c:504c:f01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-19 07:54:56'),
(48, 'eric@corbisier.fr', 'success', '2a04:cec0:1035:2fa:0:5c:504c:f01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-19 13:43:30'),
(49, 'eric@corbisier.fr', 'success', '24.206.123.77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-19 16:55:58'),
(50, 'eric@corbisier.fr', 'success', '2a04:cec0:1035:2fa:0:5c:504c:f01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-19 17:21:12'),
(51, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-19 19:46:33'),
(52, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0', '2025-09-19 21:33:31'),
(53, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-19 22:26:44'),
(54, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-19 23:00:11'),
(55, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-20 00:28:09'),
(56, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-20 10:57:26'),
(57, 'eric@corbisier.fr', 'success', '2a04:cec0:10ef:9f0a:0:57:2fbc:cd01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-20 18:51:25'),
(58, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-20 23:53:25'),
(59, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-21 09:34:36'),
(60, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-21 14:23:24'),
(61, 'eric@corbisier.fr', 'success', '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-21 17:05:59');

-- --------------------------------------------------------

--
-- Structure de la table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(128) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_events`
--

DROP TABLE IF EXISTS `password_reset_events`;
CREATE TABLE `password_reset_events` (
  `id` bigint(20) NOT NULL,
  `email` varchar(190) NOT NULL,
  `status` enum('ok','user_not_found','request') NOT NULL,
  `ip` varchar(45) NOT NULL DEFAULT '',
  `user_agent` varchar(255) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `password_reset_events`
--

INSERT INTO `password_reset_events` (`id`, `email`, `status`, `ip`, `user_agent`, `created_at`) VALUES
(1, 'eric@corbisier.fr', 'request', '2a04:cec0:1033:6d49:0:61:b5f8:6901', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 07:46:56'),
(2, 'eric@corbisier.fr', 'request', '2a04:cec0:1033:6d49:0:61:b5f8:6901', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 07:52:00'),
(3, 'eric@corbisier.fr', 'request', '2a04:cec0:1033:6d49:0:61:b5f8:6901', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 08:46:15'),
(4, 'eric@corbisier.fr', 'request', '2a04:cec0:1033:6d49:0:61:b5f8:6901', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 08:51:31'),
(5, 'eric@corbisier.fr', 'request', '2a04:cec0:1033:6d49:0:61:b5f8:6901', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 08:52:37'),
(6, 'eric@corbisier.fr', 'request', '2a04:cec0:1033:6d49:0:61:b5f8:6901', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 09:09:26'),
(7, 'eric@corbisier.fr', 'request', '2a04:cec0:1033:6d49:0:61:b5f8:6901', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 09:13:23'),
(8, 'eric@corbisier.fr', 'request', '2a04:cec0:1033:6d49:0:61:b5f8:6901', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 09:14:27'),
(9, 'eric@corbisier.fr', 'request', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-14 19:28:21'),
(10, 'eric@corbisier.fr', 'request', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-17 06:26:40'),
(11, 'eric@corbisier.fr', 'request', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-17 06:28:24'),
(12, 'eric@corbisier.fr', 'request', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 07:10:30'),
(13, 'eric@corbisier.fr', 'request', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 09:30:42'),
(14, 'eric@corbisier.fr', 'ok', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-18 09:31:58'),
(15, 'eric@corbisier.fr', 'request', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-18 09:46:18');

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `id` bigint(20) NOT NULL,
  `email` varchar(190) NOT NULL,
  `jti` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `email`, `jti`, `expires_at`, `used_at`, `revoked`, `created_at`) VALUES
(1, 'eric@corbisier.fr', 'BoIKBiLvduZU9brUbPypiA', '2025-09-14 11:19:26', NULL, 1, '2025-09-14 09:09:26'),
(2, 'eric@corbisier.fr', 'vpZ2pOz0CaYX5yzJK4PELg', '2025-09-14 11:23:23', NULL, 1, '2025-09-14 09:13:23'),
(3, 'eric@corbisier.fr', 'sT2M2jxD5KOSHlRISSLTuQ', '2025-09-14 11:24:27', NULL, 1, '2025-09-14 09:14:27'),
(4, 'eric@corbisier.fr', 'c02tCnahFALYhIWYL-mw2w', '2025-09-14 21:38:21', NULL, 1, '2025-09-14 19:28:21'),
(5, 'eric@corbisier.fr', 'lbyTdSd-Ze7C25JYzNGcVg', '2025-09-17 08:36:40', NULL, 1, '2025-09-17 06:26:40'),
(6, 'eric@corbisier.fr', '6tc7Uh2lNARc1rELUohfTA', '2025-09-17 08:38:24', NULL, 1, '2025-09-17 06:28:24'),
(7, 'eric@corbisier.fr', 'yUOU-s_rtO7VQeE4UsQWPw', '2025-09-18 09:20:30', NULL, 1, '2025-09-18 07:10:30'),
(8, 'eric@corbisier.fr', '3LTyVUcqsIBBEpBfVtMJhQ', '2025-09-18 11:40:42', '2025-09-18 11:31:58', 1, '2025-09-18 09:30:42'),
(9, 'eric@corbisier.fr', 'wywLWLL944kyv6tY-kX9jw', '2025-09-18 11:56:18', NULL, 1, '2025-09-18 09:46:18'),
(10, 'eric@corbisier.fr', 'TDHU-hQsfNIBMemIZvDlAQ', '2025-09-21 22:50:40', NULL, 1, '2025-09-21 20:40:40'),
(11, 'eric@corbisier.fr', '9cL2D9nIZFISHO9zdkJymA', '2025-09-21 22:55:27', NULL, 0, '2025-09-21 20:45:27');

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `session_id` varchar(64) NOT NULL,
  `issued_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `revoked_at` datetime DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `session_id`, `issued_at`, `expires_at`, `revoked_at`, `ip`, `user_agent`) VALUES
(1, 1, '89888b55d7255aeddab28df13e2a1bb6', '2025-09-15 11:53:36', '2025-09-15 13:53:36', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(2, 1, '3ce545871eb8022a5f2373e4bec08314', '2025-09-15 11:53:52', '2025-09-15 13:53:52', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(3, 1, 'ee76bad4908c6b60ebb7b1876b6239da', '2025-09-15 13:28:15', '2025-09-15 15:28:15', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(4, 1, '708782bc3b1c5cb8321424c667ca0bc9', '2025-09-15 13:28:27', '2025-09-15 15:28:27', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(5, 1, '54b4f52e526c99c2a0f35ef2f3bb7d96', '2025-09-15 13:28:30', '2025-09-15 15:28:30', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(6, 1, 'b9e122908bed1c00b7d5a47de37a484f', '2025-09-15 16:00:21', '2025-09-15 18:00:21', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(7, 1, 'f64228e17aad0de98bd1f90919ad653a', '2025-09-15 18:00:28', '2025-09-15 20:00:28', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(8, 1, '7263098ade0e2291233923a9272693f6', '2025-09-15 18:40:30', '2025-09-15 20:40:30', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(9, 1, '9e64961a999070a88cae363e4daf1b77', '2025-09-15 20:38:38', '2025-09-15 22:38:38', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(10, 1, '7a9e0f21d8d12e2a1921e2c30e674e1c', '2025-09-15 20:43:30', '2025-09-15 22:43:30', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(11, 1, '554d2164b19b8c083abd75fdd674c55d', '2025-09-15 20:43:32', '2025-09-15 22:43:32', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(12, 1, '43f738f452e9e79e1c2306bd3f18121c', '2025-09-15 21:55:47', '2025-09-15 23:55:47', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(13, 1, 'f5cec3ccd7bde118e8338b74106ff592', '2025-09-15 22:15:32', '2025-09-16 00:15:32', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(14, 1, '974fa749ebb6f13a5071497f46a2d5d7', '2025-09-15 22:22:56', '2025-09-16 00:22:56', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(15, 1, 'b621ea1c7154600c376033d1276625da', '2025-09-15 22:32:42', '2025-09-16 00:32:42', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(16, 1, '931233a6ddb9f3ed6ecfb5a786f386f1', '2025-09-15 23:00:13', '2025-09-16 01:00:13', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(17, 1, '57964fa64a449e2c4cad3d1917bebe1c', '2025-09-15 23:24:09', '2025-09-16 01:24:09', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(18, 1, '355aec1f3ee335e02f412a192139be3c', '2025-09-15 23:24:10', '2025-09-16 01:24:10', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(19, 1, 'd25df850b58fe6c904934be5085a7795', '2025-09-15 23:48:50', '2025-09-16 01:48:50', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(20, 1, '1ddc59a27923caba32b3398beec42b66', '2025-09-16 00:04:45', '2025-09-16 02:04:45', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(21, 1, '3bf7e65010cfdd86b09c2e22dff056a7', '2025-09-16 19:48:35', '2025-09-16 21:48:35', '2025-09-18 11:44:08', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(22, 1, '8f690a8def1bcab5ab9f79c3ec676708', '2025-09-16 20:00:12', '2025-09-16 22:00:12', '2025-09-18 11:44:08', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(23, 1, 'f212767dcde30a3539f5a149db7fe91c', '2025-09-17 07:57:38', '2025-09-17 09:57:38', '2025-09-18 11:44:08', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(24, 1, '627623e92b4d5bdd7c8ddafa97217cd6', '2025-09-17 08:28:28', '2025-09-17 10:28:28', '2025-09-18 11:44:08', '2a04:cec0:1034:709d::170e:ee01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(25, 1, '97a7d261979a578144907bdb1d8f2bfb', '2025-09-18 10:18:43', '2025-09-18 12:18:43', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(26, 1, '1b790d79aeb117cbfc55e24fe1bfbf50', '2025-09-18 11:32:07', '2025-09-18 13:32:07', '2025-09-18 11:44:08', '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(27, 1, 'c276c3c27e1cb6c7e3fef0775d6b1d61', '2025-09-18 11:41:59', '2025-09-18 13:41:59', '2025-09-18 11:44:08', '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(28, 1, '80793bb4365641c6dd7a77b6b70b290d', '2025-09-18 11:52:02', '2025-09-18 13:52:02', NULL, '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(29, 1, 'e9d84f9a572a5466c2fa66d9e1bf8f7b', '2025-09-18 13:39:57', '2025-09-18 15:39:57', NULL, '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(30, 1, 'fcc60c9f939d996bd91ce70b101f7817', '2025-09-18 13:51:14', '2025-09-18 15:51:14', NULL, '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(31, 1, '267092b8e6262b166f90726e30aa00e1', '2025-09-18 14:15:03', '2025-09-18 16:15:03', NULL, '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(32, 1, 'ec2b90260bdc94acc5191285ea2951bf', '2025-09-18 14:29:33', '2025-09-18 16:29:33', NULL, '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(33, 1, 'e8eb5083e857942575f47b0d972a5a28', '2025-09-18 15:29:38', '2025-09-18 17:29:38', NULL, '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(34, 1, '7f4d72f97eebb635e70486a3d6cd49f6', '2025-09-18 16:46:43', '2025-09-18 18:46:43', NULL, '24.206.123.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(35, 1, '8223c6766187db9d271195df99d41407', '2025-09-18 17:33:41', '2025-09-18 19:33:41', NULL, '86.253.89.61', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'),
(36, 1, '18791687ce78277a0266fe66245d9edf', '2025-09-18 20:13:30', '2025-09-18 22:13:30', NULL, '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(37, 1, 'b634591a0820971646931e1656b22f09', '2025-09-18 20:48:22', '2025-09-18 22:48:22', NULL, '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'),
(38, 1, '0cad6970fe994aa239e651a2a26abd9e', '2025-09-19 07:54:56', '2025-09-19 09:54:56', NULL, '2a04:cec0:1035:2fa:0:5c:504c:f01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(39, 1, 'fba8002bb278aea031e060f6b0829834', '2025-09-19 13:43:30', '2025-09-19 15:43:30', NULL, '2a04:cec0:1035:2fa:0:5c:504c:f01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(40, 1, 'db58b6465d2eb4871bf74ba0f856f396', '2025-09-19 16:55:58', '2025-09-19 18:55:58', NULL, '24.206.123.77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(41, 1, '00f5e52be3b3dbdb3058baef833b3022', '2025-09-19 17:21:12', '2025-09-19 19:21:12', NULL, '2a04:cec0:1035:2fa:0:5c:504c:f01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(42, 1, '43e65ea2a086b870d5bf1b7b8501920f', '2025-09-19 19:46:33', '2025-09-19 21:46:33', NULL, '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(43, 1, 'cbd36ca59668ac0c9524da48b62e904a', '2025-09-19 21:33:31', '2025-09-19 23:33:31', NULL, '86.253.89.61', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0'),
(44, 1, 'aa128a3cc8903aaf1eb059517d6895e2', '2025-09-19 22:26:44', '2025-09-20 00:26:44', NULL, '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(45, 1, 'bc0bd22e56e602c7b67be89d6a740366', '2025-09-19 23:00:11', '2025-09-20 01:00:11', NULL, '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'),
(46, 1, '7d6795b0eb12c007cd8e13659f58e61b', '2025-09-20 00:28:09', '2025-09-20 02:28:09', NULL, '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(47, 1, 'a8ea4b1bffdf42add0f9e1a4d398ba66', '2025-09-20 10:57:26', '2025-09-20 12:57:26', NULL, '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(48, 1, '2f1e37d4b9fd4e6dc3a15938931b36ef', '2025-09-20 18:51:25', '2025-09-20 20:51:25', NULL, '2a04:cec0:10ef:9f0a:0:57:2fbc:cd01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(49, 1, '51c1e2b0dfd20042eab14af459ba639e', '2025-09-20 23:53:25', '2025-09-21 01:53:25', NULL, '86.253.89.61', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36'),
(50, 1, 'b3f892b5132019b7de8cb8b6fbfee90d', '2025-09-21 09:34:36', '2025-09-21 11:34:36', NULL, '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'),
(51, 1, '6caf9ff19056fbe0fc06728bb8ac78f4', '2025-09-21 14:23:24', '2025-09-21 16:23:24', NULL, '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'),
(52, 1, '8e69fd725b61b82dad0580d9e254a019', '2025-09-21 17:05:59', '2025-09-21 19:05:59', NULL, '86.253.89.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `role` enum('webmaster','admin','tester') NOT NULL DEFAULT 'tester',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `email_verified_at` datetime DEFAULT NULL,
  `display_name` varchar(120) DEFAULT NULL,
  `login_token` varchar(64) NOT NULL,
  `token_version` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('active','disabled','locked','expired') NOT NULL DEFAULT 'active',
  `failed_attempts` int(11) NOT NULL DEFAULT 0,
  `locked_at` datetime DEFAULT NULL,
  `valid_until` datetime DEFAULT NULL,
  `force_password_change` tinyint(1) NOT NULL DEFAULT 0,
  `can_dev` tinyint(1) NOT NULL DEFAULT 1,
  `can_homol` tinyint(1) NOT NULL DEFAULT 0,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password_hash`, `role`, `is_active`, `email_verified_at`, `display_name`, `login_token`, `token_version`, `last_login_at`, `created_at`, `updated_at`, `status`, `failed_attempts`, `locked_at`, `valid_until`, `force_password_change`, `can_dev`, `can_homol`, `firstname`, `lastname`) VALUES
(1, 'eric@corbisier.fr', '$2y$10$i2hmwt66quvugsJFiXW1hedjZltNnTjzMSJVCmq0A5au37H5JMbwO', 'webmaster', 1, '2025-09-13 12:38:52', 'Webmaster', 'bb563442c08d82db9932861089a10f6e8086bb9f03d7c18b7ed5883e315f90ae', 1, NULL, '2025-09-13 12:38:52', '2025-09-24 22:34:50', 'active', 0, NULL, NULL, 0, 1, 0, NULL, NULL),
(2, 'contact@corbisier.fr', NULL, 'tester', 1, NULL, NULL, '', 1, NULL, '2025-09-18 21:37:31', '2025-09-18 21:40:36', 'active', 0, NULL, '2025-09-23 21:40:00', 1, 1, 1, 'Eric', 'CORBISIER'),
(3, 'commun@corbisier.fr', NULL, 'tester', 1, NULL, NULL, '', 1, NULL, '2025-09-19 17:23:33', '2025-09-19 17:23:33', 'active', 0, NULL, '2025-09-24 17:23:00', 1, 1, 1, 'CORBISIER', 'eric');

-- --------------------------------------------------------

--
-- Structure de la table `user_action_tokens`
--

DROP TABLE IF EXISTS `user_action_tokens`;
CREATE TABLE `user_action_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(255) NOT NULL,
  `token_hash` char(64) DEFAULT NULL,
  `type` enum('invite','reset','verify') NOT NULL,
  `sent_to_email` varchar(255) DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_ip` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_sessions`
--

DROP TABLE IF EXISTS `user_sessions`;
CREATE TABLE `user_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `session_id` char(36) NOT NULL,
  `browser_key_hash` char(64) DEFAULT NULL,
  `user_agent` varchar(400) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_seen_at` datetime DEFAULT NULL,
  `revoked_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_active_users`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_active_users`;
CREATE TABLE `v_active_users` (
`id` bigint(20) unsigned
,`email` varchar(255)
,`role` enum('webmaster','admin','tester')
,`status` enum('active','disabled','locked','expired')
,`firstname` varchar(100)
,`lastname` varchar(100)
,`can_dev` tinyint(1)
,`can_homol` tinyint(1)
,`valid_until` datetime
,`force_password_change` tinyint(1)
,`created_at` datetime
,`updated_at` datetime
);

-- --------------------------------------------------------

--
-- Structure de la vue `v_active_users`
--
DROP TABLE IF EXISTS `v_active_users`;

CREATE ALGORITHM=UNDEFINED DEFINER=`o14758118`@`%` SQL SECURITY DEFINER VIEW `v_active_users`  AS SELECT `users`.`id` AS `id`, `users`.`email` AS `email`, `users`.`role` AS `role`, `users`.`status` AS `status`, `users`.`firstname` AS `firstname`, `users`.`lastname` AS `lastname`, `users`.`can_dev` AS `can_dev`, `users`.`can_homol` AS `can_homol`, `users`.`valid_until` AS `valid_until`, `users`.`force_password_change` AS `force_password_change`, `users`.`created_at` AS `created_at`, `users`.`updated_at` AS `updated_at` FROM `users` WHERE `users`.`status` = 'active''active' ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`skey`);

--
-- Index pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_user` (`user_id`),
  ADD KEY `idx_audit_action` (`action`);

--
-- Index pour la table `env_tokens`
--
ALTER TABLE `env_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `login_events`
--
ALTER TABLE `login_events`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_token` (`token`),
  ADD KEY `idx_user` (`user_id`);

--
-- Index pour la table `password_reset_events`
--
ALTER TABLE `password_reset_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`),
  ADD KEY `created_at` (`created_at`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jti` (`jti`),
  ADD KEY `email` (`email`),
  ADD KEY `expires_at` (`expires_at`),
  ADD KEY `used_at` (`used_at`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_id` (`session_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `idx_users_active` (`is_active`);

--
-- Index pour la table `user_action_tokens`
--
ALTER TABLE `user_action_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_uat_user` (`user_id`),
  ADD KEY `idx_uat_token` (`token`),
  ADD KEY `idx_uat_type` (`type`);

--
-- Index pour la table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_sessions_session` (`session_id`),
  ADD KEY `idx_sessions_user` (`user_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `env_tokens`
--
ALTER TABLE `env_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `login_events`
--
ALTER TABLE `login_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT pour la table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `password_reset_events`
--
ALTER TABLE `password_reset_events`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `user_action_tokens`
--
ALTER TABLE `user_action_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `fk_resets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_action_tokens`
--
ALTER TABLE `user_action_tokens`
  ADD CONSTRAINT `fk_uat_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `fk_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
