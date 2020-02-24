-----------------------회원
-- 회원코드 시퀀스
DROP SEQUENCE MEMBER_CODE_SEQ;
CREATE SEQUENCE MEMBER_CODE_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 9999
   NOCYCLE
   NOCACHE;
   
-- 회원 정보 테이블
DROP TABLE MEMBER;
CREATE TABLE MEMBER (

   MEMBER_CODE NUMBER NOT NULL,   -- PK   
   MEMBER_NAME VARCHAR2(100) NOT NULL,   -- 사용자입력
   MEMBER_EMAIL VARCHAR2(100) NOT NULL, -- unq
   MEMBER_PW VARCHAR2(500),   -- sns회원가입 시 pw null 가능!
   MEMBER_PHONE VARCHAR2(100) NOT NULL,   -- 사용자입력
   
   MEMBER_ENABLED VARCHAR2(2) DEFAULT 'Y' NOT NULL,
   MEMBER_ROLE VARCHAR2(100) DEFAULT '1' NOT NULL,
   
   MEMBER_LOGOUT_DATE DATE DEFAULT SYSDATE NOT NULL,
   MEMBER_CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,   -- 회원정보 생성일(DEFAULT SYSDATE)
   
   CONSTRAINT PK_MEMBER_CODE PRIMARY KEY(MEMBER_CODE),
   CONSTRAINT UNQ_MEMBER_EMAIL UNIQUE(MEMBER_EMAIL),
   CONSTRAINT CK_MEMBER_ENABLED CHECK(MEMBER_ENABLED IN('Y','N')),
   CONSTRAINT CK_MEMBER_ROLE CHECK(MEMBER_ROLE IN('1','2'))

);
ALTER TABLE MEMBER
DROP CONSTRAINT CK_MEMBER_ROLE;

ALTER TABLE MEMBER
ADD CONSTRAINT CK_MEMBER_ROLE CHECK(MEMBER_ROLE IN('1','2'));

SELECT * FROM MEMBER;
DELETE FROM MEMBER WHERE MEMBER_CODE = 2;
-- INSERT 기본 형식
INSERT INTO MEMBER
VALUES(MEMBER_CODE_SEQ.NEXTVAL,'조현준','abc@abc.com','123','010-1234-1234','Y','1',SYSDATE,SYSDATE);
   
-- sns회원 정보 테이블
DROP TABLE KAKAOMEMBER;
CREATE TABLE KAKAOMEMBER (
   MEMBER_CODE NUMBER NOT NULL,
   
   KAKAO_ID VARCHAR2(100),   -- 카카오 회원가입 시 
   KAKAO_NICKNAME VARCHAR2(100),
   
   CONSTRAINT FK_MEMBER_CODE_KAKAO FOREIGN KEY(MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);
SELECT * FROM KAKAOMEMBER;
DROP TABLE NAVERMEMBER;
CREATE TABLE NAVERMEMBER (
   MEMBER_CODE NUMBER NOT NULL,
   
   NAVER_ID VARCHAR2(100),   -- 네이버 회원가입 시
   NAVER_NICKNAME VARCHAR2(100),
   
   CONSTRAINT FK_MEMBER_CODE_NAVER FOREIGN KEY(MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);
SELECT * FROM NAVERMEMBER;


-- KAKAO INSERT 기본 형식
INSERT INTO KAKAOMEMBER(MEMBER_CODE, KAKAO_ID, KAKAO_NICKNAME)
VALUES(서버에서 가져온 MEMBER_CODE,KAKAO_ID,KAKAO_NICKNAME);
INSERT INTO KAKAOMEMBER (MEMBER_CODE, KAKAO_ID, KAKAO_NICKNAME)
VALUES(1,'1234','쟌쥰');
-- NAVER INSERT 기본 형식
INSERT INTO NAVERMEMBER(MEMBER_CODE,NAVER_ID,NAVER_NICKNAME)
VALUES(1,NAVER_ID,NAVER_NICKNAME);
INSERT INTO NAVERMEMBER (MEMBER_CODE, NAVER_ID, NAVER_NICKNAME)
VALUES(1,'1234','쟌쥰');

-- KAKAO SELECTONE
SELECT MEMBER_CODE,MEMBER_NAME,MEMBER_EMAIL,MEMBER_PW,MEMBER_PHONE,
MEMBER_ENABLED,MEMBER_ROLE,MEMBER_LOGOUT_DATE,MEMBER_CREATE_DATE,
KAKAO_ID,KAKAO_NICKNAME
FROM MEMBER JOIN KAKAOMEMBER USING(MEMBER_CODE);
-- NAVER SELECTONE
SELECT MEMBER_CODE,MEMBER_NAME,MEMBER_EMAIL,MEMBER_PW,MEMBER_PHONE,
MEMBER_ENABLED,MEMBER_ROLE,MEMBER_LOGOUT_DATE,MEMBER_CREATE_DATE,
NAVER_ID,NAVER_NICKNAME
FROM MEMBER JOIN NAVERMEMBER USING(MEMBER_CODE);

-- KAKAO LOGIN CHECK USING KAKAO ID
SELECT MEMBER_CODE,MEMBER_NAME,MEMBER_EMAIL,MEMBER_PW,MEMBER_PHONE,
MEMBER_ENABLED,MEMBER_ROLE,MEMBER_LOGOUT_DATE,MEMBER_CREATE_DATE,
KAKAO_ID,KAKAO_NICKNAME
FROM MEMBER JOIN KAKAOMEMBER USING(MEMBER_CODE)
WHERE ;


----------------------프로필
-- 프로필 코드 시퀀스
--DROP SEQUENCE PROFILE_SEQ;
--CREATE SEQUENCE PROFILE_SEQ
--   START WITH 1
--   INCREMENT BY 1
--   MAXVALUE 9999
--   NOCYCLE
--   NOCACHE;
   
-- 프로필 테이블
--DROP TABLE PROFILE;
--CREATE TABLE PROFILE (

--	PROFILE_SEQ NUMBER NOT NULL,   -- PK   
--	MEMBER_CODE NUMBER NOT NULL,   -- FK
--	PROFILE_CAREER_SEQ NUMBER,
--	PROFILE_PERFORMANCE_SEQ NUMBER,
--	PROFILE_PROJECT_SEQ NUMBER,
--	PROFILE_SKILL_ONE NUMBER,
--	PROFILE_LANGUAGE NUMBER,
--	PROFILE_CERTIFICATE_SEQ NUMBER,
--	PROFILE_ACADEMY_BACKGROUND_SEQ NUMBER,
--	PROFILE_STORAGE_SEQ NUMBER,
--	PROFILE_LINE_OF_WORK_ONE NUMBER,
--	PROFILE_INCOME NUMBER,
   
--   CONSTRAINT PK_PROFILE_SEQ_01 PRIMARY KEY(PROFILE_SEQ),
--   CONSTRAINT FK_MEMBER_CODE_PROFILE_01 FOREIGN KEY(MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE

--);
--SELECT * FROM PROFILE;
--DELETE FROM PROFILE;
-- 프로필 INSERT 기본 형식
--INSERT INTO PROFILE
--VALUES(PROFILE_SEQ.NEXTVAL,(SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 2),0,0,0,0,0,0,0,0,0,0);

----------------- 커리어
-- 커리어 코드 시퀀스
DROP SEQUENCE CAREER_SEQ;
CREATE SEQUENCE CAREER_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;
	
-- 커리어 테이블
DROP TABLE CAREER;
CREATE TABLE CAREER(
	CAREER_SEQ NUMBER NOT NULL,			--PK
	CAREER_MEMBER_CODE NUMBER NOT NULL,		--FK
	COMPANY_NAME VARCHAR2(100),
	DUTY VARCHAR2(100),
	DAY_OF_ENTRY DATE,
	DATE_OF_DEPARTURE DATE,
	STACK VARCHAR2(100),
	LINK VARCHAR2(100),
	EXPLANATION VARCHAR2(1000),
	
	CONSTRAINT PK_CAREER_SEQ PRIMARY KEY(CAREER_SEQ),
	CONSTRAINT FK_CAREER_MEMBER_CODE FOREIGN KEY(CAREER_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
	
);

INSERT INTO CAREER
VALUES(CAREER_SEQ.NEXTVAL, 4,' ',' ', SYSDATE, SYSDATE,' ',' ',' ')
SELECT * FROM CAREER;
DELETE FROM CAREER;
-- 커리어 INSERT 형식
SELECT COUNT(*) FROM CAREER
WHERE CAREER_MEMBER_CODE = 5
		
INSERT INTO CAREER 
VALUES(CAREER_SEQ.NEXTVAL,(SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 4),'회사명','직무',
to_date('02-01-2020','MM-DD-YYYY'), to_date('02-28-2020','MM-DD-YYYY'), '자바등등','링크주소','생각해보니 실적없음');

--------------- 커리어 상세 항목
--커리어 상세 항목 시퀀스
DROP SEQUENCE CAREER_DETAIL_SEQ;
CREATE SEQUENCE CAREER_DETAIL_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;
	
--커리어 상세 항목 테이블

DROP TABLE CAREER_DETAIL;
CREATE TABLE CAREER_DETAIL(
	CAREER_DETAIL_SEQ NUMBER NOT NULL,						--PK
	CAREER_DETAIL_CAREER_SEQ NUMBER NOT NULL,				--FK
	PERFORMANCE VARCHAR2(100),
	START_DATE DATE,
	END_DATE DATE,
	DETAIL_CONTEXT VARCHAR2(1000),
	
	CONSTRAINT PK_CAREER_DETAIL_SEQ PRIMARY KEY(CAREER_DETAIL_SEQ),
	CONSTRAINT FK_CAREER_DETAIL_CAREER_SEQ FOREIGN KEY(CAREER_DETAIL_CAREER_SEQ) REFERENCES CAREER(CAREER_SEQ) ON DELETE CASCADE
);

SELECT * FROM CAREER_DETAIL;
DELETE FROM CAREER_DETAIL;

--커리어 세부항목 INSERT
INSERT INTO CAREER_DETAIL 
VALUES(CAREER_DETAIL_SEQ.NEXTVAL, (SELECT CAREER_SEQ FROM CAREER WHERE CAREER_MEMBER_CODE = 4), '커리어 엑셀레이터',
to_date('2020-02-01','YYYY-MM-DD'), to_date('2020-02-28','YYYY-MM-DD'),'크롤링');

INSERT INTO CAREER_DETAIL
VALUES(CAREER_DETAIL_SEQ.NEXTVAL, (SELECT CAREER_SEQ FROM CAREER WHERE CAREER_MEMBER_CODE = 4),'',SYSDATE,SYSDATE,'' )

UPDATE CAREER_DETAIL SET
START_DATE = TO_DATE('2020-02-01 12:00:00','YYYY-MM-DD HH24:MI:SS');
---------------- 개인 프로젝트
-- 개인 프로젝트 시퀀스
DROP SEQUENCE PROJECT_SEQ;
CREATE SEQUENCE PROJECT_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;
	
-- 개인 프로젝트 테이블
DROP TABLE PROJECT;
CREATE TABLE PROJECT(
	PROJECT_SEQ NUMBER NOT NULL,
	PROJECT_MEMBER_CODE NUMBER NOT NULL,
	PROJECT_NAME VARCHAR2(100),
	PROJECT_YEAR NUMBER,
	PROJECT_ONELINE_EX VARCHAR2(100),
	PROJECT_TEAM VARCHAR2(100),
	PROJECT_MEMBER NUMBER,
	PROJECT_USE_STACK VARCHAR2(100),
	PROJECT_DETAIL VARCHAR2(1000),
	PROJECT_STORAGE_LINK VARCHAR2(100),
	PROJECT_WEBSITE VARCHAR2(100),
	PROJECT_ANDROID VARCHAR2(100),
	PROJECT_IOS VARCHAR2(100),
	
	CONSTRAINT PK_PROJECT_SEQ PRIMARY KEY(PROJECT_SEQ),
	CONSTRAINT FK_PROJECT_MEMBER_CODE FOREIGN KEY(PROJECT_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);

SELECT * FROM PROJECT;
DELETE FROM PROJECT;

-- 개인 프로젝트 INSERT
INSERT INTO PROJECT
VALUES(PROJECT_SEQ.NEXTVAL,(SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 4),'세미프로젝트',2020,'커리어 엑셀레이터(커리어 로드맵)','team',5,
		'java, oracle, html/css, javascript/jquery, servlet',
		'사용자들에게 필요한 커리어를 제공해주는 사이트를 제작한 프로젝트', 'link','Website_Link','Android_Link','iOS_Link');
		
--------------- 주요기술
-- 주요기술 시퀀스

DROP SEQUENCE SKILL_SEQ;
CREATE SEQUENCE SKILL_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;

-- 주요기술 테이블	

DROP TABLE SKILL;
CREATE TABLE SKILL(
	
	SKILL_SEQ NUMBER NOT NULL,
	SKILL_MEMBER_CODE NUMBER NOT NULL,
	SKILL VARCHAR2(100),

	CONSTRAINT PK_SKILL_SEQ PRIMARY KEY(SKILL_SEQ),
	CONSTRAINT FK_SKILL_MEMBER_CODE FOREIGN KEY(SKILL_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);
	

SELECT * FROM SKILL;
DELETE FROM SKILL WHERE SKILL_MEMBER_CODE = 4;
SELECT COUNT(*) FROM SKILL WHERE SKILL_MEMBER_CODE = 4
-- 주요기술 INSERT
INSERT INTO SKILL
VALUES(SKILL_SEQ.NEXTVAL, (SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 4), 'JAVA');

------------------ 외국어
-- 외국어 시퀀스
DROP SEQUENCE LANGUAGE_SEQ;
CREATE SEQUENCE LANGUAGE_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;

-- 외국어 테이블
DROP TABLE LANGUAGE;
CREATE TABLE LANGUAGE(
	LANGUAGE_SEQ NUMBER NOT NULL,
	LANGUAGE_MEMBER_CODE NUMBER NOT NULL,
	LANGUAGE VARCHAR2(100) UNIQUE,
	
	CONSTRAINT PK_LANGUAGE_SEQ PRIMARY KEY(LANGUAGE_SEQ),
	CONSTRAINT FK_LANGUAGE_MEMBER_CODE FOREIGN KEY(LANGUAGE_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);

SELECT * FROM LANGUAGE;
DELETE FROM LANGUAGE;

-- 외국어 INSERT
INSERT INTO LANGUAGE
VALUES(LANGUAGE_SEQ.NEXTVAL, (SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 4), '영어');

----------------- 외국어 자격증 테이블
-- 외국어 자격증 시퀀스
DROP SEQUENCE LANGUAGE_CERTIFICATE_SEQ;
CREATE SEQUENCE LANGUAGE_CERTIFICATE_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;
	
-- 외국어 자격증 테이블
DROP TABLE LANGUAGE_CERTIFICATE;
CREATE TABLE LANGUAGE_CERTIFICATE(
	LANGUAGE_CERTIFICATE_SEQ NUMBER NOT NULL,
	LANGUAGE_SEQ NUMBER NOT NULL,
	LANGUAGE_CERTIFICATE_NAME VARCHAR2(100),
	LANGUAGE_CERTIFICATE_GRADE VARCHAR2(100),
	
	CONSTRAINT PK_LANGUAGE_CERTIFICATE_SEQ PRIMARY KEY(LANGUAGE_CERTIFICATE_SEQ),
	CONSTRAINT FK_LANGUAGE_SEQ FOREIGN KEY(LANGUAGE_SEQ) REFERENCES LANGUAGE(LANGUAGE_SEQ) ON DELETE CASCADE
);

SELECT * FROM LANGUAGE_CERTIFICATE;
DELETE FROM LANGUAGE_CERTIFICATE;

INSERT INTO LANGUAGE_CERTIFICATE
VALUES(LANGUAGE_SEQ.NEXTVAL, (SELECT LANGUAGE_SEQ FROM LANGUAGE WHERE LANGUAGE_MEMBER_CODE = 4),'어학 시험','800/A')
	
	
	
----------------- 학력
-- 학력 시퀀스
DROP SEQUENCE SCHOOL_SEQ;
CREATE SEQUENCE SCHOOL_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;
	
-- 학력 테이블
DROP TABLE SCHOOL;
CREATE TABLE SCHOOL(
	SCHOOL_SEQ NUMBER NOT NULL,
	SCHOOL_MEMBER_CODE NUMBER NOT NULL,
	SCHOOL_NAME VARCHAR2(100),
	SCHOOL_MAJOR VARCHAR2(100),
	SCHOOL_DEGREE VARCHAR2(100),
	SCHOOL_OF_START DATE,
	SCHOOL_OF_END DATE,
	SCHOOL_CREDIT NUMBER,
	SCHOOL_MAXCREDIT NUMBER,
	SCHOOL_EXPLANATION VARCHAR2(1000),
	
	CONSTRAINT PK_SCHOOL_SEQ PRIMARY KEY(SCHOOL_SEQ),
	CONSTRAINT FK_SCHOOL_MEMBER_CODE FOREIGN KEY(SCHOOL_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);

SELECT * FROM SCHOOL;
DELETE FROM SCHOOL;

-- 학력 INSERT
INSERT INTO SCHOOL
VALUES(SCHOOL_SEQ.NEXTVAL, (SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 4), '학교이름','전공','학사',to_date('03-01-2012','MM-DD-YYYY'),
to_date('08-22-2018','MM-DD-YYYY'),4.0,4.5,'설명좀해주세요');

---------------- 수상경력
-- 수상경력 시퀀스
DROP SEQUENCE CERTIFICATE_SEQ;
CREATE SEQUENCE CERTIFICATE_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;

-- 수상경력 테이블
DROP TABLE CERTIFICATE
CREATE TABLE CERTIFICATE(
	CERTIFICATE_SEQ NUMBER NOT NULL,
	CERTIFICATE_MEMBER_CODE NUMBER,
	CERTIFICATE_NAME VARCHAR2(100),
	CERTIFICATE_DATE DATE,
	CERTIFICATE_LINK VARCHAR2(100),
	CERTIFICATE_EX_TEXT VARCHAR2(1000),
	
	CONSTRAINT PK_CERTIFICATE_SEQ PRIMARY KEY(CERTIFICATE_SEQ),
	CONSTRAINT FK_CERTIFICATE_MEMBER_CODE FOREIGN KEY(CERTIFICATE_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE

);

SELECT * FROM CERTIFICATE;
DELETE FROM CERTIFICATE;

-- 수상 경력 INSERT
INSERT INTO CERTIFICATE
VALUES(CERTIFICATE_SEQ.NEXTVAL,(SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 4), '자격증 이름',TO_DATE('03-01-2012','MM-DD-YYYY'), '링크','설명');
	
------------------ 저장소
--저장소 시퀀스
DROP SEQUENCE STORAGE_SEQ;
CREATE SEQUENCE STORAGE_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;

-- 저장소 테이블

DROP TABLE STORAGE;
CREATE TABLE STORAGE(
	STORAGE_SEQ NUMBER NOT NULL,
	STORAGE_MEMBER_CODE NUMBER NOT NULL,
	STORAGE_LINK VARCHAR2(100),
	STORAGE_HOMEPAGE_LINK VARCHAR2(100),
	
	CONSTRAINT PK_STORAGE_SEQ PRIMARY KEY(STORAGE_SEQ),
	CONSTRAINT FK_STORAGE_MEMBER_CODE FOREIGN KEY(STORAGE_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);

SELECT * FROM STORAGE;
DELETE FROM STORAGE;

--저장소 INSERT
INSERT INTO STORAGE
VALUES(STORAGE_SEQ.NEXTVAL, (SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 2), '링크', '홈페이지 링크');
	
	
--직군, 연봉 시퀀스
DROP SEQUENCE WORK_SEQ;
CREATE SEQUENCE WORK_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;
	
--직군, 연봉 테이블
DROP TABLE WORK;
CREATE TABLE WORK(
	WORK_SEQ NUMBER NOT NULL,
	WORK_MEMBER_CODE NUMBER NOT NULL,
	LINE_OF_WORK VARCHAR2(100),
	INCOME NUMBER,
	
	CONSTRAINT PK_WORK_SEQ PRIMARY KEY(WORK_SEQ),
	CONSTRAINT FK_WORK_MEMBER_CODE FOREIGN KEY(WORK_MEMBER_CODE)REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);

SELECT * FROM WORK;
DELETE FROM WORK;

--직군, 연봉 INSERT 
INSERT INTO WORK 
VALUES(WORK_SEQ.NEXTVAL, (SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 4), '직군', 5000);
------------------------ 캘린더
-- 캘린더 시퀀스
DROP SEQUENCE CALENDER_SEQ;
CREATE SEQUENCE CALENDER_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;
	
-- 캘린더 테이블
DROP TABLE CALENDER;
CREATE TABLE CALENDER(
	CALENDER_SEQ NUMBER NOT NULL,
	CALENDER_MEMBER_CODE NUMBER NOT NULL,
	CALENDER_DATE DATE,
	VALENDER_SUCCESS NUMBER,
	
	CONSTRAINT PK_CALENDER_SEQ PRIMARY KEY(CALENDER_SEQ),
	CONSTRAINT FK_CALENDER_MEMBER_CODE FOREIGN KEY(CALENDER_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
);

SELECT * FROM CALENDER;
DELETE FROM CALENDER;

--캘린더 INSERT
INSERT INTO CALENDER
VALUES(CALENDER_SEQ.NEXTVAL,(SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 2),TO_DATE('02-13-2020','MM-DD-YYYY'),88);

----------------- 설문조사
--설문조사 시퀀스
DROP SEQUENCE SURVEY_SEQ;
CREATE SEQUENCE SURVEY_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;

-- 설문조사 테이블
DROP TABLE SURVEY;
CREATE TABLE SURVEY(
	SURVEY_SEQ NUMBER NOT NULL,
	SURVEY_MEMBER_CODE NUMBER NOT NULL,
	SURVEY_DATA VARCHAR2(100),
	
	CONSTRAINT PK_SURVEY_SEQ PRIMARY KEY (SURVEY_SEQ),
	CONSTRAINT FK_SURVEY_MEMBER_CODE FOREIGN KEY(SURVEY_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
	
);

SELECT * FROM SURVEY;
DELETE FROM SURVEY;

INSERT INTO SURVEY
VALUES(SURVEY_SEQ.NEXTVAL,(SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE = 2),'설문조사 데이터입니다.');

----------------- ACTION 게시판
-- ACTION 시퀀스
DROP SEQUENCE ACTION_SEQ;
CREATE SEQUENCE ACTION_SEQ
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999
	NOCYCLE
	NOCACHE;
	
--ACTION 테이블
DROP TABLE ACTION_TABLE;
CREATE TABLE ACTION_TABLE(
	ACTION_SEQ NUMBER NOT NULL,
	ACTION_MEMBER_CODE NUMBER NOT NULL,
	ACTION_NAME VARCHAR2(100),
	ACTION_START_DATE DATE,
	ACTION_END_DATE DATE,
	ACTION_LINK VARCHAR2(100),
	ACTION_EX_TEXT VARCHAR2(1000),
	
	CONSTRAINT PK_ACTION_SEQ PRIMARY KEY (ACTION_SEQ),
	CONSTRAINT FK_ACTION_MEMBER_CODE FOREIGN KEY(ACTION_MEMBER_CODE) REFERENCES MEMBER(MEMBER_CODE) ON DELETE CASCADE
	
);

SELECT * FROM ACTION_TABLE;
SELECT COUNT(*) FROM ACTION_TABLE;

DELETE FROM ACTION_TABLE;

INSERT INTO ACTION_TABLE
VALUES(ACTION_SEQ.NEXTVAL,(SELECT MEMBER_CODE FROM MEMBER WHERE MEMBER_CODE= 4),'활동이름',TO_DATE('02-13-2020','MM-DD-YYYY'),TO_DATE('02-13-2020','MM-DD-YYYY'),'활동 링크 주소','활동 기타 설명');

UPDATE CAREER_DETAIL SET 
PERFORMANCE = '커리어 엑셀부스터', START_DATE = to_date('2010-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS'),
END_DATE = to_date('2010-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS'),DETAIL_CONTEXT = '나로호'
WHERE CAREER_DETAIL_CAREER_SEQ = 1
AND CAREER_DETAIL_SEQ = 2















