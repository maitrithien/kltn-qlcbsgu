-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 15, 2013 at 08:17 AM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ql_tt_cbvc_sgu_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `bac_luongs`
--

CREATE TABLE IF NOT EXISTS `bac_luongs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ngach_id` int(11) DEFAULT NULL,
  `bac` int(11) DEFAULT NULL,
  `he_so_luong` float DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vuot_khung` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `bac_luongs`
--


-- --------------------------------------------------------

--
-- Table structure for table `can_bo_cong_tacs`
--

CREATE TABLE IF NOT EXISTS `can_bo_cong_tacs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `can_bo_thong_tin_id` int(11) DEFAULT NULL,
  `don_vi_id` int(11) DEFAULT NULL,
  `nghe_nghiep_truoc_tuyen_dung` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cong_viec_chinh_duoc_giao` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `so_truong_cong_tac` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ngay_bat_dau_lam_viec` date DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `can_bo_cong_tacs`
--


-- --------------------------------------------------------

--
-- Table structure for table `can_bo_li_lich_cts`
--

CREATE TABLE IF NOT EXISTS `can_bo_li_lich_cts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `can_bo_thong_tin_id` int(11) DEFAULT NULL,
  `ngay_vao_dang` date DEFAULT NULL,
  `ngay_nhap_ngu` date DEFAULT NULL,
  `ngay_xuat_ngu` date DEFAULT NULL,
  `quan_ham_cao_nhat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `danh_hieu_duoc_phong_tang` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thuong_binh_hang` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `con_gia_dinh_chinh_sach` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `can_bo_thong_tin_id` (`can_bo_thong_tin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `can_bo_li_lich_cts`
--

INSERT INTO `can_bo_li_lich_cts` (`id`, `can_bo_thong_tin_id`, `ngay_vao_dang`, `ngay_nhap_ngu`, `ngay_xuat_ngu`, `quan_ham_cao_nhat`, `danh_hieu_duoc_phong_tang`, `thuong_binh_hang`, `con_gia_dinh_chinh_sach`, `created_at`, `updated_at`) VALUES
(1, 38, '2013-03-06', '2013-03-06', '2013-03-06', 'Trung  tướng', 'Anh hùng lực lượng vũ trang nhân dân', '1/4', 'Hộ nghèo', '2013-03-06 00:33:52', '2013-03-06 00:34:52');

-- --------------------------------------------------------

--
-- Table structure for table `can_bo_thong_tins`
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `ma_cb` (`ma_cb`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=49 ;

--
-- Dumping data for table `can_bo_thong_tins`
--

INSERT INTO `can_bo_thong_tins` (`id`, `ma_cb`, `ho_ten`, `ten_goi_khac`, `gioi_tinh`, `hinh_anh`, `ngay_sinh`, `noi_sinh`, `que_quan`, `dan_toc`, `ton_giao`, `so_cmnd`, `ngay_cap_cmnd`, `so_BHXH`, `noi_dang_ky_ho_khau_thuong_tru`, `noi_o_hien_nay`, `tep_tin_dinh_kem`, `is_deleted`, `created_at`, `updated_at`) VALUES
(38, '10002', 'Huỳnh Quang Thông', 'Thông', 1, '1362531280.jpg', '1990-02-02', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '225500234', '2013-02-02', '214555', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362530924.doc', 0, '2013-03-01 15:44:21', '2013-03-06 00:54:40'),
(39, '10004', 'Dương Văn Đồng', 'Dương Văn Đồng', 1, '1362531392.jpg', '1994-02-21', 'Cam Ranh, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Thiên Chúa', '2255001324', '2007-02-21', '2145534', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362531392.doc', 0, '2013-03-01 15:44:21', '2013-03-10 15:56:32'),
(40, '10005', 'Lê Thị Mơ', 'Lê Thị Hằng', 0, '1362531341.jpg', '1997-02-21', 'Cam Ranh, Khánh Hòa', 'Nha Trang, Khanh Hòa', 'Khơ Me', 'Thiên Chúa', '2255001325', '1999-02-21', '1233456', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362531341.doc', 0, '2013-03-01 15:44:21', '2013-03-06 00:55:41'),
(41, '10006', 'Mai Trí Dũng', 'Mai Trí Dũng', 1, '1362531447.jpg', '1995-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '22550013256', '1977-02-21', '214555', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362531447.doc', 0, '2013-03-01 15:44:21', '2013-03-06 00:57:27'),
(42, '10007', 'Nguyễn Thiên Kim', 'Nguyễn Thiên Kim', 0, '1362531503.jpg', '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Khơ Me', 'Phật Giáo', '2255001327', '2008-02-21', '214555', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362531503.doc', 0, '2013-03-01 15:44:21', '2013-03-09 02:33:52'),
(43, '10008', 'Nguyễn Phương Thảo', 'Lê Phương Thảo', 0, '1362531571.jpg', '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '22550013209', '2006-02-21', '1233455', 'Nha Trang, Khánh Hòa', 'Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362531571.doc', 0, '2013-03-01 15:44:21', '2013-03-06 00:59:31'),
(44, '10011', 'Đỗ Thị Hồng', 'Mai Thị Hồng', 0, NULL, '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '2255001377', '1997-02-21', '2145534', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-04 15:18:21'),
(45, '10003', 'Mai Trí Thiện', 'Mai Trí Thiện', 1, '1362531962.jpg', '1991-07-05', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Khơ Me', 'Phật Giáo', '225502174', '2013-02-02', '1233456', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362531962.doc', 0, '2013-03-02 11:46:20', '2013-03-06 01:06:02'),
(46, '10016', 'Nguyễn Xuân Quỳnh', 'Nguyễn Xuân Quỳnh', 0, '1362649664.jpg', '1991-05-25', 'Nha Trang, Khánh Hòa', 'Vĩnh An, Vĩnh Cữu, Đồng Nai', 'Khơ Me', 'Phật Giáo', '2255021746.0', '2000-02-02', '1233456.0', 'Vĩnh An, Vĩnh Cữu, Đồng Nai', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362649664.doc', 0, '2013-03-07 09:05:49', '2013-03-07 09:48:10'),
(47, '10017', 'Trần Quốc Tiệp', 'Trần Quốc Tiệp', 1, '1362649597.jpg', '1994-02-21', 'Đăk Ya, Mang Yang, Gia Lai', 'Đăk Ya, Mang Yang, Gia Lai', 'Kinh', 'Phật Giáo', '2255001399.0', '2000-02-21', '2145534', 'Đăk Ya, Mang Yang, Gia Lai', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362649597.doc', 0, '2013-03-07 09:05:49', '2013-03-07 09:46:37'),
(48, '10018', 'Nguyễn Thị Thanh Tâm', 'Thanh Tâm', 0, '1362886090.jpg', '2013-03-10', 'Thủ Dầu Một, Bình Dương', 'Bình Dương', 'Kinh', 'Không', '22550023124', '2007-09-04', '1343353', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', '1362888221.doc', 0, '2013-03-10 03:18:12', '2013-03-10 04:03:41');

-- --------------------------------------------------------

--
-- Table structure for table `can_bo_trinh_dos`
--

CREATE TABLE IF NOT EXISTS `can_bo_trinh_dos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trinh_do_gd_pho_thong` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trinh_do_chuyen_mon_id` int(11) DEFAULT NULL,
  `chuyen_nganh_id` int(11) DEFAULT NULL,
  `ly_luan_chinh_tri_id` int(11) DEFAULT NULL,
  `quan_ly_nha_nuoc_id` int(11) DEFAULT NULL,
  `ngoai_ngu_id` int(11) DEFAULT NULL,
  `trinh_do_ngoai_ngu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trinh_do_tin_hoc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `can_bo_thong_tin_id` int(11) DEFAULT NULL,
  `hoc_ham_id` int(11) DEFAULT NULL,
  `hoc_vi_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `can_bo_trinh_dos`
--

INSERT INTO `can_bo_trinh_dos` (`id`, `trinh_do_gd_pho_thong`, `trinh_do_chuyen_mon_id`, `chuyen_nganh_id`, `ly_luan_chinh_tri_id`, `quan_ly_nha_nuoc_id`, `ngoai_ngu_id`, `trinh_do_ngoai_ngu`, `trinh_do_tin_hoc`, `created_at`, `updated_at`, `can_bo_thong_tin_id`, `hoc_ham_id`, `hoc_vi_id`) VALUES
(1, '12/12', 4, 23, 1, 1, 1, 'TOEIC 900', 'C', '2013-03-12 17:58:40', '2013-03-14 09:52:30', 38, 2, 7);

-- --------------------------------------------------------

--
-- Table structure for table `casein_users`
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
-- Dumping data for table `casein_users`
--

INSERT INTO `casein_users` (`id`, `login`, `name`, `email`, `access_level`, `crypted_password`, `password_salt`, `persistence_token`, `single_access_token`, `perishable_token`, `login_count`, `failed_login_count`, `last_request_at`, `current_login_at`, `last_login_at`, `current_login_ip`, `last_login_ip`, `time_zone`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', 'you@yourdomain.com', 0, 'e8d4bde49567973f43e33d8c7eb73167c43859b9ed4dc4f9891d345bd07222ccb3860cd38066683ab6461b54421505a39392be132bb51c7b7e2f98b6bc5bd1c0', 'sWR8MdfPXYCVTu5FIwK', '5d6b12d3c70a37d66253860082aa89559d9edd42b5397e9f6d98073c50319744ff661075909001e92cd4e8b87ab867e9b19c73e8445300046f50107285d094ad', 'PTWT227GhIFM4j3LWOb', 'BCMeIUj27DcXcZjLoN4F', 38, 0, '2013-03-15 01:15:52', '2013-03-11 15:29:07', '2013-03-11 01:38:14', '127.0.0.1', '127.0.0.1', 'Hanoi', '2013-02-01 02:38:48', '2013-03-15 01:15:52'),
(2, 'maitrithien', 'Mai Trí Thiện', 'maitrithien@gmail.com', 10, 'c1f6b60224c5969a3ab7562dc5a6db88c6d4a031aaa5917aeffb88ce75ab48563dd6c910ca89e767ba22d8b4ea83299d4d7d5338bd25b3b699086013b235cb50', 'mHv2EgbmTwcHV3Yfidkr', '1e957968c8c4d6938e30f03213a0f48642bbe7c7404c1834d68474989d26b3492df2f3680813daf7e82aa60982e6c7f227422e6a97390c24754eda177e6e1814', 'jH0voDowLspNC5ngnobK', 'MkgwFYUbsRbHHEuwAnwv', 1, 0, '2013-02-01 03:49:31', '2013-02-01 03:49:18', NULL, '127.0.0.1', NULL, 'Hanoi', '2013-02-01 03:48:54', '2013-03-03 06:44:21');

-- --------------------------------------------------------

--
-- Table structure for table `chuc_vus`
--

CREATE TABLE IF NOT EXISTS `chuc_vus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_chuc_vu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `he_so_phu_cap` float DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `chuc_vus`
--


-- --------------------------------------------------------

--
-- Table structure for table `chuyen_nganhs`
--

CREATE TABLE IF NOT EXISTS `chuyen_nganhs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_chuyen_nganh` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=82 ;

--
-- Dumping data for table `chuyen_nganhs`
--

INSERT INTO `chuyen_nganhs` (`id`, `ten_chuyen_nganh`, `ghi_chu`, `created_at`, `updated_at`) VALUES
(1, 'Cơ động học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:09', '2013-03-12 02:53:09'),
(2, 'Dịch tễ học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:09', '2013-03-12 02:53:09'),
(3, 'Địa chất học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:09', '2013-03-12 02:53:09'),
(4, 'Hóa học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(5, 'Hóa học hữu cơ', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(6, 'Khí tượng', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(7, 'Khoa học Trái Đất', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(8, 'Địa lý học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(9, 'Xác xuất và thống kê', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(10, 'Sinh vật học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(11, 'Sinh thái học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(12, 'Tế bào học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(13, 'Thiên văn', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(14, 'Thực vật học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:10', '2013-03-12 02:53:10'),
(15, 'Toán học rời rạc', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(16, 'Toán học thuần túy', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(17, 'Toán học ứng dụng', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(18, 'Vật lý học', 'Toán và Khoa học tự nhiên', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(19, 'Công nghệ nano', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(20, 'Dược khoa', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(21, 'Điện tử', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(22, 'Internet', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(23, 'Khoa học máy tính', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(24, 'Khoa học sức khỏe', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(25, 'Kiến trúc', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(26, 'Cơ khí', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(27, 'Máy tính', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:11', '2013-03-12 02:53:11'),
(28, 'Phân tâm học', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(29, 'Phần mềm', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(30, 'Công nghệ sinh học', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(31, 'Sinh hóa học', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(32, 'Tâm lý học', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(33, 'Tin học', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(34, 'Y học', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(35, 'Tin sinh học', 'Công nghệ và khoa học ứng dụng', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(36, 'Báo chí', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(37, 'Lâm nghiệp', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(38, 'Nông nghiệp', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(39, 'Chính trị', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(40, 'Công nghiệp', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(41, 'Cộng đồng', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(42, 'Gia tộc', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(43, 'Giao thông', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(44, 'Giáo dục', 'Xã hội và Triết lý', '2013-03-12 02:53:12', '2013-03-12 02:53:12'),
(45, 'Hành chính', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(46, 'Khoa học', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(47, 'Kinh tế', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(48, 'Công nghệ', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(49, 'Lịch sử', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(50, 'Luật pháp', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(51, 'Thương mại', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(52, 'Ngư nghiệp', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(53, 'Tài chính', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(54, 'Tư duy sáng tạo', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(55, 'Truyền thông', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(56, 'Xã hội học', 'Xã hội và Triết lý', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(57, 'Âm nhạc', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(58, 'Ẩm thực', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(59, 'Du lịch', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(60, 'Mỹ thuật', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(61, 'Điêu khắc', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:13', '2013-03-12 02:53:13'),
(62, 'Hội họa', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(63, 'Khảo cổ', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(64, 'Kịch nghệ', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(65, 'Lễ Hội', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(66, 'Ngôn ngữ học', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(67, 'Nhân chủng học', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(68, 'Nhiếp ảnh', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(69, 'Phim ảnh', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(70, 'Phong tục tập quán', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(71, 'Radio', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(72, 'Thần thoại học', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(73, 'Thể thao', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(74, 'Thơ', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(75, 'Thủ công và Mỹ nghệ', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(76, 'Tiêu khiển', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(77, 'TV', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:14', '2013-03-12 02:53:14'),
(78, 'Văn', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:15', '2013-03-12 02:53:15'),
(79, 'Văn học', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:15', '2013-03-12 02:53:15'),
(80, 'Văn minh', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:15', '2013-03-12 02:53:15'),
(81, 'Vũ nghệ', 'Văn hóa và Nghệ thuật', '2013-03-12 02:53:15', '2013-03-12 02:53:15');

-- --------------------------------------------------------

--
-- Table structure for table `don_vis`
--

CREATE TABLE IF NOT EXISTS `don_vis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_don_vi` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dia_chi` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `so_dien_thoai` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `don_vis`
--


-- --------------------------------------------------------

--
-- Table structure for table `hoc_hams`
--

CREATE TABLE IF NOT EXISTS `hoc_hams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_hoc_ham` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `hoc_hams`
--

INSERT INTO `hoc_hams` (`id`, `ten_hoc_ham`, `ghi_chu`, `created_at`, `updated_at`) VALUES
(1, 'Giáo sư', '', '2013-03-09 03:38:24', '2013-03-09 03:38:24'),
(2, 'Phó giáo sư', '', '2013-03-09 03:38:34', '2013-03-09 03:38:34');

-- --------------------------------------------------------

--
-- Table structure for table `hoc_vis`
--

CREATE TABLE IF NOT EXISTS `hoc_vis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_hoc_vi` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `hoc_vis`
--

INSERT INTO `hoc_vis` (`id`, `ten_hoc_vi`, `ghi_chu`, `created_at`, `updated_at`) VALUES
(1, 'Tú tài', 'Tốt nghiệp Trung học Phổ thông', '2013-03-09 03:28:07', '2013-03-09 03:28:07'),
(2, 'Cử nhân', 'Tốt nghiệp Đại học', '2013-03-09 03:29:56', '2013-03-09 03:29:56'),
(3, 'Kỹ sư', 'Tốt nghiệp Đại học', '2013-03-09 03:30:08', '2013-03-09 03:30:08'),
(4, 'Bác sĩ', 'Tốt nghiệp Đại học', '2013-03-09 03:30:17', '2013-03-09 03:30:17'),
(5, 'Dược sĩ', 'Tốt nghiệp Đại học', '2013-03-09 03:30:27', '2013-03-09 03:30:27'),
(6, 'Thạc sĩ', 'Tốt nghiệp cao học trong nước hay ngoài nước', '2013-03-09 03:30:52', '2013-03-09 03:30:52'),
(7, 'Tiến sĩ', 'Từ năm 1998, nhà nước có quy định những người đã bảo vệ thành công luận án phó tiến sĩ trong nước, hay phó tiến sĩ ở các nước XHCN, hoặc tốt nghiệp tiến sĩ ở trong nước và tốt nghiệp tiến sĩ ở các nước TBCN thì đều được gọi chung là tiến sĩ.', '2013-03-09 03:31:23', '2013-03-09 03:31:23'),
(8, 'Tiến sĩ khoa học', 'Chỉ dành riêng cho những người bảo vệ thành công luận án tiến sĩ ở Liên xô, từ 1998 thì được gọi là TSKH. Xin lưu ý, đây là những người đã có bằng phó tiến sĩ, sau đó tiếp tục nghiên cứu và bảo vệ được luận án TS với những phát minh khoa học, những phát m', '2013-03-09 03:31:52', '2013-03-09 03:31:52');

-- --------------------------------------------------------

--
-- Table structure for table `lich_su_bac_luongs`
--

CREATE TABLE IF NOT EXISTS `lich_su_bac_luongs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bac_luong_id` int(11) DEFAULT NULL,
  `can_bo_thong_tin_id` int(11) DEFAULT NULL,
  `ngay_thay_doi_bac` date DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `lich_su_bac_luongs`
--


-- --------------------------------------------------------

--
-- Table structure for table `loai_quyet_dinhs`
--

CREATE TABLE IF NOT EXISTS `loai_quyet_dinhs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_loai_qd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `loai_quyet_dinhs`
--

INSERT INTO `loai_quyet_dinhs` (`id`, `ten_loai_qd`, `ghi_chu`, `created_at`, `updated_at`) VALUES
(1, 'Quyết định nâng lương', 'Quyết định nâng bậc lương cho cán bộ', '2013-03-10 04:53:38', '2013-03-10 04:53:38');

-- --------------------------------------------------------

--
-- Table structure for table `ly_luan_chinh_tris`
--

CREATE TABLE IF NOT EXISTS `ly_luan_chinh_tris` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trinh_do` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ly_luan_chinh_tris`
--

INSERT INTO `ly_luan_chinh_tris` (`id`, `trinh_do`, `ghi_chu`, `created_at`, `updated_at`) VALUES
(1, 'Sơ cấp', '', '2013-03-12 15:53:02', '2013-03-12 15:53:02'),
(2, 'Trung cấp', '', '2013-03-12 15:53:30', '2013-03-12 15:53:30'),
(3, 'Cao cấp', '', '2013-03-12 15:53:38', '2013-03-12 15:53:38');

-- --------------------------------------------------------

--
-- Table structure for table `ngaches`
--

CREATE TABLE IF NOT EXISTS `ngaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ma_ngach` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ten_ngach` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nien_han` int(11) DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ngaches`
--


-- --------------------------------------------------------

--
-- Table structure for table `ngoai_ngus`
--

CREATE TABLE IF NOT EXISTS `ngoai_ngus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_ngoai_ngu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `ngoai_ngus`
--

INSERT INTO `ngoai_ngus` (`id`, `ten_ngoai_ngu`, `ghi_chu`, `created_at`, `updated_at`) VALUES
(1, 'Tiếng Anh', '', '2013-03-12 16:44:33', '2013-03-12 16:44:33'),
(2, 'Tiếng Pháp', '', '2013-03-12 16:44:50', '2013-03-12 16:44:50'),
(3, 'Tiếng Nhật', '', '2013-03-12 16:45:02', '2013-03-12 16:45:02'),
(4, 'Tiếng Trung Quốc', '', '2013-03-12 16:45:19', '2013-03-12 16:45:19'),
(5, 'Tiếng Hàn Quốc', '', '2013-03-12 16:45:31', '2013-03-12 16:45:31'),
(6, 'Tiếng Tây Ban Nha', '', '2013-03-12 16:45:50', '2013-03-12 16:45:50');

-- --------------------------------------------------------

--
-- Table structure for table `params`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=79 ;

--
-- Dumping data for table `params`
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
(16, 'number_searching_result', 'Tống số kết quả tìm thấy : ', '', '', '2013-03-02 13:11:34', '2013-03-02 13:11:34'),
(17, 'user_session_blank_page_title', 'Chào mừng đến với trang quản trị', '', 'Title trang blank của scaffold user_session', '2013-03-03 02:18:19', '2013-03-03 02:18:19'),
(18, 'are_you_sure_delete', 'Bạn có chắn muốn xóa', '', 'Thông báo chắc chắn xóa', '2013-03-03 06:16:25', '2013-03-03 06:17:22'),
(19, 'WARNING_this_is_your_user_account_You_will_be_logged_out_if_you_proceed', 'Chú ý: đây là tài khoản của bạn. Bạn sẽ bị đăng xuất nếu đồng ý xử lý.', '', 'Thông báo warning khi delete user', '2013-03-03 06:20:13', '2013-03-03 06:20:13'),
(20, 'users_index_page_title', 'Người dùng', '', 'Title trang index của scaffold users', '2013-03-03 06:48:38', '2013-03-03 06:48:38'),
(21, 'users_new_page_title', 'Thêm mới người dùng', '', 'Title trang new của scaffold users', '2013-03-03 06:49:50', '2013-03-03 06:49:50'),
(22, 'email_has_been_sent_to', 'Một email với các thông tin tài khoản chi tiết đã được gửi tới ', '', 'Thông báo email đã được gửi khi thêm mới người dùng', '2013-03-03 06:52:57', '2013-03-03 06:52:57'),
(23, 'users_show_page_title', 'Xem thông tin người dùng', '', 'Title trang show của scaffold users', '2013-03-03 06:55:44', '2013-03-03 06:55:44'),
(24, 'users_update_page_title', 'Cập nhật thông tin người dùng', '', 'Title trang update của scaffold users', '2013-03-03 06:57:10', '2013-03-03 06:57:10'),
(25, 'has_been_updated', 'đã được cập nhật', '', 'Thông báo đi kèm với thao tác cập nhật tài khoản người dùng thành công', '2013-03-03 06:58:59', '2013-03-03 06:58:59'),
(26, 'users_update_password_page_title', 'Cập nhật mật khẩu', '', 'Title trang update_password của scaffold users', '2013-03-03 07:02:48', '2013-03-03 07:02:48'),
(27, 'your_password_has_been_changed', 'Mật khẩu của bạn đã được thay đổi', '', 'Thông báo khi thay đổi mật khẩu thành công', '2013-03-03 07:04:46', '2013-03-03 07:04:46'),
(28, 'change_password_false', 'Đã xảy ra sự cố, vui lòng kiểm tra lại!', '', 'Thông báo khi thay đổi mật khẩu không thành công', '2013-03-03 07:08:31', '2013-03-03 07:08:31'),
(29, 'the_current_password_is_incorrect', 'Mật khẩu hiện tại không đúng', '', 'Thông báo khi mật khẩu hiện tại nhập không đúng', '2013-03-03 07:09:48', '2013-03-03 07:09:48'),
(30, 'users_reset_password_page_title', 'Lấy lại mật khẩu', '', 'Title trang reset_password của scaffold users', '2013-03-03 07:11:59', '2013-03-03 07:12:09'),
(31, 'your_password_has_been_reset', 'Mật khẩu của bạn đã được thay đổi', '', 'Thông báo khi reset_password thành công', '2013-03-03 07:13:49', '2013-03-03 07:13:49'),
(32, 'password_has_been_reset', 'Mật khẩu đã được thây đổi', '', 'Thông báo thay đổi mật khẩu và gửi kèm vào email', '2013-03-03 07:18:34', '2013-03-03 07:18:34'),
(33, 'has_been_notified_by_email', 'đã được thông báo qua email', '', 'Thông báo thay đổi mật khẩu và gửi kèm vào email', '2013-03-03 07:20:16', '2013-03-03 07:20:16'),
(34, 'has_been_deleted', 'đã được xóa', '', 'Thông báo khi xóa thành công tài khoản người dùng', '2013-03-03 07:22:54', '2013-03-03 07:22:54'),
(35, 'login_successful', 'Đăng nhập thành công !', '', 'Thông báo khi đăng nhập thành công', '2013-03-04 01:06:02', '2013-03-04 01:07:15'),
(36, 'logout_successful', 'Đăng xuất thành công !', '', 'Thông báo khi đăng xuất thành công', '2013-03-04 01:06:52', '2013-03-04 01:06:52'),
(37, 'is_not_blank', 'không được để trống', '', 'Hiển thị khi submit trường null với ràng buộc not null', '2013-03-04 02:51:16', '2013-03-04 02:51:16'),
(38, 'has_already_been_taken', 'đã được sử dụng', '', 'Thông báo đã tồn tại khóa này khi adding - check unique messaging', '2013-03-04 03:01:41', '2013-03-04 03:01:41'),
(39, 'must_be_an_correctly_email', 'email không hợp lệ', '', 'Thông báo email không hợp lệ', '2013-03-04 03:17:59', '2013-03-04 03:19:33'),
(40, 'select_quan_he_cb', 'Cha,Mẹ,Anh,Chị,Em gái,Em trai,Vợ,Chồng,Con trai,Con gái', '', 'Chuỗi giá trị cho select quan hệ gia đình cán bộ', '2013-03-04 05:50:35', '2013-03-04 05:56:33'),
(41, 'than_nhan_index_page_title', 'Thân nhân cán bộ', '', 'Title trang index của scaffold thân nhân', '2013-03-04 15:58:20', '2013-03-04 15:58:20'),
(42, 'than_nhan_new_page_title', 'Thêm mới thân nhân', '', 'Title trang new của scaffold thân nhân', '2013-03-04 15:58:20', '2013-03-04 15:58:20'),
(43, 'than_nhan_show_page_title', 'Thông tin thân nhân', '', 'Title trang show của scaffold thân nhân', '2013-03-04 15:58:20', '2013-03-04 15:58:20'),
(44, 'than_nhan_update_page_title', 'Cập nhật thông tin thân nhân', '', 'Title trang update của scaffold thân nhân', '2013-03-04 15:58:20', '2013-03-04 15:58:20'),
(46, 'param_import_from_excel_page_title', 'Thêm mới dữ liệu từ file excel', '', 'Title trang import_from_excel của scaffold cán bộ thông tin', '2013-03-04 15:58:20', '2013-03-04 15:58:20'),
(47, 'than_nhan_import_from_excel_page_title', 'Thêm mới dữ liệu từ file excel', '', 'Title trang import_from_excel của scaffold thân nhân', '2013-03-04 16:37:05', '2013-03-04 16:37:05'),
(48, 'than_nhan_show_result_page_title', 'Thêm dữ liệu từ file excel', '', 'Title trang show_result của scaffold thân nhân', '2013-03-04 16:43:31', '2013-03-04 16:43:31'),
(49, 'thuong_binh_hang_values', '1/4,2/4,3/4,4/4', '', 'Thương binh hạng - values', '2013-03-06 00:32:29', '2013-03-06 00:32:29'),
(50, 'thuong_binh_hang_desc', 'Tỷ lệ thương tật từ 81% trở lên,Tỷ lệ thương tật từ 61% trở lên,Tỷ lệ thương tật từ 41% trở lên,Tỷ lệ thương tật từ 21% trở lên', '', 'Thương binh hạng - desc', '2013-03-06 00:32:29', '2013-03-06 00:32:29'),
(51, 'Cap_bac_quan_doi', 'Binh nhì,Binh nhất,Hạ sĩ,Trung sĩ,Thượng sĩ,Thiếu úy,Trung úy,Đại úy,Thiếu tá,Trung tá,Đại tá,Thiếu tướng,Trung  tướng,Đại tướng', '', 'cấp bậc trong quân đội (Lý lịch chính trị)', '2013-03-06 00:32:29', '2013-03-06 00:32:29'),
(52, 'Nu', 'Nữ', '', 'Giá trị có dấu cho Nu', '2013-03-07 09:43:05', '2013-03-07 09:43:05'),
(53, 'let_choose_file_now', 'Hãy chọn đường dẫn đến file excel cần lưu dữ liệu trước !', '', 'Thông báo :excel_file rỗng', '2013-03-08 02:14:44', '2013-03-08 02:14:44'),
(54, 'so_yeu_ly_lich', 'SƠ YẾU LÝ LỊCH TRÍCH NGANG', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:20', '2013-03-14 12:26:20'),
(55, 'ma_cb', 'Mã cán bộ', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:20', '2013-03-14 12:26:20'),
(56, 'ho_ten', 'Họ và tên', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:20', '2013-03-14 12:26:20'),
(57, 'ten_goi_khac', 'Tên gọi khác', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:20', '2013-03-14 12:26:20'),
(58, 'gioi_tinh', 'Giới tính', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:20', '2013-03-14 12:26:20'),
(59, 'ngay_sinh', 'Ngày sinh', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:20', '2013-03-14 12:26:20'),
(60, 'noi_sinh', 'Nơi sinh', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(61, 'que_quan', 'Quê Quán', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(62, 'dan_toc', 'Dân tộc', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(63, 'ton_giao', 'Tôn giáo', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(64, 'so_cmnd', 'Số CMND', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(65, 'ngay_cap_cmnd', 'Ngày cấp CMND', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(66, 'so_BHXH', 'Số sổ BHXH', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(67, 'noi_dang_ky_ho_khau_thuong_tru', 'Nơi đăng ký hộ khẩu thường trú', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(68, 'noi_o_hien_nay', 'Nơi ở hiện nay', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(69, 'created_at', 'Ngày lập', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(70, 'updated_at', 'Ngày cập nhật', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 12:26:21', '2013-03-14 12:26:21'),
(71, 'trinh_do_pho_thong', 'Trình độ giáo dục phổ thông', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 13:39:58', '2013-03-14 13:39:58'),
(72, 'hoc_ham', 'Học hàm', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 13:39:59', '2013-03-14 13:39:59'),
(73, 'hoc_vi', 'Học vị', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 13:39:59', '2013-03-14 13:39:59'),
(74, 'trinh_do_chuyen_mon', 'Trình độ chuyên môn cao nhất', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 13:39:59', '2013-03-14 13:39:59'),
(75, 'ly_luan_chinh_tri', 'Lý luận chính trị', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 13:39:59', '2013-03-14 13:39:59'),
(76, 'quan_ly_nha_nuoc', 'Quản lý nhà nước', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 13:39:59', '2013-03-14 13:39:59'),
(77, 'ngoai_ngu', 'Ngoại ngữ', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 13:39:59', '2013-03-14 13:39:59'),
(78, 'tin_hoc', 'Tin học', '', 'Sử dụng cho export sơ yếu lý lịch', '2013-03-14 13:39:59', '2013-03-14 13:39:59');

-- --------------------------------------------------------

--
-- Table structure for table `quan_ly_nha_nuocs`
--

CREATE TABLE IF NOT EXISTS `quan_ly_nha_nuocs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trinh_do` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `quan_ly_nha_nuocs`
--

INSERT INTO `quan_ly_nha_nuocs` (`id`, `trinh_do`, `ghi_chu`, `created_at`, `updated_at`) VALUES
(1, 'Cán sự', '', '2013-03-12 16:03:50', '2013-03-12 16:03:50'),
(2, 'Chuyên viên', '', '2013-03-12 16:03:57', '2013-03-12 16:03:57'),
(3, 'Chuyên viên chính', '', '2013-03-12 16:04:10', '2013-03-12 16:04:10'),
(4, 'Chuyên viên cao cấp', '', '2013-03-12 16:04:25', '2013-03-12 16:04:25');

-- --------------------------------------------------------

--
-- Table structure for table `qua_trinh_cong_tacs`
--

CREATE TABLE IF NOT EXISTS `qua_trinh_cong_tacs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `can_bo_thong_tin_id` int(11) DEFAULT NULL,
  `don_vi_id` int(11) DEFAULT NULL,
  `chuc_vu_id` int(11) DEFAULT NULL,
  `thoi_gian_bat_dau` date DEFAULT NULL,
  `thoi_gian_ket_thuc` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `qua_trinh_cong_tacs`
--


-- --------------------------------------------------------

--
-- Table structure for table `quyet_dinhs`
--

CREATE TABLE IF NOT EXISTS `quyet_dinhs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loai_quyet_dinh_id` int(11) DEFAULT NULL,
  `so_qd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ngay_ra_qd` date DEFAULT NULL,
  `noi_dung_tom_tat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tep_tin_dinh_kem` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `quyet_dinhs`
--

INSERT INTO `quyet_dinhs` (`id`, `loai_quyet_dinh_id`, `so_qd`, `ngay_ra_qd`, `noi_dung_tom_tat`, `tep_tin_dinh_kem`, `created_at`, `updated_at`) VALUES
(1, 1, '06/2012/QĐ-BNV', '2008-08-16', 'Quyết định nâng lương cho cán bộ công chức tháng 03/2013', '1362891971.doc', '2013-03-10 05:06:11', '2013-03-13 08:47:52');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20130201023253'),
('20130201032503'),
('20130301032113'),
('20130304015203'),
('20130304020425'),
('20130304070317'),
('20130309024655'),
('20130309024807'),
('20130309024955'),
('20130309025945'),
('20130309030908'),
('20130309031120'),
('20130311020128'),
('20130311022807'),
('20130311025826'),
('20130312021154'),
('20130312031026'),
('20130312033858'),
('20130312034630'),
('20130312035353'),
('20130312162741'),
('20130312170706'),
('20130312183056'),
('20130313173300'),
('20130313173653'),
('20130313174024'),
('20130314051740'),
('20130314063410'),
('20130314082428'),
('20130314093753');

-- --------------------------------------------------------

--
-- Table structure for table `than_nhans`
--

CREATE TABLE IF NOT EXISTS `than_nhans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `can_bo_thong_tin_id` int(11) DEFAULT NULL,
  `quan_he_voi_cb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nam_sinh` int(11) DEFAULT NULL,
  `nghe_nghiep` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ho_ten` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `than_nhans`
--

INSERT INTO `than_nhans` (`id`, `can_bo_thong_tin_id`, `quan_he_voi_cb`, `nam_sinh`, `nghe_nghiep`, `created_at`, `updated_at`, `ho_ten`) VALUES
(1, 38, 'Cha', 1950, 'Làm nông', '2013-03-04 05:35:29', '2013-03-13 10:07:37', 'Huỳnh Văn Long'),
(8, 39, 'Con trai', 2007, 'Học sinh', '2013-03-04 14:27:53', '2013-03-04 16:33:43', 'Dương Ngọc Thuận'),
(9, 38, 'Em trai', 1991, 'Sinh viên', '2013-03-04 16:06:02', '2013-03-04 16:06:02', 'Huỳnh Quang Tiến'),
(10, 39, 'Cha', 1962, 'Luật sư', '2013-03-04 16:33:07', '2013-03-04 16:33:07', 'Dương Đình Dũng');

-- --------------------------------------------------------

--
-- Table structure for table `trinh_do_chuyen_mons`
--

CREATE TABLE IF NOT EXISTS `trinh_do_chuyen_mons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trinh_do` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ghi_chu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `trinh_do_chuyen_mons`
--

INSERT INTO `trinh_do_chuyen_mons` (`id`, `trinh_do`, `ghi_chu`, `created_at`, `updated_at`) VALUES
(1, 'Tiến sĩ khoa học', '', '2013-03-12 03:35:15', '2013-03-12 03:35:15'),
(2, 'Tiến sĩ', '', '2013-03-12 03:35:24', '2013-03-12 03:35:24'),
(3, 'Thạc sĩ', '', '2013-03-12 03:35:34', '2013-03-12 03:35:34'),
(4, 'Cử nhân', '', '2013-03-12 03:35:42', '2013-03-12 03:35:42'),
(5, 'Kỹ sư', '', '2013-03-12 03:35:54', '2013-03-12 03:35:54'),
(6, 'Cao đẳng', '', '2013-03-12 03:36:06', '2013-03-12 03:37:04'),
(7, 'Trung cấp', '', '2013-03-12 03:36:15', '2013-03-12 03:36:57'),
(8, 'Sơ cấp', '', '2013-03-12 03:36:26', '2013-03-12 03:36:51');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
