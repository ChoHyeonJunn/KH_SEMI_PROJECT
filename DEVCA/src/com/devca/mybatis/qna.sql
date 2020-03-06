--질문게시판 시퀀스
DROP SEQUENCE QNA_BOARD_NO_SEQ;
DROP SEQUENCE QNA_GROUP_NO_SEQ;
DROP SEQUENCE QNA_POST_NO_SEQ;
DROP TABLE QNA_BOARD;


--질문 테이블
CREATE SEQUENCE QNA_BOARD_NO_SEQ; --고유번호
CREATE SEQUENCE QNA_POST_NO_SEQ; -- 글 번호
CREATE SEQUENCE QNA_GROUP_NO_SEQ;	-- 그룹 번호

CREATE TABLE QNA_BOARD(
	QNA_BOARD_NO NUMBER PRIMARY KEY,
	QNA_POST_NO NUMBER,
	QNA_GROUP_NO NUMBER NOT NULL,
	QNA_GROUP_SEQ NUMBER NOT NULL, 
	QNA_TITLE_TAB NUMBER NOT NULL,
	QNA_TITLE VARCHAR2(1000) NOT NULL,
	QNA_CONTENT CLOB NOT NULL,
	QNA_WRITER VARCHAR2(1000) NOT NULL,
	QNA_DATE DATE NOT NULL
);

SELECT *
FROM(SELECT A.*, ROWNUM AS RNUM
FROM(SELECT * FROM QNA_BOARD ORDER BY QNA_BOARD_NO desc)A)
WHERE RNUM > 0 AND RNUM <= 3;


SELECT * FROM QNA_BOARD;

-- 첫번째 글 작성
INSERT INTO ANSWERBOARD
VALUES(BOARDNOSEQ.NEXTVAL,POSTNOSEQ.NEXTVAL,GROUPNOSEQ.NEXTVAL,1,0,
'1번글 입니다.','1번글 내용입니다.','관리자',SYSDATE);

--두번째 글 작성
INSERT INTO ANSWERBOARD 
VALUES(BOARDNOSEQ.NEXTVAL,POSTNOSEQ.NEXTVAL,GROUPNOSEQ.NEXTVAL, 1, 0,
'2번글 입니다.', '2번글 내용입니다.', '학생1', SYSDATE);