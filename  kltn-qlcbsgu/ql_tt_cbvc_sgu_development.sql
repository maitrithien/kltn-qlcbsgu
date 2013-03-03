-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Sam 02 Mars 2013 à 23:14
-- Version du serveur: 5.1.41
-- Version de PHP: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `ql_tt_cbvc_sgu_development`
--

-- --------------------------------------------------------

--
-- Structure de la table `can_bo_thong_tins`
--
-- Création: Ven 01 Février 2013 à 10:25
--

CREATE TABLE IF NOT EXISTS `can_bo_thong_tins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ma_cb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ho_ten` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ten_goi_khac` varchar(225) CHARACTER SET utf8 DEFAULT NULL,
  `gioi_tinh` tinyint(1) NOT NULL DEFAULT '1',
  `hinh_anh` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `noi_sinh` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `que_quan` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dan_toc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ton_giao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `so_cmnd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ngay_cap_cmnd` date DEFAULT NULL,
  `so_BHXH` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `noi_dang_ky_ho_khau_thuong_tru` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `noi_o_hien_nay` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tep_tin_dinh_kem` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=46 ;

--
-- Contenu de la table `can_bo_thong_tins`
--

INSERT INTO `can_bo_thong_tins` (`id`, `ma_cb`, `ho_ten`, `ten_goi_khac`, `gioi_tinh`, `hinh_anh`, `ngay_sinh`, `noi_sinh`, `que_quan`, `dan_toc`, `ton_giao`, `so_cmnd`, `ngay_cap_cmnd`, `so_BHXH`, `noi_dang_ky_ho_khau_thuong_tru`, `noi_o_hien_nay`, `tep_tin_dinh_kem`, `is_deleted`, `created_at`, `updated_at`) VALUES
(38, '10002', 'Huỳnh Quang Thông', 'Thông', 1, NULL, '1990-02-02', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '225500234', '2013-02-02', '214555', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(39, '10004', 'Dương Đình Dũng', 'Dũng Dương', 1, NULL, '1994-02-21', 'Cam Ranh, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Thiên Chúa', '2255001324', '2007-02-21', '2145534', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(40, '10005', 'Huỳnh Nhật Thảo', 'Huỳnh Thảo', 1, NULL, '1997-02-21', 'Cam Ranh, Khánh Hòa', 'Nha Trang, Khanh Hòa', 'Khơ Me', 'Thiên Chúa', '2255001325', '1999-02-21', '1233456', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(41, '10006', 'Mai Trí Dũng', 'Mai Trí Dũng', 1, NULL, '1995-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '22550013256', '1977-02-21', '214555', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(42, '10007', 'Hoàng Kim Bảo', 'Hoàng Kim Bảo', 1, NULL, '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Khơ Me', 'Phật Giáo', '2255001327', '2008-02-21', '214555', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(43, '10008', 'Lê Xuân Thân', 'Lê Xuân Thân', 1, NULL, '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '22550013209', '2006-02-21', '1233455', 'Nha Trang, Khánh Hòa', 'Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(44, '10011', 'Mai Thị Hồng', 'Mai Thị Hồng', 0, NULL, '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '2255001377', '1997-02-21', '2145534', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(45, '10003', 'Mai Trí Thiện', 'Mai Trí Thiện', 1, NULL, '1991-07-05', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Khơ Me', 'Phật Giáo', '225502174', '2013-02-02', '1233456', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-02 11:46:20', '2013-03-02 11:46:20');

-- --------------------------------------------------------

--
-- Structure de la table `casein_users`
--
-- Création: Ven 01 Février 2013 à 09:35
--

CREATE TABLE IF NOT EXISTS `casein_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `access_level` int(11) NOT NULL DEFAULT '0',
  `crypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `persistence_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `single_access_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `perishable_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `failed_login_count` int(11) NOT NULL DEFAULT '0',
  `last_request_at` datetime DEFAULT NULL,
  `current_login_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `current_login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `time_zone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Contenu de la table `casein_users`
--

INSERT INTO `casein_users` (`id`, `login`, `name`, `email`, `access_level`, `crypted_password`, `password_salt`, `persistence_token`, `single_access_token`, `perishable_token`, `login_count`, `failed_login_count`, `last_request_at`, `current_login_at`, `last_login_at`, `current_login_ip`, `last_login_ip`, `time_zone`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', 'you@yourdomain.com', 0, 'e8d4bde49567973f43e33d8c7eb73167c43859b9ed4dc4f9891d345bd07222ccb3860cd38066683ab6461b54421505a39392be132bb51c7b7e2f98b6bc5bd1c0', 'sWR8MdfPXYCVTu5FIwK', '5d6b12d3c70a37d66253860082aa89559d9edd42b5397e9f6d98073c50319744ff661075909001e92cd4e8b87ab867e9b19c73e8445300046f50107285d094ad', 'PTWT227GhIFM4j3LWOb', 'uzpsNeCVUj1eCmxho63', 21, 0, '2013-03-02 16:13:14', '2013-03-02 11:39:40', '2013-03-02 10:22:47', '127.0.0.1', '127.0.0.1', 'Hanoi', '2013-02-01 02:38:48', '2013-03-02 16:13:14'),
(2, 'maitrithien', 'maitrithien', 'maitrithien@gmail.com', 10, 'c1f6b60224c5969a3ab7562dc5a6db88c6d4a031aaa5917aeffb88ce75ab48563dd6c910ca89e767ba22d8b4ea83299d4d7d5338bd25b3b699086013b235cb50', 'mHv2EgbmTwcHV3Yfidkr', '1e957968c8c4d6938e30f03213a0f48642bbe7c7404c1834d68474989d26b3492df2f3680813daf7e82aa60982e6c7f227422e6a97390c24754eda177e6e1814', 'jH0voDowLspNC5ngnobK', 'ZKXkhyrB8VPu3I1c3uMV', 1, 0, '2013-02-01 03:49:31', '2013-02-01 03:49:18', NULL, '127.0.0.1', NULL, 'Hanoi', '2013-02-01 03:48:54', '2013-02-01 16:25:44');

-- --------------------------------------------------------

--
-- Structure de la table `params`
--
-- Création: Ven 01 Mars 2013 à 10:22
--

CREATE TABLE IF NOT EXISTS `params` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `options` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

--
-- Contenu de la table `params`
--

INSERT INTO `params` (`id`, `param_name`, `param_value`, `options`, `description`, `created_at`, `updated_at`) VALUES
(1, 'adding_success', 'Đã thêm dữ liệu thành công!', '', 'Thông báo thành công khi thêm mới dữ liệu', '2013-03-01 03:27:03', '2013-03-01 16:11:48'),
(3, 'updating_success', 'Đã cập nhật dữ liệu thành công!', '', 'Thông báo thành công khi cập nhật dữ liệu', '2013-03-01 03:31:05', '2013-03-01 16:11:57'),
(4, 'website_name', 'Hệ thống quản lý thông tin cán bộ công chức - Đại học Sài Gòn', '', 'Tên website', '2013-03-01 15:18:38', '2013-03-01 18:01:11'),
(5, 'updating_false', 'Cập nhật dữ liệu không thành công! vui lòng kiểm tra lại thông tin cập nhật.', '', 'Thông báo không thành công khi cập nhật dữ liệu', '2013-03-01 16:06:21', '2013-03-01 16:08:42'),
(6, 'deleting_success', 'Đã xóa dữ liệu thành công!', '', 'Thông báo xóa dữ liệu thành công', '2013-03-01 16:08:30', '2013-03-01 16:08:30'),
(7, 'adding_false', 'Thêm dữ liệu không thành công! vui lòng kiểm tra lại thông tin.', '', 'Thông báo không thành công khi thêm mới dữ liệu', '2013-03-01 16:10:38', '2013-03-01 16:10:38'),
(9, 'param_index_page_title', 'Tham số', '', 'Title trang index của scaffold tham số', '2013-03-01 16:15:44', '2013-03-01 16:15:44'),
(10, 'param_show_page_title', 'Hiệu chỉnh tham số', '', 'Title trang show của scaffold tham số', '2013-03-01 16:17:40', '2013-03-01 16:17:40'),
(11, 'searching_has_no_result', 'Không tìm thấy dữ liệu!', '', 'Thông báo tìm kiếm không trả về kết quả', '2013-03-01 16:33:24', '2013-03-01 16:33:24'),
(12, 'param_new_page_title', 'Thêm mới tham số', '', 'Title trang new của scaffold tham số', '2013-03-01 16:47:12', '2013-03-01 16:47:12'),
(13, 'param_update_page_title', 'Hiệu chỉnh tham số', '', 'Title trang update của scaffold tham số', '2013-03-01 16:49:01', '2013-03-01 16:49:01'),
(14, 'can_bo_thong_tin_index_page_title', 'Cán bộ - Thông tin', '', 'Title trang index của scaffold cán bộ thông tin', '2013-03-02 09:17:43', '2013-03-02 09:17:43'),
(15, 'logo', '/casein/images/logo.png', '', 'Logo website', '2013-03-02 10:00:01', '2013-03-02 12:28:05'),
(16, 'number_searching_result', 'Tống số kết quả tìm thấy : ', '', '', '2013-03-02 13:11:34', '2013-03-02 13:11:34');

-- --------------------------------------------------------

--
-- Structure de la table `schema_migrations`
--
-- Création: Ven 01 Février 2013 à 09:35
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20130201023253'),
('20130201032503'),
('20130301032113');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
