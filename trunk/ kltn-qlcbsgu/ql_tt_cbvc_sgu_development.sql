-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 04, 2013 at 02:20 PM
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
-- Table structure for table `can_bo_li_lich_cts`
--
-- Creation: Mar 04, 2013 at 09:16 AM
--

DROP TABLE IF EXISTS `can_bo_li_lich_cts` ;
DROP TABLE IF EXISTS `can_bo_thong_tins` ;
DROP TABLE IF EXISTS `casein_users` ;



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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `can_bo_li_lich_cts`
--


-- --------------------------------------------------------

--
-- Table structure for table `can_bo_thong_tins`
--
-- Creation: Feb 01, 2013 at 10:25 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=46 ;

--
-- Dumping data for table `can_bo_thong_tins`
--

INSERT INTO `can_bo_thong_tins` (`id`, `ma_cb`, `ho_ten`, `ten_goi_khac`, `gioi_tinh`, `hinh_anh`, `ngay_sinh`, `noi_sinh`, `que_quan`, `dan_toc`, `ton_giao`, `so_cmnd`, `ngay_cap_cmnd`, `so_BHXH`, `noi_dang_ky_ho_khau_thuong_tru`, `noi_o_hien_nay`, `tep_tin_dinh_kem`, `is_deleted`, `created_at`, `updated_at`) VALUES
(38, '10002', 'Huỳnh Quang Thông', 'Thông', 1, NULL, '1990-02-02', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '225500234', '2013-02-02', '214555', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(39, '10004', 'Dương Đình Dũng', 'Dũng Dương', 1, NULL, '1994-02-21', 'Cam Ranh, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Thiên Chúa', '2255001324', '2007-02-21', '2145534', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(40, '10005', 'Huỳnh Nhật Thảo', 'Huỳnh Thảo', 1, NULL, '1997-02-21', 'Cam Ranh, Khánh Hòa', 'Nha Trang, Khanh Hòa', 'Khơ Me', 'Thiên Chúa', '2255001325', '1999-02-21', '1233456', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(41, '10006', 'Mai Trí Dũng', 'Mai Trí Dũng', 1, NULL, '1995-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '22550013256', '1977-02-21', '214555', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(42, '10007', 'Hoàng Kim Bảo', 'Hoàng Kim Bảo', 1, NULL, '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Khơ Me', 'Phật Giáo', '2255001327', '2008-02-21', '214555', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-03 07:36:56'),
(43, '10008', 'Lê Xuân Thân', 'Lê Xuân Thân', 1, NULL, '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '22550013209', '2006-02-21', '1233455', 'Nha Trang, Khánh Hòa', 'Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(44, '10011', 'Mai Thị Hồng', 'Mai Thị Hồng', 0, NULL, '1994-02-21', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Kinh', 'Phật Giáo', '2255001377', '1997-02-21', '2145534', 'Nha Trang, Khanh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-01 15:44:21', '2013-03-01 15:44:21'),
(45, '10003', 'Mai Trí Thiện', 'Mai Trí Thiện', 1, NULL, '1991-07-05', 'Nha Trang, Khánh Hòa', 'Nha Trang, Khánh Hòa', 'Khơ Me', 'Phật Giáo', '225502174', '2013-02-02', '1233456', 'Nha Trang, Khánh Hòa', '994B/33E Huỳnh Tấn Phát, Quận 7, TP.HCM', NULL, 0, '2013-03-02 11:46:20', '2013-03-02 11:46:20');

-- --------------------------------------------------------

--
-- Table structure for table `casein_users`
--
-- Creation: Feb 01, 2013 at 09:35 AM
--
DROP TABLE IF EXISTS `casein_users` ;
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
(1, 'admin', 'Admin', 'you@yourdomain.com', 0, 'e8d4bde49567973f43e33d8c7eb73167c43859b9ed4dc4f9891d345bd07222ccb3860cd38066683ab6461b54421505a39392be132bb51c7b7e2f98b6bc5bd1c0', 'sWR8MdfPXYCVTu5FIwK', '5d6b12d3c70a37d66253860082aa89559d9edd42b5397e9f6d98073c50319744ff661075909001e92cd4e8b87ab867e9b19c73e8445300046f50107285d094ad', 'PTWT227GhIFM4j3LWOb', '6mSLvd4drezsgZUL4Ba', 28, 0, '2013-03-04 07:17:02', '2013-03-04 01:07:38', '2013-03-04 01:01:37', '127.0.0.1', '127.0.0.1', 'Hanoi', '2013-02-01 02:38:48', '2013-03-04 07:17:02'),
(2, 'maitrithien', 'Mai Trí Thiện', 'maitrithien@gmail.com', 10, 'c1f6b60224c5969a3ab7562dc5a6db88c6d4a031aaa5917aeffb88ce75ab48563dd6c910ca89e767ba22d8b4ea83299d4d7d5338bd25b3b699086013b235cb50', 'mHv2EgbmTwcHV3Yfidkr', '1e957968c8c4d6938e30f03213a0f48642bbe7c7404c1834d68474989d26b3492df2f3680813daf7e82aa60982e6c7f227422e6a97390c24754eda177e6e1814', 'jH0voDowLspNC5ngnobK', 'MkgwFYUbsRbHHEuwAnwv', 1, 0, '2013-02-01 03:49:31', '2013-02-01 03:49:18', NULL, '127.0.0.1', NULL, 'Hanoi', '2013-02-01 03:48:54', '2013-03-03 06:44:21');

-- --------------------------------------------------------

--
-- Table structure for table `params`
--
-- Creation: Mar 01, 2013 at 10:22 AM
--
DROP TABLE IF EXISTS `params` ;
CREATE TABLE IF NOT EXISTS `params` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `options` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=41 ;

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
(40, 'select_quan_he_cb', 'Cha,Mẹ,Anh,Chị,Em gái,Em trai,Vợ,Chồng,Con trai,Con gái', '', 'Chuỗi giá trị cho select quan hệ gia đình cán bộ', '2013-03-04 05:50:35', '2013-03-04 05:56:33');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--
-- Creation: Feb 01, 2013 at 09:35 AM
--
DROP TABLE IF EXISTS `schema_migrations` ;
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
('20130304070317');

-- --------------------------------------------------------

--
-- Table structure for table `than_nhans`
--
-- Creation: Mar 04, 2013 at 08:53 AM
--
DROP TABLE IF EXISTS `than_nhans` ;
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `than_nhans`
--

INSERT INTO `than_nhans` (`id`, `can_bo_thong_tin_id`, `quan_he_voi_cb`, `nam_sinh`, `nghe_nghiep`, `created_at`, `updated_at`, `ho_ten`) VALUES
(1, 38, 'Cha', 1950, 'Làm nông', '2013-03-04 05:35:29', '2013-03-04 07:07:46', 'Huỳnh Văn Long');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
