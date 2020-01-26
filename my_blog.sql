-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 25, 2020 at 08:51 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `my_blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `Name` text NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(11) NOT NULL,
  `Message` text NOT NULL,
  `Date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`Name`, `Email`, `Phone`, `Message`, `Date`) VALUES
('ghouse', 'ghouse@gmail.com', '9959369149', 'hi', '2020-01-22 00:51:36'),
('first post', 'firstpost@gmail.com', '223456789', 'first post', '2020-01-22 00:14:56'),
('reshma', 'reshu@gmail.com', '9052876904', 'I love you reshma', '2020-01-22 00:53:56'),
('reshma', 'reshu@gmail.com', '9052876904', 'love', '2020-01-22 01:01:06'),
('santosh', 'san@gmail.com', '888888888', 'hi', '2020-01-22 01:01:40'),
('ravi', 'ravi@gmail.com', '999999999', 'hi', '2020-01-23 11:13:15'),
('ravi', 'ravi@gmail.com', '999999999', 'hi', '2020-01-23 11:50:15'),
('Hussainsha Syed', 'hussainatphysics@gmail.com', '9000390153', 'I am Python Developer', '2020-01-23 12:30:51'),
('Hussainsha Syed', 'hussainatphysics@gmail.com', '9000390153', 'I am Python Developer', '2020-01-23 12:32:00'),
('Hussainsha Syed', 'hussainatphysics@gmail.com', '9000390153', 'I am python developer', '2020-01-23 12:32:36'),
('Hussainsha Syed', 'hussainatphysics@gmail.com', '9000390153', 'I am Py developer', '2020-01-23 12:38:38'),
('Hussainsha Syed', 'hussainatphysics@gmail.com', '9000390153', 'hi', '2020-01-23 12:46:53');

-- --------------------------------------------------------

--
-- Table structure for table `posts_blog`
--

CREATE TABLE `posts_blog` (
  `SNO` int(11) NOT NULL,
  `Title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `Content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `Date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts_blog`
--

INSERT INTO `posts_blog` (`SNO`, `Title`, `tagline`, `slug`, `Content`, `img_file`, `Date`) VALUES
(1, 'This is my First Article', 'first hit', 'first-post', 'Imagination is more important than everything, except imagination....\r\n\r\nBy Albert Einstein and Hussainsha ', 'Img7', '2020-01-25 12:34:25'),
(3, 'Einstein Bio', 'third hit', 'three-post', 'Albert Einstein (/ˈaɪnstaɪn/ EYEN-styne;[4] German: [ˈalbɛʁt ˈʔaɪnʃtaɪn] (About this soundlisten); 14 March 1879 – 18 April 1955) was a German-born theoretical physicist[5] who developed the theory of relativity, one of the two pillars of modern physics (alongside quantum mechanics).[3][6]:274 His work is also known for its influence on the philosophy of science.[7][8] He is best known to the general public for his mass–energy equivalence formula {\\displaystyle E=mc^{2}}E = mc^2, which has been dubbed \"the world\'s most famous equation\".[9] He received the 1921 Nobel Prize in Physics \"for his services to theoretical physics, and especially for his discovery of the law of the photoelectric effect\",[10] a pivotal step in the development of quantum theory.\r\n\r\nNear the beginning of his career, Einstein thought that Newtonian mechanics was no longer enough to reconcile the laws of classical mechanics with the laws of the electromagnetic field. This led him to develop his special theory of relativity during his time at the Swiss Patent Office in Bern (1902–1909). He subsequently realized that the principle of relativity could be extended to gravitational fields, and published a paper on general relativity in 1916 introducing his theory of gravitation. He continued to deal with problems of statistical mechanics and quantum theory, which led to his explanations of particle theory and the motion of molecules. He also investigated the thermal properties of light and the quantum theory of radiation, the basis of laser, which laid the foundation of the photon theory of light. In 1917, he applied the general theory of relativity to model the structure of the universe.[11][12]', '', '2020-01-23 17:32:16'),
(4, 'Newton\'s Laws of Motion - NASA', 'Newton', 'four-post', 'Newton\'s first law states that every object will remain at rest or in uniform motion in a straight line unless compelled to change its state by the action of an external force. ... The third law states that for every action (force) in nature there is an equal and opposite reaction', 'Img', '2020-01-25 00:34:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts_blog`
--
ALTER TABLE `posts_blog`
  ADD PRIMARY KEY (`SNO`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts_blog`
--
ALTER TABLE `posts_blog`
  MODIFY `SNO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
