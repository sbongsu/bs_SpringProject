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

#게시물 테이블 생성
CREATE TABLE article(
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
title CHAR(100) NOT NULL,
`body` TEXT NOT NULL
);

# 테스트 게시물 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '안녕하세요',
`body` = '안녕하세요 반갑습니다.';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '깝순',
`body` = '복순';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '전라북도',
`body` = '정읍시';

# 게시물 테이블에 회원정보 추가
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER `updateDate`;

# 기존 게시물의 작성자를 2번호으로 지정
UPDATE article
SET memberId = 2
WHERE memberId = 0;

#게시판 테이블 생성
CREATE TABLE board(
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
`code` CHAR(50) NOT NULL UNIQUE,
`name` CHAR(50) NOT NULL UNIQUE
);

# 공지사항 추가
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

# 자유게시판 추가
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free',
`name` = '자유게시판';

# 게시물 테이블에 boardId 추가
ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER memberId;

# 게시물에 게시판 번호 부여
UPDATE article
SET boardId = 1
WHERE id IN (1,2);

UPDATE article
SET boardId = 2
WHERE id IN (3);

SELECT * FROM board;
SELECT * FROM `member`;
SELECT * FROM article;