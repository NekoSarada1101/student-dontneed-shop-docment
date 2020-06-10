-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- ホスト: localhost
-- 生成日時: 2020 年 6 月 10 日 12:22
-- サーバのバージョン： 10.3.15-MariaDB
-- PHP のバージョン: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `student_dontneed_shop`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `admin`
--

CREATE TABLE `admin` (
  `admin_mail` varchar(30) NOT NULL,
  `admin_name` varchar(20) NOT NULL,
  `admin_password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `cart`
--

CREATE TABLE `cart` (
  `member_mail` varchar(30) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `genre`
--

CREATE TABLE `genre` (
  `genre_code` int(4) NOT NULL,
  `genre_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `member`
--

CREATE TABLE `member` (
  `member_mail` varchar(30) NOT NULL,
  `member_name` varchar(20) NOT NULL,
  `member_password` varchar(128) NOT NULL,
  `credit_card` int(16) NOT NULL,
  `address` varchar(50) NOT NULL,
  `postal_code` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(30) NOT NULL,
  `price` int(16) NOT NULL,
  `image` blob DEFAULT NULL,
  `product_explanation` varchar(400) NOT NULL,
  `is_sold` tinyint(1) NOT NULL DEFAULT 0,
  `admin_mail` varchar(30) NOT NULL,
  `genre_code` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `purchase_details`
--

CREATE TABLE `purchase_details` (
  `purchase_id` int(11) NOT NULL,
  `member_mail` varchar(30) NOT NULL,
  `product_id` int(11) NOT NULL,
  `purchase_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_mail`);

--
-- テーブルのインデックス `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`member_mail`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- テーブルのインデックス `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`genre_code`);

--
-- テーブルのインデックス `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`member_mail`);

--
-- テーブルのインデックス `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `admin_mail` (`admin_mail`),
  ADD KEY `genre_code` (`genre_code`);

--
-- テーブルのインデックス `purchase_details`
--
ALTER TABLE `purchase_details`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `member_mail` (`member_mail`),
  ADD KEY `product_id` (`product_id`);

--
-- ダンプしたテーブルのAUTO_INCREMENT
--

--
-- テーブルのAUTO_INCREMENT `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- テーブルのAUTO_INCREMENT `purchase_details`
--
ALTER TABLE `purchase_details`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`member_mail`) REFERENCES `member` (`member_mail`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- テーブルの制約 `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`admin_mail`) REFERENCES `admin` (`admin_mail`),
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`genre_code`) REFERENCES `genre` (`genre_code`);

--
-- テーブルの制約 `purchase_details`
--
ALTER TABLE `purchase_details`
  ADD CONSTRAINT `purchase_details_ibfk_2` FOREIGN KEY (`member_mail`) REFERENCES `member` (`member_mail`),
  ADD CONSTRAINT `purchase_details_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
