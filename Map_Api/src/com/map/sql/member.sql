DROP SEQUENCE MEMBERSEQ;
DROP TABLE MEMBER_MAP;

CREATE SEQUENCE MEMBERSEQ;
CREATE TABLE MEMBER_MAP(
	MEMBER_CODE NUMBER PRIMARY KEY,
	MEMBER_PROFILE_LATITUDE VARCHAR2(100),
	MEMBER_PROFILE_LOGITUDE VARCHAR2(100)
); 
			

INSERT INTO MEMBER_MAP
VALUES(MEMBERSEQ.NEXTVAL,'3.450701','126.570667')

SELECT MEMBER_PROFILE_LATITUDE, MEMBER_PROFILE_LOGITUDE FROM MEMBER_MAP