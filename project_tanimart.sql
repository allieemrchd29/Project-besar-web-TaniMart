-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2026 at 12:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_tanimart`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `locality` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `zip` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'home',
  `isdefault` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `name`, `phone`, `locality`, `address`, `city`, `state`, `country`, `landmark`, `zip`, `type`, `isdefault`, `created_at`, `updated_at`) VALUES
(1, 2, 'yayaa', '1234567890', 'Jl. H Suwardi', '123', 'Karawang', 'Jawa Barat', 'Indonesia', 'Near RPM', '123456', 'home', 1, '2025-12-29 06:33:23', '2025-12-29 06:33:23');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `image`, `parent_id`, `created_at`, `updated_at`) VALUES
(7, 'Sayuran', 'sayuran', '1767312430.jpg', NULL, '2025-12-28 00:21:55', '2026-01-01 17:07:11'),
(8, 'Buah-buahan', 'buah-buahan', '1767312272.jpg', NULL, '2025-12-28 00:22:26', '2026-01-01 17:04:41'),
(9, 'Umbi-umbian', 'umbi-umbian', '1767312617.jpg', NULL, '2025-12-28 00:22:59', '2026-01-01 17:10:19'),
(10, 'Biji-bijian', 'biji-bijian', '1767312790.jpg', NULL, '2025-12-28 00:23:23', '2026-01-01 17:13:11'),
(11, 'Rempah-rempah', 'rempah-rempah', '1767312634.jpg', NULL, '2025-12-28 00:23:59', '2026-01-01 17:10:35');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `phone`, `comment`, `created_at`, `updated_at`) VALUES
(3, 'yayaa', 'yaya@gmail.com', '1234567899', 'cek123', '2025-12-31 00:57:49', '2025-12-31 00:57:49');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` enum('fixed','percent') NOT NULL,
  `value` decimal(8,2) NOT NULL,
  `cart_value` decimal(8,2) NOT NULL,
  `expiry_date` date NOT NULL DEFAULT cast(current_timestamp() as date),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `type`, `value`, `cart_value`, `expiry_date`, `created_at`, `updated_at`) VALUES
(1, 'OFF5', 'fixed', 10.00, 50.00, '2025-12-31', '2025-12-28 18:35:12', '2025-12-29 19:25:59'),
(2, 'OFF10', 'fixed', 10.00, 100.00, '2025-12-31', '2025-12-28 18:37:31', '2025-12-28 20:39:53');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `labels`
--

CREATE TABLE `labels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `labels`
--

INSERT INTO `labels` (`id`, `name`, `slug`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Premium', 'premium', '1767313098.jpg', '2025-12-26 03:35:21', '2026-01-01 17:18:19'),
(5, 'Reguler', 'reguler', '1767313328.jpg', '2025-12-27 05:35:36', '2026-01-01 17:22:08');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(13, '0001_01_01_000000_create_users_table', 1),
(14, '0001_01_01_000001_create_cache_table', 1),
(15, '0001_01_01_000002_create_jobs_table', 1),
(16, '2025_12_26_080051_create_labels_table', 2),
(17, '2025_12_26_144145_create_categories_table', 3),
(18, '2025_12_27_015916_create_products_table', 4),
(19, '2025_12_29_003808_create_coupons_table', 5),
(20, '2025_12_29_061517_create_orders_table', 6),
(21, '2025_12_29_061544_create_order_items_table', 6),
(22, '2025_12_29_061602_create_addresses_table', 6),
(23, '2025_12_29_061622_create_transactions_table', 6),
(24, '2025_12_30_071649_create_slides_table', 7),
(25, '2025_12_31_012507_create_month_names_table', 8),
(26, '2025_12_31_054431_create_contacts_table', 9);

-- --------------------------------------------------------

--
-- Table structure for table `month_names`
--

CREATE TABLE `month_names` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `month_names`
--

INSERT INTO `month_names` (`id`, `name`) VALUES
(1, 'January'),
(2, 'February'),
(3, 'March'),
(4, 'April'),
(5, 'May'),
(6, 'June'),
(7, 'July'),
(8, 'August'),
(9, 'September'),
(10, 'October'),
(11, 'November'),
(12, 'December');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `locality` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `zip` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'home',
  `status` enum('ordered','delivered','canceled') NOT NULL DEFAULT 'ordered',
  `is_shipping_different` tinyint(1) NOT NULL DEFAULT 0,
  `delivered_date` date DEFAULT NULL,
  `canceled_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `subtotal`, `discount`, `tax`, `total`, `name`, `phone`, `locality`, `address`, `city`, `state`, `country`, `landmark`, `zip`, `type`, `status`, `is_shipping_different`, `delivered_date`, `canceled_date`, `created_at`, `updated_at`) VALUES
(15, 2, 53.00, 10.00, 1.59, 54.59, 'yayaa', '1234567890', 'Jl. H Suwardi', '123', 'Karawang', 'Jawa Barat', 'Indonesia', 'Near RPM', '123456', 'home', 'canceled', 0, NULL, '2025-12-30', '2025-12-29 19:26:28', '2025-12-29 23:14:58'),
(16, 2, 18.00, 0.00, 0.54, 18.54, 'yayaa', '1234567890', 'Jl. H Suwardi', '123', 'Karawang', 'Jawa Barat', 'Indonesia', 'Near RPM', '123456', 'home', 'delivered', 0, '2025-12-30', NULL, '2025-12-29 21:03:08', '2025-12-29 22:38:09'),
(17, 2, 45.00, 0.00, 1.35, 46.35, 'yayaa', '1234567890', 'Jl. H Suwardi', '123', 'Karawang', 'Jawa Barat', 'Indonesia', 'Near RPM', '123456', 'home', 'canceled', 0, NULL, '2025-12-30', '2025-12-29 23:53:48', '2025-12-29 23:57:19'),
(18, 2, 90.00, 0.00, 2.70, 92.70, 'yayaa', '1234567890', 'Jl. H Suwardi', '123', 'Karawang', 'Jawa Barat', 'Indonesia', 'Near RPM', '123456', 'home', 'canceled', 0, NULL, '2025-12-30', '2025-12-30 00:04:44', '2025-12-30 00:05:08'),
(19, 2, 18.00, 0.00, 0.54, 18.54, 'yayaa', '1234567890', 'Jl. H Suwardi', '123', 'Karawang', 'Jawa Barat', 'Indonesia', 'Near RPM', '123456', 'home', 'ordered', 0, NULL, NULL, '2025-12-31 05:37:40', '2025-12-31 05:37:40'),
(20, 2, 12.00, 0.00, 0.36, 12.36, 'yayaa', '1234567890', 'Jl. H Suwardi', '123', 'Karawang', 'Jawa Barat', 'Indonesia', 'Near RPM', '123456', 'home', 'ordered', 0, NULL, NULL, '2026-01-02 05:31:28', '2026-01-02 05:31:28');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `options` longtext DEFAULT NULL,
  `rstatus` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `product_id`, `order_id`, `price`, `quantity`, `options`, `rstatus`, `created_at`, `updated_at`) VALUES
(13, 4, 15, 45.00, 1, NULL, 0, '2025-12-29 19:26:28', '2025-12-29 19:26:28'),
(14, 3, 15, 18.00, 1, NULL, 0, '2025-12-29 19:26:28', '2025-12-29 19:26:28'),
(15, 3, 16, 18.00, 1, NULL, 0, '2025-12-29 21:03:08', '2025-12-29 21:03:08'),
(16, 4, 17, 45.00, 1, NULL, 0, '2025-12-29 23:53:48', '2025-12-29 23:53:48'),
(17, 4, 18, 45.00, 2, NULL, 0, '2025-12-30 00:04:44', '2025-12-30 00:04:44'),
(18, 3, 19, 18.00, 1, NULL, 0, '2025-12-31 05:37:40', '2025-12-31 05:37:40'),
(19, 7, 20, 12.00, 1, NULL, 0, '2026-01-02 05:31:28', '2026-01-02 05:31:28');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `regular_price` decimal(8,2) NOT NULL,
  `sale_price` decimal(8,2) DEFAULT NULL,
  `SKU` varchar(255) NOT NULL,
  `stock_status` enum('instock','lowstock','outofstock') NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `quantity` bigint(20) UNSIGNED NOT NULL DEFAULT 20,
  `image` varchar(255) DEFAULT NULL,
  `images` text DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `label_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `slug`, `short_description`, `description`, `regular_price`, `sale_price`, `SKU`, `stock_status`, `featured`, `quantity`, `image`, `images`, `category_id`, `label_id`, `created_at`, `updated_at`) VALUES
(3, 'Tomat Segar premium /kg', 'tomat-segar-premium-kg', 'Tomat segar dengan rasa alami dan kandungan air seimbang.', 'Tomat segar pilihan dengan tingkat kematangan yang pas. Cocok digunakan sebagai bahan masakan, sambal, saus, maupun dikonsumsi langsung sebagai pelengkap makanan sehari-hari.', 20.00, 18.00, 'VEG-003', 'instock', 1, 20, '1766839012.jpg', '1767323846_1.jpeg', 7, 1, '2025-12-27 05:36:52', '2026-01-01 20:17:27'),
(4, 'Bawang merah/ bawang putih promo /kg', 'bawang-merah-bawang-putih-promo-kg', 'bawang asli brebes', 'bawang asli brebes', 60.00, 45.00, 'RPH-001', 'instock', 1, 20, '1766845312.jpg', '1766845312_1.jpg', 11, 5, '2025-12-27 07:21:53', '2026-01-01 20:15:02'),
(6, 'Bayam Segar /250gr', 'bayam-segar-250gr', 'Fresh spinach harvested daily.', 'Bayam segar yang dipanen langsung dari petani lokal pilihan setiap hari. Sayuran ini memiliki kandungan nutrisi yang tinggi seperti zat besi, vitamin A, dan vitamin C. Bayam cocok diolah menjadi berbagai masakan rumahan seperti sayur bening, tumisan, maupun campuran makanan sehat lainnya. Produk ini telah melalui proses sortasi dan pembersihan sehingga lebih higienis dan siap diolah.', 5.00, 4.50, 'VEG-001', 'instock', 1, 100, '1767318892.jpg', '1767318892_1.jpg', 7, 5, '2026-01-01 18:54:53', '2026-01-01 18:54:53'),
(7, 'Wortel (carrot) premium /kg', 'wortel-carrot-premium-kg', 'Wortel segar berkualitas premium dan kaya nutrisi.', 'Wortel segar berkualitas premium dengan warna oranye cerah dan tekstur renyah. Dipanen dari lahan pertanian terpercaya dan langsung didistribusikan untuk menjaga kesegarannya. Wortel kaya akan beta karoten yang baik untuk kesehatan mata dan daya tahan tubuh. Cocok digunakan untuk sayur sup, tumisan, jus, maupun olahan makanan sehat lainnya.', 14.00, 12.00, 'VEG-002', 'instock', 1, 100, '1767323597.jpg', '1767323597_1.jpg', 7, 1, '2026-01-01 20:13:18', '2026-01-01 20:13:18'),
(48, 'Pisang Sunfride /500gr', 'pisang-sunfride-500gr', 'Pisang segar manis alami', 'Pisang segar hasil panen petani lokal, cocok dikonsumsi langsung maupun sebagai bahan olahan', 25.00, 19.00, 'FRT-001', 'instock', 1, 100, '1767482557.jpg', '1767482557_1.jpg', 8, 1, '2026-01-03 16:22:45', '2026-01-03 16:22:45'),
(49, 'Apel Fresh /1kg', 'apel-fresh-1kg', 'Apel segar premium', 'Apel berkualitas premium dengan rasa segar dan tekstur renyah. Cocok untuk konsumsi harian.', 45.00, 40.00, 'FRT-002', 'instock', 1, 100, '1767482797.jpg', '1767482797_1.jpg', 8, 1, '2026-01-03 16:26:38', '2026-01-03 16:49:34'),
(50, 'Beras Putih Premium /Liter', 'beras-putih-premium-liter', 'Beras putih kualitas premium.', 'Beras pilihan dengan bulir utuh dan bersih. Menghasilkan nasi pulen.', 15.00, 12.00, 'GRN-001', 'instock', 1, 300, '1767483049.jpg', '1767483049_1.jpg', 10, 1, '2026-01-03 16:30:50', '2026-01-03 16:30:50'),
(51, 'Kacang Kedelai Lokal Berkualitas /500gr', 'kacang-kedelai-lokal-berkualitas-500gr', 'Kedelai lokal berkualitas', 'Kedelai bersih dan kering, cocok untuk bahan tahu, tempe, dan olahan lainnya.', 15.00, 14.00, 'GRN-002', 'instock', 0, 300, '1767483211.jpg', '1767483211_1.jpg', 10, 5, '2026-01-03 16:33:32', '2026-01-03 16:33:32'),
(56, 'Kentang /kg', 'kentang-kg', 'Kentang segar serbaguna', 'Kentang segar pilihan yang cocok untuk sup, tumisan, dan berbagai olahan makanan.', 35.00, 33.00, 'UMB-001', 'instock', 0, 100, '1767483414.jpg', '1767483414_1.jpg', 9, 5, '2026-01-03 16:36:55', '2026-01-03 16:36:55'),
(57, 'Ubji Jalar Ungu /kg', 'ubji-jalar-ungu-kg', 'Ubi jalar ungu manis alami.', 'Ubi jalar ungu segar dengan rasa manis alami dan tekstur lembut. Cocok direbus atau dijadikan olahan lain.', 15.00, 13.00, 'UMB-002', 'instock', 1, 100, '1767483555.jpg', '1767483555_1.jpg', 9, 5, '2026-01-03 16:39:15', '2026-01-03 16:45:09'),
(58, 'Jahe segar /500gr', 'jahe-segar-500gr', 'Jahe segar aromatik', 'Jahe segar dengan aroma kuat, cocok untuk bumbu masakan dan minuman herbal.', 16.00, 15.00, 'RPH-003', 'instock', 0, 200, '1767483895.jpg', '1767483895_1.jpg', 11, 1, '2026-01-03 16:44:55', '2026-01-03 16:44:55'),
(59, 'Kunyit segar berkualitas /500gr', 'kunyit-segar-berkualitas-500gr', 'Kunyit segar berkualitas', 'Kunyit segar dengan warna kuning alami, sering digunakan sebagai bumbu masakan tradisional.', 9.00, 7.00, 'RPH-004', 'instock', 1, 500, '1767484084.png', '1767484084_1.png', 11, 5, '2026-01-03 16:48:06', '2026-01-03 16:49:22');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('WMa5ddkVQ6wl1r7RZiPto7nKcMRAYcK1BW5ROPLL', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiQVh5aHdpTHFRcDlJM1VzekRyNTEzVmRybzdtRWZhaUo5ZXdDVDRCayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7czoxMDoiaG9tZS5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzY3NDgxMzU0O319', 1767484185);

-- --------------------------------------------------------

--
-- Table structure for table `slides`
--

CREATE TABLE `slides` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tagline` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slides`
--

INSERT INTO `slides` (`id`, `tagline`, `title`, `subtitle`, `link`, `image`, `status`, `created_at`, `updated_at`) VALUES
(4, 'TANIMART', 'Premium Products Available', 'also regular product', 'http://127.0.0.1:8000/', '1767314164.png', '1', '2025-12-30 08:37:19', '2026-01-01 17:37:38'),
(5, 'TANIMART', 'Directly from Local Farmers', 'fresh', 'http://127.0.0.1:8000/', '1767313830.jpg', '1', '2025-12-30 08:53:03', '2026-01-01 17:37:55');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `mode` enum('cod','card','paypal') NOT NULL,
  `status` enum('pending','approved','declined','refunded') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `order_id`, `mode`, `status`, `created_at`, `updated_at`) VALUES
(6, 2, 15, 'paypal', 'pending', '2025-12-29 19:26:28', '2025-12-29 19:26:28'),
(7, 2, 16, 'cod', 'approved', '2025-12-29 21:03:08', '2025-12-29 22:38:10'),
(8, 2, 17, 'card', 'pending', '2025-12-29 23:53:48', '2025-12-29 23:53:48'),
(9, 2, 18, 'paypal', 'pending', '2025-12-30 00:04:44', '2025-12-30 00:04:44'),
(10, 2, 19, 'card', 'pending', '2025-12-31 05:37:40', '2025-12-31 05:37:40'),
(11, 2, 20, 'paypal', 'pending', '2026-01-02 05:31:28', '2026-01-02 05:31:28');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` varchar(255) NOT NULL DEFAULT 'USR' COMMENT 'ADM for admin and USR for user or Customer',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `mobile`, `email_verified_at`, `password`, `user_type`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'AdminTaniMart', 'admin@gmail.com', '1234567890', NULL, '$2y$12$agavGwywk6u.72kmvZrLluhrL.MQaLvHzuam302LtqV//y1XX7tAS', 'ADM', NULL, '2025-12-25 20:04:52', '2025-12-25 20:04:52'),
(2, 'UserTaniMart', 'user@gmail.com', '0987654321', NULL, '$2y$12$ksNL.BCbRcx8o3BkoohTjOItnJiBeFkcSGHD8iYfwSzj.jM5H1mha', 'USR', NULL, '2025-12-25 20:07:04', '2025-12-25 20:07:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_user_id_foreign` (`user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `labels`
--
ALTER TABLE `labels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `labels_slug_unique` (`slug`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `month_names`
--
ALTER TABLE `month_names`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_label_id_foreign` (`label_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `slides`
--
ALTER TABLE `slides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`),
  ADD KEY `transactions_order_id_foreign` (`order_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `labels`
--
ALTER TABLE `labels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `month_names`
--
ALTER TABLE `month_names`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `slides`
--
ALTER TABLE `slides`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_label_id_foreign` FOREIGN KEY (`label_id`) REFERENCES `labels` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
