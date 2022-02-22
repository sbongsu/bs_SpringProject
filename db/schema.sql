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

/*
insert into article
(
    regDate, updateDate, memberId, boardId, title, `body`
)
select now(), now(), FLOOR(RAND() * 2) + 1, FLOOR(RAND() * 2) + 1, concat('제목_', rand()), CONCAT('내용_', RAND())
from article;
*/

# 부가정보테이블
# 댓글 테이블 추가
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(70) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`);

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;

SELECT * FROM board;
SELECT * FROM `member`;
SELECT * FROM article;

