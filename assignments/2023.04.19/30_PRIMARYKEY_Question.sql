--1) CNO이 PK인 COURSE_PK 테이블을 생성하세요.(1번 방식으로)
CREATE TABLE COURSE_PK(
        CNO VARCHAR(8) PRIMARY KEY,
        CNAME VARCHAR2(20),
        ST_NUM NUMBER,
        PNO NUMBER
    );



CREATE TABLE COURSE_PK3(
                CNO NUMBER PRIMARY KEY,
                CNAME VARCHAR2(20),
                ST_NUM NUMBER(1),
                PNO NUMBER
);



--2) PNO이 PK인 PROFESSOR_PK 테이블을 생성하세요.(2번 방식으로)
CREATE TABLE PROFESSOR_PK(
        PNO VARCHAR(8),
        PNAME VARCHAR(20),
        SECTION VARCHAR(20),
        ORDERS VARCHAR(10),
        HIREDATE DATE,
        CONSTRAINT PK_PROFESSOR_PNO PRIMARY KEY(PNO)
);


CREATE TABLE PROFESSOR_PK1(
    PNO NUMBER,
    PNAME VARCHAR2(20),
    SECTION VARCHAR2(10),
    ORDERS VARCHAR2(10),
    HIREDATE DATE,
    CONSTRAINT PK_PF_PNO1 PRIMARY KEY(PNO)
);
    


--3) PF_TEMP 테이블에 PNO을 PK로 추가하세요.
ALTER TABLE PF_TEMP
    ADD CONSTRAINT PK_PF_PNO PRIMARY KEY(PNO);


ALTER TABLE PF_TEMP
    DROP PRIMARY KEY;

ALTER TABLE PF_TEMP
    ADD CONSTRAINT PK_PT_PNO PRIMARY KEY(PNO);





--4) COURSE_PROFESSOR 테이블에 CNO, PNO을 PK로 추가하세요.
ALTER TABLE COURSE_PROFESSOR
    ADD CONSTRAINT PK_CO_PRO_CNO_PNO PRIMARY KEY(CNO, PNO);



ALTER TABLE COURSE_PROFESSOR
    DROP PRIMARY KEY;
    
ALTER TABLE COURSE_PROFESSOR
    ADD CONSTRAINT PK_CP_CPNO PRIMARY KEY(CNO, PNO);

--5) BOARD_NO(NUMBER)를 PK로 갖으면서 BOARD_TITLE(VARCHAR2(200)), BOARD_CONTENT(VARCHAR2(2000)), 
--   BOARD_WRITER(VARCHAR2(20)), BOARD_FRGT_DATE(DATE), BOARD_LMDF_DATE(DATE) 컬럼을 갖는 T_BOARD 테이블을 생성하세요.
CREATE TABLE T_BOARD (
                        BOARD_TITLE VARCHAR2(200) PRIMARY KEY,
                        BOARD_CONTENT VARCHAR2(2000),
                        BOARD_WRITER VARCHAR2(20),
                        BOARD_FRGT_DATE DATE,
                        BOARD_LMDF_DATE DATE
);

CREATE TABLE SCORE_PK1 (
    CNO NUMBER,
    SNO NUMBER,
    RESULT NUMBER,
    CONSTRAINT PK_SCORE_CNO_SNO PRIMARY KEY(CNO, SNO) --이 두 값이 쌍으로 PK가 되며 두 값 모두 중복 없어야 실행된다.
);




DROP TABLE T_BOARD;
CREATE TABLE T_BOARD(
        BOARD_NO NUMBER PRIMARY KEY,
        BOARD_TITLE VARCHAR2(200),
        BOARD_CONTENT VARCHAR2(2000),
        BOARD_WRITER VARCHAR2(20),
        BOARD_FRGT_DATE DATE,
        BOARD_LMDF_DATE DATE
);




--6) BOARD_NO(NUMBER), BOARD_FILE_NO(NUMBER)를 PK로 갖으면서 BOARD_FILE_NM(VARCHAR2(200)), BOARD_FILE_PATH(VARCHAR2(2000)),
--   ORIGIN_FILE_NM(VARCHAR2(200)) 컬럼을 갖는 T_BOARD_FILE 테이블을 생성하세요.
CREATE TABLE T_BOARD_FILE (
                            BOARD_NO NUMBER,
                            BOARD_FILE_NO NUMBER,
                            BOARD_FILE_NM VARCHAR2(200),
                            BOARD_FILE_PATH VARCHAR2(2000),
                            ORIGIN_FILE_NM VARCHAR2(200),
                            CONSTRAINT PK_T_BD_FILE_NO_FINO PRIMARY KEY (BOARD_NO, BOARD_FILE_NO)
);

DROP TABLE T_BOARD_FILE;

--게시글 마다 첨부파일 멀티로 만들 수 있는 그런 것이다.
CREATE TABLE T_BOARD_FILE(
        BOARD_NO NUMBER,
        BOARD_FILE_NO NUMBER,
        BOARD_FILE_NM VARCHAR2(200),
        BOARD_FILE_PATH VARCHAR2(2000),
        ORIGIN_FILE_NM VARCHAR2(200),
        CONSTRAINT PK_BF_BOARD_FILE_NO PRIMARY KEY (BOARD_NO, BOARD_FILE_NO)
);