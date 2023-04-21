--1) SCORE 테이블과 동일한 구조를 갖는 SCORE_CHK를 생성하고 RESULT 60이상 90이하만 입력 가능하도록 하세요.
CREATE TABLE SCORE_CHK(
        SNO VARCHAR2(8),
        CNO VARCHAR2(8),
        RESULT NUMBER(3,0),
        CONSTRAINT CHK_SCORE CHECK(RESULT >= 60 AND RESULT <= 90)
);


CREATE TABLE SCORE_CHK1(
    CNO NUMBER,
    SNO NUMBER,
    RESULT NUMBER,
    CONSTRAINT CHK_SCORE_RES CHECK(RESULT BETWEEN 60 AND 90)
);

INSERT INTO SCORE_CHK1
VALUES (1, 1, 5);

INSERT INTO SCORE_CHK1
VALUES (1, 1, 90);

--2) STUDENT 테이블과 동일한 구조를 갖는 STUDENT_COPY 테이블을 생성하면서 SNO은 PK로 SNAME은 NOT NULL로 SYEAR의 DEFAULT는 1로 
--   설정하세요.
CREATE TABLE STUDENT_COPY(
        SNO VARCHAR2(8),
        SNAME VARCHAR2(20) NOT NULL,
        SEX VARCHAR2(3),
        SYEAR NUMBER(1,0) DEFAULT 1,
        MAJOR VARCHAR2(20),
        AVR NUMBER(4,2),
        CONSTRAINT PK_SNO_CP PRIMARY KEY(SNO)
);

CREATE TABLE STUDENT_COPY1(
    SNO NUMBER,
    SNAME VARCHAR2(20) NOT NULL,
    MAJOR VARCHAR2(10),
    SYEAR NUMBER(1) DEFAULT 1,
    CONSTRAINT PK_ST_SNO1 PRIMARY KEY(SNO)
    );
    
INSERT INTO STUDENT_COPY1(
    SNO,
    SNAME,
    MAJOR)
    VALUES (
    1,
    NULL,
    NULL
    );

INSERT INTO STUDENT_COPY1(
    SNO,
    SNAME,
    MAJOR)
    VALUES (
    1,
    'A',
    NULL
    );

INSERT INTO STUDENT_COPY1(
    SNO,
    SNAME,
    MAJOR)
    VALUES (
    2,
    'B',
    NULL
    );

SELECT *
    FROM STUDENT_COPY1;

--3) COURSE 테이블과 동일한 구조를 갖는 COURSE_CONTSRAINT 테이블을 생성하면서 CNO, CNAME을 PK로 PNO은 PROFESSOR_PK의 PNO을 참조하여
--   FK로 설정하고 ST_NUM은 DEFAULT 2로 설정하세요.
CREATE TABLE COURSE_CONSTRAINT(
        CNO VARCHAR2(8),
        CNAME VARCHAR2(20),
        ST_NUM NUMBER(1,0) DEFAULT 2,
        PNO VARCHAR2(8),
        CONSTRAINT PK_COURSE_CNO_CNAME PRIMARY KEY(CNO, CNAME),
        CONSTRAINT FK_COURSE_PNO FOREIGN KEY(PNO)
            REFERENCES PROFESSOR_PK(PNO)
);


CREATE TABLE COURSE_CONSTRAINT1(
    CNO NUMBER,
    CNAME VARCHAR2(10),
    ST_NUMBER NUMBER(1) DEFAULT 2,
    PNO NUMBER,
    CONSTRAINT PK_COURSE_CONST_CNO_CNAME PRIMARY KEY(CNO, CNAME),
    CONSTRAINT FK_COURSE_CONST_PNO FOREIGN KEY(PNO)
        REFERENCES PROFESSOR_PK1(PNO)
);

SELECT * 
    FROM PROFESSOR_PK1;

INSERT INTO PROFESSOR_PK1
VALUES (1, 'A', 'ENG', 'REGULAR', SYSDATE);
INSERT INTO PROFESSOR_PK1
VALUES (2, 'B', 'JAVA', 'REGULAR', SYSDATE);
INSERT INTO PROFESSOR_PK1
VALUES (3, 'C', 'MATH', 'REGULAR', SYSDATE);
INSERT INTO PROFESSOR_PK1
VALUES (4, 'D', 'GRAMMAR', 'REGULAR', SYSDATE);

INSERT INTO COURSE_CONSTRAINT1(
    CNO,
    CNAME,
    PNO )
VALUES (
    1,
    'GRAMMAR',
    3
);



--4) 다음 구조를 갖는 테이블을 생성하세요.
--   T_SNS                              T_SNS_DETAIL                        T_SNS_UPLOADED
--   SNS_NO(PK)    SNS_NM               SNS_NO(PK, FK)   SNS_BEN            SNS_NO(PK, FK)    SNS_UPL_NO(PK)
--     1            페북                   1               4000                   1                  1
--     2           인스타                  2               10000                  1                  2
--     3           트위터                  3               30000                  2                  1
--                                                                               2                  2

--관계를 고려해서 만들면 좋겠다.
--SNS_NM만 VARCHAR(10~20) 정도로 주고 나머지는 NUMBER로 줘도 된다.
CREATE TABLE T_SNS(
        SNS_NO NUMBER PRIMARY KEY,
        SNS_NM VARCHAR2(20)
);

CREATE TABLE T_SNS1(
        SNS_NO NUMBER,
        SNS_NM VARCHAR2(20),
        CONSTRAINT PK_SNS_NO PRIMARY KEY(SNS_NO)
);


CREATE TABLE T_SNS_DETAIL(
        SNS_NO NUMBER,
        SNS_BEN NUMBER,
        CONSTRAINT PK_T_SNS_DETAIL_NO PRIMARY KEY(SNS_NO),
        CONSTRAINT FK_T_SNS_DETAIL_NO FOREIGN KEY(SNS_NO)
            REFERENCES T_SNS(SNS_NO)
);

CREATE TABLE T_SNS_DETAIL1(
        SNS_NO NUMBER,
        SNS_BEN NUMBER(6),
        CONSTRAINT PK_SNS_DET_NO PRIMARY KEY(SNS_NO),
        CONSTRAINT FK_SNS_DET_NO FOREIGN KEY(SNS_NO)
            REFERENCES T_SNS1(SNS_NO)

);

CREATE TABLE T_SNS_UPLOADED(
        SNS_NO NUMBER,
        SNS_UPL_NO NUMBER,
        CONSTRAINT PK_T_SNS_UPLOADED_NO_UPL_NO PRIMARY KEY(SNS_NO, SNS_UPL_NO),
        CONSTRAINT FK_T_SNS_UPLOADED_NO FOREIGN KEY(SNS_NO)
            REFERENCES T_SNS(SNS_NO)
);


CREATE TABLE T_SNS_UPLOADED1(
    SNS_NO NUMBER,
    SNS_UP_NO NUMBER,
    CONSTRAINT PK_SNS_UP_NO PRIMARY KEY(SNS_NO, SNS_UP_NO), --두개 다 같아야 중복으로 잡는다.
    CONSTRAINT FK_SNS_UP_NO FOREIGN KEY(SNS_NO)
        REFERENCES T_SNS1(SNS_NO) --참조가 T_SNS1이 두번일어남. 두 테이블 모두에 영향을 준다!
);


INSERT INTO T_SNS VALUES(1, '페북');
INSERT INTO T_SNS VALUES(2, '인스타');
INSERT INTO T_SNS VALUES(3, '트위터');

INSERT INTO T_SNS_DETAIL VALUES(1, 4000);
INSERT INTO T_SNS_DETAIL VALUES(2, 10000);
INSERT INTO T_SNS_DETAIL VALUES(3, 30000);

INSERT INTO T_SNS_UPLOADED VALUES(1, 1);
INSERT INTO T_SNS_UPLOADED VALUES(1, 2);
INSERT INTO T_SNS_UPLOADED VALUES(2, 1);
INSERT INTO T_SNS_UPLOADED VALUES(2, 2);

SELECT * FROM T_SNS;
SELECT * FROM T_SNS_DETAIL;
SELECT * FROM T_SNS_UPLOADED;


INSERT INTO T_SNS1
VALUES(1, '페북');

INSERT INTO T_SNS_DETAIL1
VALUES(1, 3000);

INSERT INTO T_SNS_UPLOADED1
VALUES(1, 1);
INSERT INTO T_SNS_UPLOADED1
VALUES(1, 2);
INSERT INTO T_SNS_UPLOADED1
VALUES(1, 3);
INSERT INTO T_SNS_UPLOADED1
VALUES(1, 4);

SELECT * FROM T_SNS1;
SELECT * FROM T_SNS_DETAIL1;
SELECT * FROM T_SNS_UPLOADED1;