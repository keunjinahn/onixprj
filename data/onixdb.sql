-- --------------------------------------------------------
-- 호스트:                          localhost
-- 서버 버전:                        10.6.7-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- fireprjdb 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `onixdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `onixdb`;

-- 테이블 fireprjdb.customer_tbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer_tbl` (
  `customer_idx` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `customer_tel` varchar(15) NOT NULL,
  `customer_address` varchar(1000) NOT NULL,
  PRIMARY KEY (`customer_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 fireprjdb.customer_tbl:~3 rows (대략적) 내보내기
INSERT INTO `customer_tbl` (`customer_idx`, `customer_name`, `customer_tel`, `customer_address`) VALUES
	(1, '뉴럴테크', '041-1234-1234', '충청남도 천안시 불당동 12번지'),
	(2, '시성모바일', '010-3353-9470', '경기도 부천시 상동 134'),
	(3, '3311111', '3311111111', '3311111111111');

-- 테이블 fireprjdb.event_log_tbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `event_log_tbl` (
  `event_log_idx` bigint(20) NOT NULL AUTO_INCREMENT,
  `fk_customer_idx` int(11) unsigned NOT NULL DEFAULT 0,
  `event_id` int(11) unsigned NOT NULL DEFAULT 0,
  `event_idx` int(11) unsigned NOT NULL DEFAULT 0,
  `receiver_type` int(11) unsigned NOT NULL DEFAULT 0,
  `receiver_id` int(11) unsigned NOT NULL DEFAULT 0,
  `system_id` int(11) unsigned NOT NULL DEFAULT 0,
  `repeater_id` int(11) unsigned NOT NULL DEFAULT 0,
  `sensor_id` int(11) unsigned NOT NULL DEFAULT 0,
  `sensor_value` varchar(50) NOT NULL DEFAULT '0',
  `inout_id` int(11) unsigned NOT NULL DEFAULT 0,
  `event_datetime` datetime NOT NULL,
  PRIMARY KEY (`event_log_idx`) USING BTREE,
  UNIQUE KEY `event_log_idx_UNIQUE` (`event_log_idx`) USING BTREE,
  KEY `fk_customer_idx` (`fk_customer_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 fireprjdb.event_log_tbl:~0 rows (대략적) 내보내기

-- 테이블 fireprjdb.event_tbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `event_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_idx` char(12) NOT NULL,
  `system_id_c` varchar(50) NOT NULL,
  `repeater_id_c` varchar(50) NOT NULL DEFAULT '',
  `sensor_id_c` varchar(50) NOT NULL DEFAULT '',
  `sensor_value_c` varchar(50) NOT NULL DEFAULT '',
  `inout_id_c` varchar(50) NOT NULL DEFAULT '',
  `event_desc` varchar(50) NOT NULL DEFAULT '',
  `event_category` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 fireprjdb.event_tbl:~241 rows (대략적) 내보내기
INSERT INTO `event_tbl` (`id`, `event_idx`, `system_id_c`, `repeater_id_c`, `sensor_id_c`, `sensor_value_c`, `inout_id_c`, `event_desc`, `event_category`) VALUES
	(1, '1', '0', '0', '0', '0', '0', '교류 전원 ON', '고장'),
	(2, '2', '0', '0', '0', '0', '0', '교류 전원 OFF/예비전원 ON', '고장'),
	(3, '3', '0', '0', '0', '0', '0', '예비전원 이상', '고장'),
	(4, '4', '0', '0', '0', '0', '0', '예비전원 정상', '고장'),
	(5, '5', '0', '0', '0', '0', '0', '예비전원시험SW ON', '상태'),
	(6, '6', '0', '0', '0', '0', '0', '예비전원시험SW OFF', '상태'),
	(7, '7', '0', '0', '0', '0', '0', '주경종정지SW ON', '상태'),
	(8, '8', '0', '0', '0', '0', '0', '주경종정지SW OFF', '상태'),
	(9, '9', '0', '0', '0', '0', '0', '지구경종정지SW ON', '상태'),
	(10, '10', '0', '0', '0', '0', '0', '지구경종정지SW OFF', '상태'),
	(11, '11', '0', '0', '0', '0', '0', '부저정지SW ON', '상태'),
	(12, '12', '0', '0', '0', '0', '0', '부저정지SW OFF', '상태'),
	(13, '13', '0', '0', '0', '0', '0', '수동통신점검 ON', '상태'),
	(14, '14', '0', '0', '0', '0', '0', '수동통신점검 OFF', '상태'),
	(15, '15', '0', '0', '0', '0', '0', '동작시험SW ON', '상태'),
	(16, '16', '0', '0', '0', '0', '0', '동작시험SW OFF', '상태'),
	(17, '17', '0', '0', '0', '0', '0', '복구SW ON/OFF', '상태'),
	(18, '18', '0', '0', '0', '0', '0', '자동통신점검 ON', '상태'),
	(19, '19', '0', '0', '0', '0', '0', '자동통신점검 OFF', '상태'),
	(20, '21', '0', '0', '0', '0', '0', '화재대표출력 ON', '상태'),
	(21, '22', '0', '0', '0', '0', '0', '화재대표출력 OFF', '상태'),
	(22, '23', '0', '0', '0', '0', '0', '주경종출력 ON', '상태'),
	(23, '24', '0', '0', '0', '0', '0', '주경종출력 OFF', '상태'),
	(24, '25', '0', '0', '0', '0', '0', '지구경종출력 ON', '상태'),
	(25, '26', '0', '0', '0', '0', '0', '지구경종출력 OFF', '상태'),
	(26, '27', '0', '0', '0', '0', '0', '부저출력 ON', '상태'),
	(27, '28', '0', '0', '0', '0', '0', '부저출력 OFF', '상태'),
	(28, '29', '0', '1~24', '0', '0', '0', '중계기 - 휴즈정상', '고장'),
	(29, '29', '0', '1~24', '2', '0', '0', '중계기 - 예비전원정상', '고장'),
	(30, '29', '0', '1~24', '4', '0', '0', '중계기 - AC Power ON', '고장'),
	(31, '30', '0', '1~24', '0', '0', '0', '중계기 - 휴즈단선', '고장'),
	(32, '30', '0', '1~24', '2', '0', '0', '중계기 - 예비전원이상', '고장'),
	(33, '30', '0', '1~24', '4', '0', '0', '중계기 - AC Power OFF', '고장'),
	(34, '31', '0', '1~24', '0', '0', '0', '중계기 - 발신기 회로단선', '고장'),
	(35, '32', '0', '1~24', '1~24', '0', '0', '중계기 - 연기감지기 등록', '상태'),
	(36, '34', '0', '1~24', '1~24', '0', '0', '중계기 - 연기감지기 등록해제', '상태'),
	(37, '35', '0', '1~24', '1~24', '0', '0', '중계기 - 연기감지기 동작', '화재'),
	(38, '36', '0', '1~24', '1~24', '0', '0', '중계기 - 연기감지기 복구', '화재'),
	(39, '37', '0', '1~24', '0', '0', '0', '중계기 - 발신기 동작', '화재'),
	(40, '38', '0', '1~24', '0', '0', '0', '중계기 - 발신기 정상', '화재'),
	(41, '39', '0', '1~24', '0', '0', '0', '중계기 - 통신 이상', '고장'),
	(42, '40', '0', '1~24', '0', '0', '0', '중계기 - 통신 정상', '고장'),
	(43, '41', '0', '1~24', '1~24', '0', '0', '중계기 - 연기감지기 통신이상', '고장'),
	(44, '42', '0', '1~24', '1~24', '0', '0', '중계기 - 연기감지기 통신정상', '고장'),
	(45, '43', '0', '1~24', '1~24', '0', '0', '중계기 - 연기감지기 Low Battery', '고장'),
	(46, '44', '0', '1~24', '1~24', '0', '0', '중계기 - 연기감지기 Battery Normal', '고장'),
	(47, '50', '0', '1~24', '1~24', '0', '0', '중계기 - 열감지기 등록', '상태'),
	(48, '51', '0', '1~24', '1~24', '0', '0', '중계기 - 열감지기 등록해제', '상태'),
	(49, '52', '0', '1~24', '1~24', '0', '0', '중계기 - 열감지기 동작', '화재'),
	(50, '53', '0', '1~24', '1~24', '0', '0', '중계기 - 열감지기 복구', '화재'),
	(51, '54', '0', '1~24', '1~24', '0', '0', '중계기 - 열감지기 통신이상', '고장'),
	(52, '55', '0', '1~24', '1~24', '0', '0', '중계기 - 열감지기 통신정상', '고장'),
	(53, '56', '0', '1~24', '1~24', '0', '0', '중계기 - 열감지기 Low Battery', '고장'),
	(54, '57', '0', '1~24', '1~24', '0', '0', '중계기 - 열감기 Battery Normal', '고장'),
	(55, '60', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 등록', '상태'),
	(56, '61', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 등록해제', '상태'),
	(57, '62', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 연기동작', '화재'),
	(58, '63', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 연기복구', '화재'),
	(59, '64', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 열동작', '화재'),
	(60, '65', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 열복구', '화재'),
	(61, '66', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 통신이상', '고장'),
	(62, '67', '0', '1~24', '1~24', '0', '0', '증계기 - 복합감지기 통신정상', '고장'),
	(63, '68', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 Low Battery', '고장'),
	(64, '69', '0', '1~24', '1~24', '0', '0', '중계기 - 복합감지기 Battery Normal', '고장'),
	(65, '70', '0', '1~24', '1~24', '0', '0', '중계기 - 불꽃감지기 등록', '상태'),
	(66, '71', '0', '1~24', '1~24', '0', '0', '중계기 - 불꽃감지기 등록해제', '상태'),
	(67, '72', '0', '1~24', '1~24', '0', '0', '중계기 - 불꽃감지기 동작', '화재'),
	(68, '73', '0', '1~24', '1~24', '0', '0', '중계기 - 불꽃감지기 복구', '화재'),
	(69, '74', '0', '1~24', '1~24', '0', '0', '중계기 - 불꽃감지기 통신이상', '고장'),
	(70, '75', '0', '1~24', '1~24', '0', '0', '중계기 - 불꽃감지기 통신정상', '고장'),
	(71, '76', '0', '1~24', '1~24', '0', '0', '중계기 - 불꽃감지기 Low Battery', '고장'),
	(72, '77', '0', '1~24', '1~24', '0', '0', '중계기 - 불꽃감지기 Battery Normal', '고장'),
	(73, '101', '0', '0', '0', '1', '0', '발신기 신호 발생', '화재'),
	(74, '101', '0', '0', '0', '2', '0', '발신기 신호 복구', '화재'),
	(75, '101', '1~128', '1~220', '0', '3', '1~4', '계통 - 중계기 - 입력단 화재 발생', '화재'),
	(76, '101', '1~128', '1~220', '0', '4', '1~4', '계통 - 중계기 - 입력단 화재 복구', '화재'),
	(77, '101', '1~128', '0', '1~220', '5', '0', '계통 - 광전식 아날로그 감지기 예비 화재 발생', '화재'),
	(78, '101', '1~128', '0', '1~220', '6', '0', '계통 - 광전식 아날로그 감지기 화재 발생', '화재'),
	(79, '101', '1~128', '0', '1~220', '7', '0', '계통 - 정온식 아날로그 감지기 예비 화재 발생', '화재'),
	(80, '101', '1~128', '0', '1~220', '8', '0', '계통 - 정온식 아날로그 감지기 화재 발생', '화재'),
	(81, '102', '1~128', '1~220', '0', '1', '1~4', '계통 - 중계기 - 입력단 축적 발생', '상태'),
	(82, '102', '1~128', '1~220', '0', '2', '1~4', '계통 - 중계기 - 입력단 축적 복구', '상태'),
	(83, '103', '1~128', '1~220', '0', '1', '1~4', '계통 - 중계기 - 입력단 가스 발생', '상태'),
	(84, '103', '1~128', '1~220', '0', '2', '1~4', '계통 - 중계기 - 입력단 가스 복구', '상태'),
	(85, '104', '1~128', '1~220', '0', '1', '1~4', '계통 - 중계기 - 입력단 설비 발생', '상태'),
	(86, '104', '1~128', '1~220', '0', '2', '1~4', '계통 - 중계기 - 입력단 설비 복구', '상태'),
	(87, '104', '0', '1~18 (펌프)', '0', '3', '1', '펌프 압력 스위치 설비 발생', '상태'),
	(88, '104', '0', '1~18 (펌프)', '0', '4', '1', '펌프 압력 스위치 설비 복구', '상태'),
	(89, '104', '0', '1~18 (펌프)', '0', '5', '2', '펌프 확인 설비 발생', '상태'),
	(90, '104', '0', '1~18 (펌프)', '0', '6', '2', '펌프 확인 설비 복구', '상태'),
	(91, '105', '1~128', '1~220', '0', '1', '1~4', '계통 - 중계기 - 입력단 단선 발생', '고장'),
	(92, '105', '1~128', '1~220', '0', '2', '1~4', '계통 - 중계기 - 입력단 단선 복구', '고장'),
	(93, '105', '0', '1~18 (펌프)', '0', '3', '1', '펌프 압력 스위치 단선', '고장'),
	(94, '105', '0', '1~18 (펌프)', '0', '4', '1', '펌프 압력 스위치 단선 복구', '고장'),
	(95, '106', '1~128', '1~220', '0', '1', '1~4', '계통 - 중계기 - 입력단 격리 설정', '상태'),
	(96, '106', '1~128', '1~220', '0', '2', '1~4', '계통 - 중계기 - 입력단 격리 해제', '상태'),
	(97, '106', '1~128', '1~220', '0', '3', '1~4', '계통 - 중계기 - 출력단 차단 설정', '상태'),
	(98, '106', '1~128', '1~220', '0', '4', '1~4', '계통 - 중계기 - 출력단 차단 해제', '상태'),
	(99, '107', '1~128', '1~220', '0', '1', '1~4', '계통 - 중계기 - 출력단 퓨즈 단선 발생', '고장'),
	(100, '107', '1~128', '1~220', '0', '2', '1~4', '계통 - 중계기 - 출력단 퓨즈 단선 복구', '고장'),
	(101, '107', '1~128', '1~220', '0', '3', '0', '계통 - 중계기 통신 고장 발생', '고장'),
	(102, '107', '1~128', '1~220', '0', '4', '0', '계통 - 중계기 통신 고장 복구 ', '고장'),
	(103, '107', '1~128', '0', '1~220', '5', '0', '계통 - 광전식 아날로그 감지기 통신 고장 발생', '고장'),
	(104, '107', '1~128', '0', '1~220', '6', '0', '계통 - 광전식 아날로그 감지기 통신 고장 복구', '고장'),
	(105, '107', '1~128', '0', '1~220', '7', '0', '계통 - 정온식 아날로그 감지기 통신 고장 발생', '고장'),
	(106, '107', '1~128', '0', '1~220', '8', '0', '계통 - 정온식 아날로그 감지기 통신 고장 복구', '고장'),
	(107, '107', '1~128', '1~220', '0', '9', '0', '계통 - 중계기 전원 이상 발생', '고장'),
	(108, '107', '1~128', '1~220', '0', '10', '0', '계통 - 중계기 전원 이상 복구', '고장'),
	(109, '108', '0', '0', '0', '1', '0', '스위치 보드 통신 연결 오류', '고장'),
	(110, '108', '0', '0', '0', '2', '0', '스위치 보드 통신 연결 오류 복구', '고장'),
	(111, '108', '0', '1~3 (MCC 보드)', '0', '3', '0', 'MCC 보드 통신 연결 오류 ', '고장'),
	(112, '108', '0', '1~3 (MCC 보드)', '0', '4', '0', 'MCC 보드 통신 연결 오류 복구', '고장'),
	(113, '108', '0', '1~3 (Relay 보드)', '0', '5', '0', 'Relay 보드 통신 연결 오류', '고장'),
	(114, '108', '0', '1~3 (Relay 보드)', '0', '6', '0', 'Relay 보드 통신 연결 오류 복구', '고장'),
	(115, '108', '0', '1~5 (Do24 보드)', '0', '7', '0', 'Do24 보드 통신 연결 오류', '고장'),
	(116, '108', '0', '1~5 (Do24 보드)', '0', '8', '0', 'Do24 보드 통신 연결 오류 복구', '고장'),
	(117, '108', '0', '0', '0', '9', '0', '파워 보드 통신 연결 오류', '고장'),
	(118, '108', '0', '0', '0', '10', '0', '파워 보드 통신 연결 오류 복구', '고장'),
	(119, '108', '0', '0', '0', '11', '0', '외부 비상방송 통신 연결 오류', '고장'),
	(120, '108', '0', '0', '0', '12', '0', '외부 비상방송 통신 연결 오류 복구', '고장'),
	(121, '108', '0', '0', '0', '13', '0', '예비전원 고장 발생', '고장'),
	(122, '108', '0', '0', '0', '14', '0', '예비전원 고장 복구', '고장'),
	(123, '108', '0', '0', '0', '15', '0', '교류전원 고장 발생', '고장'),
	(124, '108', '0', '0', '0', '16', '0', '교류전원 고장 복구', '고장'),
	(125, '108', '0', '0', '0', '17', '0', '표시등 퓨즈 단선 고장 발생', '고장'),
	(126, '108', '0', '0', '0', '18', '0', '표시등 퓨즈 단선 고장 복구', '고장'),
	(127, '108', '1~128', '0', '0', '19', '0', '계통 통신 연결 오류', '고장'),
	(128, '108', '1~128', '0', '0', '20', '0', '계통 통신 연결 오류 복구', '고장'),
	(129, '108', '0', '0', '0', '21', '0', '외부 비상방송 장치와 통신 오류', '고장'),
	(130, '108', '0', '0', '0', '22', '0', '외부 비상방송 장치와 통신 오류 복구', '고장'),
	(131, '109', '1~128', '1~220', '0', '1', '1~4', '계통 - 중계기 - 출력단 출력 발생', '상태'),
	(132, '109', '1~128', '1~220', '0', '2', '1~4', '계통 - 중계기 - 출력단 출력 복구', '상태'),
	(133, '109', '0', '1~120', '0', '3', '0', '비상방송 출력 발생', '상태'),
	(134, '109', '0', '1~120', '0', '4', '0', '비상방송 출력 복구', '상태'),
	(135, '109', '1~ (동)', '0~ (계단)', '0~ (층)', '5', '0', '외부 비상방송 (동,계단,층) 출력 발생', '상태'),
	(136, '109', '1~ (동)', '0~ (계단)', '0~ (층)', '6', '0', '외부 비상방송 (동,계단,층) 출력 복구', '상태'),
	(137, '110', '0', '0', '0', '1', '0', '예비전원시험 시작', '상태'),
	(138, '110', '0', '0', '0', '2', '0', '예비전원시험 성공', '상태'),
	(139, '110', '0', '0', '0', '3', '0', '예비전원시험 실패', '상태'),
	(140, '110', '0', '0', '0', '4', '0', '수신기 시작', '상태'),
	(141, '110', '0', '0', '0', '5', '0', '수신기 종료', '상태'),
	(142, '110', '0', '0', '0', '6', '0', '수신기 시간 설정', '상태'),
	(143, '110', '0', '0', '0', '7', '0', '외부 전화 신호 발생', '상태'),
	(144, '110', '0', '0', '0', '8', '0', '외부 전화 신호 복구', '상태'),
	(145, '110', '0', '0', '0', '9', '0', '주음향 발생', '상태'),
	(146, '110', '0', '0', '0', '10', '0', '주음향 복구', '상태'),
	(147, '110', '0', '0', '0', '11', '0', '기타음향 발생', '상태'),
	(148, '110', '0', '0', '0', '12', '0', '기타음향 복구', '상태'),
	(149, '110', '0', '0', '0', '13', '0', '폰음향 발생', '상태'),
	(150, '110', '0', '0', '0', '14', '0', '폰음향 복구', '상태'),
	(151, '110', '0', '0', '0', '15', '0', '예비전원 이상 발생', '상태'),
	(152, '110', '0', '0', '0', '16', '0', '예비전원 이상 복구', '상태'),
	(153, '110', '0', '0', '0', '17', '0', '예비전원 저전압', '상태'),
	(154, '110', '0', '0', '0', '18', '0', '예비전원 저전압 복구', '상태'),
	(155, '110', '0', '0', '0', '19', '0', '수신기 복구 시작', '상태'),
	(156, '110', '0', '0', '0', '20', '0', '수신기 복구 완료', '상태'),
	(157, '110', '0', '0', '0', '21', '0', '자동복구 설정', '상태'),
	(158, '110', '0', '0', '0', '22', '0', '자동복구 해제', '상태'),
	(159, '110', '0', '10~60 (초)', '0', '23', '0', '축적 설정 (10, 20, 30, 40, 50, 60)', '상태'),
	(160, '110', '0', '0', '0', '24', '0', '축적 해제', '상태'),
	(161, '110', '0', '10~60 (초)', '0', '25', '0', '축적 시간 변경 (10, 20, 30, 40, 50, 60)', '상태'),
	(162, '110', '0', '0', '0', '26', '0', '주음향 정지 ON', '상태'),
	(163, '110', '0', '0', '0', '27', '0', '주음향 정지 OFF', '상태'),
	(164, '110', '0', '0', '0', '28', '0', '기타음향 정지 ON', '상태'),
	(165, '110', '0', '0', '0', '29', '0', '기타음향 정지 OFF', '상태'),
	(166, '110', '0', '0', '0', '30', '0', '지구벨 정지 ON', '상태'),
	(167, '110', '0', '0', '0', '31', '0', '지구벨 정지 OFF', '상태'),
	(168, '110', '0', '0', '0', '32', '0', '싸이렌 정지 ON', '상태'),
	(169, '110', '0', '0', '0', '33', '0', '싸이렌 정지 OFF', '상태'),
	(170, '110', '0', '0', '0', '34', '0', '비상방송 정지 ON', '상태'),
	(171, '110', '0', '0', '0', '35', '0', '비상방송 정지 OFF', '상태'),
	(172, '110', '0', '0', '0', '36', '0', '물분무 정지 ON', '상태'),
	(173, '110', '0', '0', '0', '37', '0', '물분무 정지 OFF', '상태'),
	(174, '110', '0', '0', '0', '38', '0', '제연담파 정지 ON', '상태'),
	(175, '110', '0', '0', '0', '39', '0', '제연담파 정지 OFF', '상태'),
	(176, '110', '0', '0', '0', '40', '0', '방화샷타 정지 ON', '상태'),
	(177, '110', '0', '0', '0', '41', '0', '방화샷타 정지 OFF', '상태'),
	(178, '110', '0', '0', '0', '42', '0', '방화문 정지 ON', '상태'),
	(179, '110', '0', '0', '0', '43', '0', '방화문 정지 OFF', '상태'),
	(180, '110', '0', '0', '0', '44', '0', '유도등 정지 ON', '상태'),
	(181, '110', '0', '0', '0', '45', '0', '유도등 정지 OFF', '상태'),
	(182, '110', '0', '0', '0', '46', '0', '제연휀 정지 ON', '상태'),
	(183, '110', '0', '0', '0', '47', '0', '제연휀 정지 OFF', '상태'),
	(184, '110', '0', '0', '0', '48', '0', 'P/V 정지 ON', '상태'),
	(185, '110', '0', '0', '0', '49', '0', 'P/V 정지 OFF', '상태'),
	(186, '110', '0', '0', '0', '50', '0', '사용자1 정지 ON', '상태'),
	(187, '110', '0', '0', '0', '51', '0', '사용자1 정지 OFF', '상태'),
	(188, '110', '0', '0', '0', '52', '0', '사용자2 정지 ON', '상태'),
	(189, '110', '0', '0', '0', '53', '0', '사용자2 정지 OFF', '상태'),
	(190, '110', '0', '0', '0', '54', '0', '사용자3 정지 ON', '상태'),
	(191, '110', '0', '0', '0', '55', '0', '사용자3 정지 OFF', '상태'),
	(192, '110', '0', '0', '0', '56', '0', '스위치 보드 통신 연결 성공', '상태'),
	(193, '110', '0', '1~3 (MCC 보드)', '0', '57', '0', 'MCC 보드 통신 연결 성공', '상태'),
	(194, '110', '0', '1~3 (Relay 보드)', '0', '58', '0', 'Relay 보드 통신 연결 성공', '상태'),
	(195, '110', '0', '1~5 (Do24 보드)', '0', '59', '0', 'Do24 보드 통신 연결 성공', '상태'),
	(196, '110', '0', '0', '0', '60', '0', '파워 보드 통신 연결 성공', '상태'),
	(197, '110', '0', '0', '0', '61', '0', '외부 비상방송 통신 연결 성공', '상태'),
	(198, '110', '1~128', '0', '0', '62', '0', '계통 통신 연결 성공', '상태'),
	(199, '111', '0', '1~18 (펌프)', '0', '1', '0', '펌프 기동 출력 발생', '상태'),
	(200, '111', '0', '1~18 (펌프)', '0', '2', '0', '펌프 기동 출력 복구', '상태'),
	(201, '111', '0', '1~18 (펌프)', '0', '3', '0', '펌프 수동기동 설정', '상태'),
	(202, '111', '0', '1~18 (펌프)', '0', '4', '0', '펌프 정지기동 설정', '상태'),
	(203, '111', '0', '1~18 (펌프)', '0', '5', '0', '펌프 자동기동 설정', '상태'),
	(204, '112', '0', '0', '0', '1', '0', '주음향 정지 스위치 ON', '상태'),
	(205, '112', '0', '0', '0', '2', '0', '주음향 정지 스위치 OFF', '상태'),
	(206, '112', '0', '0', '0', '3', '0', '기타음향 정지 스위치 ON', '상태'),
	(207, '112', '0', '0', '0', '4', '0', '기타음향 정지 스위치 OFF', '상태'),
	(208, '112', '0', '0', '0', '5', '0', '지구벨 정지 스위치 ON', '상태'),
	(209, '112', '0', '0', '0', '6', '0', '지구벨 정지 스위치 OFF', '상태'),
	(210, '112', '0', '0', '0', '7', '0', '싸이렌 정지 스위치 ON', '상태'),
	(211, '112', '0', '0', '0', '8', '0', '싸이렌 정지 스우치 OFF', '상태'),
	(212, '112', '0', '0', '0', '9', '0', '비상방송 정지 스위치 ON', '상태'),
	(213, '112', '0', '0', '0', '10', '0', '비상방송 정지 스위치 OFF', '상태'),
	(214, '112', '0', '0', '0', '11', '0', '물분무 정지 스위치 ON', '상태'),
	(215, '112', '0', '0', '0', '12', '0', '물분무 정지 스위치 OFF', '상태'),
	(216, '112', '0', '0', '0', '13', '0', '제연담파 정지 스위치 ON', '상태'),
	(217, '112', '0', '0', '0', '14', '0', '제연담파 정지 스위치 OFF', '상태'),
	(218, '112', '0', '0', '0', '15', '0', '방화샷타 정지 스위치 ON', '상태'),
	(219, '112', '0', '0', '0', '16', '0', '방화샷타 정지 스위치 OFF', '상태'),
	(220, '112', '0', '0', '0', '17', '0', '방화문 정지 스위치 ON', '상태'),
	(221, '112', '0', '0', '0', '18', '0', '방화문 정지 스위치 OFF', '상태'),
	(222, '112', '0', '0', '0', '19', '0', '유도등 정지 스위치 ON', '상태'),
	(223, '112', '0', '0', '0', '20', '0', '유도등 정지 스위치 OFF', '상태'),
	(224, '112', '0', '0', '0', '21', '0', '제연휀 정지 스위치 ON', '상태'),
	(225, '112', '0', '0', '0', '22', '0', '제연휀 정지 스위치 OFF', '상태'),
	(226, '112', '0', '0', '0', '23', '0', 'P/V 정지 스위치 ON', '상태'),
	(227, '112', '0', '0', '0', '24', '0', 'P/V 정지 스위치 OFF', '상태'),
	(228, '112', '0', '0', '0', '25', '0', '사용자1 정지 스위치 ON', '상태'),
	(229, '112', '0', '0', '0', '26', '0', '사용자1 정지 스위치 OFF', '상태'),
	(230, '112', '0', '0', '0', '27', '0', '사용자2 정지 스위치 ON', '상태'),
	(231, '112', '0', '0', '0', '28', '0', '사용자2 정지 스위치 OFF', '상태'),
	(232, '112', '0', '0', '0', '29', '0', '사용자3 정지 스위치 ON', '상태'),
	(233, '112', '0', '0', '0', '30', '0', '사용자3 정지 스위치 OFF', '상태'),
	(234, '113', '0', '0', '0', '1', '0', '한전 확인 발생', '상태'),
	(235, '113', '0', '0', '0', '2', '0', '한전 확인 복구', '상태'),
	(236, '113', '0', '0', '0', '3', '0', '발전 확인 발생', '상태'),
	(237, '113', '0', '0', '0', '4', '0', '발전 확인 복구', '상태'),
	(238, '113', '0', '1~ (교차회로)', '0', '5', '0', '교차회로 발생', '상태'),
	(239, '113', '0', '1~ (교차회로)', '0', '6', '0', '교차회로 발생', '상태'),
	(240, '114', '1~128', '0', '1~220', '0~255', '1', '광전식 아날로그 감지기 값 (나누기 10 한 값이 실제 값)', '상태'),
	(241, '114', '1~128', '0', '1~220', '0~255', '2', '정온식 아날로그 감지기 값', '상태');

-- 테이블 fireprjdb.fire_receiver_tbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `fire_receiver_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver_idx` varchar(20) NOT NULL DEFAULT '',
  `fk_customer_idx` int(11) unsigned NOT NULL DEFAULT 0,
  `receiver_type` int(11) unsigned NOT NULL DEFAULT 0,
  `receiver_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 fireprjdb.fire_receiver_tbl:~2 rows (대략적) 내보내기
INSERT INTO `fire_receiver_tbl` (`id`, `receiver_idx`, `fk_customer_idx`, `receiver_type`, `receiver_id`) VALUES
	(1, '00001_001_001', 1, 1, 1),
	(2, '00002_001_002', 2, 2, 2);

-- 테이블 fireprjdb.fire_repeater_tbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `fire_repeater_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `repeater_idx` varchar(50) NOT NULL DEFAULT '',
  `fk_customer_idx` int(11) unsigned NOT NULL DEFAULT 0,
  `receiver_id` int(11) unsigned NOT NULL DEFAULT 0,
  `system_id` int(11) unsigned NOT NULL DEFAULT 0,
  `repeater_id` int(11) unsigned NOT NULL,
  `register_status` int(11) DEFAULT NULL,
  `action_status` int(11) DEFAULT NULL,
  `com_status` int(11) DEFAULT NULL,
  `battery_status` int(11) DEFAULT NULL,
  `last_event_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 fireprjdb.fire_repeater_tbl:~4 rows (대략적) 내보내기
INSERT INTO `fire_repeater_tbl` (`id`, `repeater_idx`, `fk_customer_idx`, `receiver_id`, `system_id`, `repeater_id`, `register_status`, `action_status`, `com_status`, `battery_status`, `last_event_time`) VALUES
	(1, '00001_001_000_001', 1, 1, 0, 1, 1, 1, 1, 1, '2024-03-04 17:55:31'),
	(2, '00002_001_000_002', 2, 1, 0, 2, 1, 1, 1, 1, '2024-03-04 17:55:32'),
	(3, '00001_002_000_003', 1, 2, 0, 3, 0, 0, 0, 0, '2024-03-04 17:55:33'),
	(4, '00001_002_000_004', 1, 2, 0, 4, 0, 0, 0, 0, '2024-03-04 17:55:34');

-- 테이블 fireprjdb.fire_sensor_tbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `fire_sensor_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_idx` varchar(50) NOT NULL DEFAULT '',
  `fk_customer_idx` int(11) unsigned NOT NULL DEFAULT 0,
  `receiver_id` int(11) unsigned NOT NULL DEFAULT 0,
  `system_id` int(11) unsigned NOT NULL DEFAULT 0,
  `repeater_id` int(11) unsigned NOT NULL DEFAULT 0,
  `sensor_id` int(11) unsigned NOT NULL DEFAULT 0,
  `register_status` int(11) DEFAULT NULL,
  `action_status` int(11) DEFAULT NULL,
  `com_status` int(11) DEFAULT NULL,
  `battery_status` int(11) DEFAULT NULL,
  `last_event_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 fireprjdb.fire_sensor_tbl:~20 rows (대략적) 내보내기
INSERT INTO `fire_sensor_tbl` (`id`, `sensor_idx`, `fk_customer_idx`, `receiver_id`, `system_id`, `repeater_id`, `sensor_id`, `register_status`, `action_status`, `com_status`, `battery_status`, `last_event_time`) VALUES
	(1, '00001_001_000_001_001', 1, 1, 0, 1, 1, 1, 1, 1, 1, '2024-03-04 15:26:10'),
	(2, '00002_001_000_001_002', 2, 1, 0, 1, 2, 1, 1, 1, 1, '2024-03-04 15:26:12'),
	(3, '00002_001_000_001_003', 2, 1, 0, 1, 3, 1, 1, 1, 1, '2024-03-04 15:26:08'),
	(4, '00001_001_000_001_004', 1, 1, 0, 1, 4, 1, 1, 1, 1, '2024-03-04 15:26:13'),
	(5, '00001_001_000_001_005', 1, 1, 0, 1, 5, NULL, NULL, NULL, NULL, '2024-03-04 15:26:13'),
	(6, '00001_001_000_002_006', 1, 1, 0, 2, 6, NULL, NULL, NULL, NULL, '2024-03-04 15:26:14'),
	(7, '00001_001_000_002_007', 1, 1, 0, 2, 7, NULL, NULL, NULL, NULL, '2024-03-04 15:26:14'),
	(8, '00001_001_000_002_008', 1, 1, 0, 2, 8, NULL, NULL, NULL, NULL, '2024-03-04 15:26:16'),
	(9, '00001_001_000_002_009', 1, 1, 0, 2, 9, NULL, NULL, NULL, NULL, '2024-03-04 15:26:16'),
	(10, '00001_001_000_002_010', 1, 1, 0, 2, 10, NULL, NULL, NULL, NULL, '2024-03-04 15:26:17'),
	(11, '00001_002_000_003_011', 1, 2, 0, 3, 11, NULL, NULL, NULL, NULL, '2024-03-04 15:26:17'),
	(12, '00001_002_000_003_012', 1, 2, 0, 3, 12, NULL, NULL, NULL, NULL, '2024-03-04 15:26:42'),
	(13, '00001_002_000_003_013', 1, 2, 0, 3, 13, 1, 1, 1, 1, '2024-03-04 15:26:18'),
	(14, '00001_002_000_003_014', 1, 2, 0, 3, 14, 1, 1, 1, 1, '2024-03-04 15:26:19'),
	(15, '00001_002_000_003_015', 1, 2, 0, 3, 15, 1, 1, 1, 1, '2024-03-04 15:26:19'),
	(16, '00001_002_000_004_016', 1, 2, 0, 4, 16, NULL, NULL, NULL, NULL, '2024-03-04 15:26:20'),
	(17, '00001_002_000_004_017', 1, 2, 0, 4, 17, NULL, NULL, NULL, NULL, '2024-03-04 15:26:21'),
	(18, '00001_002_000_004_018', 1, 2, 0, 4, 18, NULL, NULL, NULL, NULL, '2024-03-04 15:26:22'),
	(19, '00001_002_000_004_019', 1, 2, 0, 4, 19, NULL, NULL, NULL, NULL, '2024-03-04 15:26:23'),
	(20, '00001_002_000_004_020', 1, 2, 0, 4, 20, NULL, NULL, NULL, NULL, '2024-03-04 15:26:24');

-- 테이블 fireprjdb.user_tbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(10) NOT NULL,
  `user_pwd` varchar(1024) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `user_status` int(11) NOT NULL DEFAULT 1,
  `user_role` int(11) NOT NULL DEFAULT 1,
  `token` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 fireprjdb.user_tbl:~4 rows (대략적) 내보내기
INSERT INTO `user_tbl` (`id`, `user_id`, `user_pwd`, `user_name`, `user_status`, `user_role`, `token`) VALUES
	(1, 'admin', 'daef4953b9783365cad6615223720506cc46c5167cd16ab500fa597aa08ff964eb24fb19687f34d7665f778fcb6c5358fc0a5b81e1662cf90f73a2671c53f991', '관리자', 1, 1, '32c3ec15b90e3c8fd03e71e44eed6c723040bb66'),
	(2, 'test1', '886d7936172eb5e523bd200aa0228f0a8dfe8eda031efaefc6829f7b13636138f927f24e00ec4a554f40b4f5ef15dd7d0c8c21cff20474508e1ad7923ae0323b', 'test', 1, 1, NULL),
	(3, 'test2', 'e55938e9301616435b2122e046b25375b470f1d24a2c77edfd80f4748901e20a87010749044f2ed95cdff0e90e8a8f3619fa683c9df56241590d5fbe6b54f745', 'test2', 1, 0, '053e2490c746bcff59234b34904b0e26b9350139'),
	(5, 'test', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'sdfsdf', 0, 0, NULL);

-- 트리거 fireprjdb.tg_event_update 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tg_event_update` BEFORE INSERT ON `event_log_tbl` FOR EACH ROW BEGIN
	DECLARE event_id INT;
	IF NEW.event_idx >= 1 AND NEW.event_idx < 29 THEN
		SELECT id INTO event_id FROM event_tbl WHERE event_idx=NEW.event_idx;
		SET NEW.event_id = event_id;
	ELSEIF NEW.event_idx >= 29 AND NEW.event_idx < 31 THEN
		SELECT id INTO event_id FROM event_tbl WHERE event_idx=NEW.event_idx AND sensor_id_c=NEW.sensor_id;		
		SET NEW.event_id = event_id;
	ELSEIF NEW.event_idx >= 31 AND NEW.event_idx < 78 THEN
		SELECT id INTO event_id FROM event_tbl WHERE event_idx=NEW.event_idx;
		SET NEW.event_id = event_id;
	ELSEIF NEW.event_idx >= 101 AND NEW.event_idx < 114 THEN
		SELECT id INTO event_id FROM event_tbl WHERE event_idx=NEW.event_idx AND sensor_value_c=cast(NEW.sensor_value as UNSIGNED);		
		SET NEW.event_id = event_id;
	ELSEIF NEW.event_idx >= 114 THEN
		SELECT id INTO event_id FROM event_tbl WHERE event_idx=NEW.event_idx AND inout_id_c=NEW.inout_id;
		SET NEW.event_id = event_id;		
	END IF;
	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;