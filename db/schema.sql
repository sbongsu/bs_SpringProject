DROP DATABASE IF EXISTS bs_SpringProject;
CREATE DATABASE bs_SpringProject;
USE bs_SpringProject;
# 회원 테이블 생성
CREATE TABLE `member`(
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
loginId CHAR(20) NOT NULL,
loginPw CHAR(30) NOT NULL,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
userName CHAR(20) NOT NULL,
nickName CHAR(20) NOT NULL,
email CHAR(50) NOT NULL,
phoneNum CHAR(50) NOT NULL
);

# 회원 테스드 데이터 생성
INSERT INTO `member`
SET loginId = 'user1',
loginPw = 'user1',
regDate = NOW(),
updateDate = NOW(),
userName = '손봉수',
nickName = '봉구',
email = 'a_s111@nate.com',
phoneNum = '01012345678';
SELECT * FROM `member`;

INSERT INTO `member`
SET loginId = 'user2',
loginPw = 'user2',
regDate = NOW(),
updateDate = NOW(),
userName = '홍길동',
nickName = '길동',
email = 'asdfe@nate.com',
phoneNum = '01022223333';
SELECT * FROM `member`;

#게시물 테이블 생성
CREATE TABLE article(
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
title CHAR(100) NOT NULL,
`body` TEXT NOT NULL
);