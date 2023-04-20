--1. CONSTRAINT
--1-1. PRIMARY KEY
--단일 컬럼 PK 테이블 생성
CREATE TABLE EMP_PK1(
    --CONSTRAINT 제약조건명을 생략하면 제약조건명을 SYSTEM에서 자동으로 생성해준다.
    ENO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    MGR NUMBER,
    HDATE DATE,
    DNO NUMBER
); --시스템이 생성하는 키


CREATE TABLE DEPT_PK1(
    DNO NUMBER,
    DNAME VARCHAR2(10),
    LOC VARCHAR2(10),
    DIRECTOR NUMBER,
    CONSTRAINT PK_DEPT_DNO PRIMARY KEY(DNO) --괄호로 잘 지정해주면 좋습니다.
); --내가 만든 이름 가진 키


--중복허용 확인
INSERT INTO DEPT_PK1
VALUES (1, '개발', '부산', 1);

--중복 안됨. ORA-00001: 무결성 제약 조건(C##STUDY.PK_DEPT_DNO)에 위배됩니다
--INSERT INTO DEPT_PK1
--VALUES (1, '개발2', '부산', 2);

INSERT INTO DEPT_PK1
VALUES (2, '개발2', '부산', 2);


--PK에 NULL 저장 : PK에 NULL값 불가
INSERT INTO EMP_PK1
VALUES(NULL, NULL, NULL, NULL, NULL, NULL);

--PK말고 NULL 저장1 : 가능
INSERT INTO EMP_PK1
VALUES(1, NULL, NULL, NULL, NULL, NULL);

--PK빼고 NULL 저장2(중복X) : 가능
INSERT INTO EMP_PK1
VALUES(2, NULL, NULL, NULL, NULL, NULL);


SELECT *
    FROM DEPT_PK1;
    
SELECT *
    FROM EMP_PK1;    



--다중 컬럼 PK 지정
--다중 컬럼 PK 지정시 아래 방법은 허용 안됨
--에러: ORA-02260: 테이블에는 하나의 기본 키만 가질 수 있습니다.
CREATE TABLE SCORE_PK1 (
    CNO NUMBER PRIMARY KEY,
    SNO NUMBER PRIMARY KEY,
    RESULT NUMBER
);

--다중 컬럼 PK 지정 방식
CREATE TABLE SCORE_PK1 (
    CNO NUMBER,
    SNO NUMBER,
    RESULT NUMBER,
    CONSTRAINT PK_SCORE_CNO_SNO PRIMARY KEY(CNO, SNO) --이 두 값이 쌍으로 PK가 되며 두 값 모두 중복 없어야 실행된다.
);


--다중 컬럼 PK는 다중 컬럼이 PK쌍이 된다.
--PK로 지정된 모든 컬럼의 값이 "쌍으로" 중복돼야 중복으로 인식
--EX)게시글 번호에 다중 첨부파일 올릴때 유용하다!?
INSERT INTO SCORE_PK1 
VALUES(1, 1, 100);

INSERT INTO SCORE_PK1 
VALUES(1, 2, 99);

INSERT INTO SCORE_PK1 
VALUES(1, 3, 98);

INSERT INTO SCORE_PK1 
VALUES(1, 1, 97);


SELECT *
    FROM SCORE_PK1;
    

--PK 추가
ALTER TABLE DEPT
    ADD CONSTRAINT PK_DEP_DNO PRIMARY KEY(DNO);

--SCORE 테이블에 CNO, SNO PK 추가
ALTER TABLE SCORE
    ADD CONSTRAINT PK_SCO_CNO_SNO PRIMARY KEY(CNO, SNO);


--PK 삭제
--제약조건과 데이터 함께 삭제
ALTER TABLE DEPT
    DROP CONSTRAINT PK_DEP_DNO;
    
--ALTER TABLE DEPT
--    DROP PRIMARY KEY;



--1-2. FOREIGN KEY(테이블간의 관계를 맺어줌)
--DEPT_PK1의 DNO을 참조하여 EMP_PK1의 DNO을 FK로 생성
DROP TABLE EMP_PK1;

CREATE TABLE EMP_PK_FK1(
        ENO NUMBER PRIMARY KEY,
        ENAME VARCHAR2(20),
        JOB VARCHAR2(10),
        MGR NUMBER,
        HDATE DATE,
        SAL NUMBER(10, 3),
        COMM NUMBER(5, 2), --전체 5자리 + 소수점 2자리
        DNO NUMBER CONSTRAINT FK_EMP_DNO --열을 지정할 때만 FOREGIN KEY 필요, 아니면 빼야함.
                        REFERENCES DEPT_PK1(DNO)
);        


--FK에 데이터 추가
--FK는 NULL(x), 중복데이터 허용, index도 아닙니다.
INSERT INTO EMP_PK_FK1
VALUES (1, '홍길동', '개발', 0, SYSDATE, 3000, 300, 1);--마지막 DNO 자리에는 DEPT_PK1 에 있는 정보만 사용해야 합니다.

INSERT INTO EMP_PK_FK1
VALUES (2, '장길산', '분석', 0, SYSDATE, 3200, 320, 2);--마지막 DNO 자리에는 DEPT_PK1 에 있는 정보만 사용해야 합니다.

INSERT INTO EMP_PK_FK1
VALUES (3, '임꺽정', '개발', 0, SYSDATE, 3000, 300, 1);--마지막 DNO 자리에는 DEPT_PK1 에 있는 정보만 사용해야 합니다. 외래키는 중복 허용합니다. 1로 다시 넣어도 됨.

--에러: 부모테이블에 없는 값(DEPT_PK1.DNO)은 저장할 수 없다.
INSERT INTO EMP_PK_FK1
VALUES (4, '고기천', '개발', 0, SYSDATE, 3000, 300, 3);--DNO 자리에는 DEPT_PK1 부모 테이블에 있는 정보만 사용해야 합니다.


SELECT *
    FROM EMP_PK_FK1;

--부모테이블과 쉽게 구분 가능!    
SELECT A.*
     , B.DNAME
     , B.LOC
     , B.DIRECTOR
    FROM EMP_PK_FK1 A
    JOIN DEPT_PK1 B --내가 부모테이블!
    ON A.DNO = B.DNO;


--CASCADE 옵션이 없을 때 부모테이블의 데이터의 수정이나 삭제가 불가능
--점유된 데이터를 자식테이블에서 제거하면 부모테이블에서 수정/삭제 가능
--점유안된 데이터들은 바로 부모테이블에서도 수정/삭제 가능
--부모테이블의 데이터는 자식테이블에서 사용중이기 때문에 함부로 삭제/수정을 할 수 없도록 막아놓음.
--자식테이블의 데이터를 먼저 삭제나 다른 데이터로 변경을 진행하고 부모테이블의 데이터를 삭제/수정을 해야 한다.

DELETE FROM DEPT_PK1 --부모테이블
    WHERE DNO = 1; --자식데이터가 걸려있으니 삭제가 안된다.
    
UPDATE DEPT_PK1
    SET
        DNO = 3
    WHERE DNO = 1; --1번으로 사용되는 자식이 없으니 바로 부모 테이블 수정이 가능하다!!
    

UPDATE EMP_PK_FK1
    SET
        DNO = 2
--        DNO = 3 --부모테이블에 존재하지 않아서 수행 불가능하다.
        WHERE DNO = 1; --잠깐 자식테이블만 조정해본다.


UPDATE EMP_PK_FK1
    SET
        DNO = 3
        WHERE DNO = 2
          AND JOB = '개발'; --다시 2번이고 개발인 인원 번호를 3번으로 변경.
          


UPDATE DEPT_PK1
    SET
        LOC = '천안',
        DNAME = '개발3'
    WHERE DNO = 3;
    
INSERT INTO DEPT_PK1
VALUES(1, '개발1', '서울', 1);



--DEPT_PK1(부모) DNO 2,3은 EMP_PK_FK1 (자식)에서 점유, DNO 1은 EMP_PK_FK1 (자식)에서 점유되어 있지 않기 때문에
--DNO 2, 3은 수정/삭제 불가능, DNO 1은 수정/삭제가 가능


--DNO 3의 데이터 점유를 해지(DNO 1로 보내고) DNO 3 데이터 부모테이블에서 삭제

UPDATE EMP_PK_FK1
    SET
        DNO = 1
    WHERE DNO = 3;
        
DELETE FROM DEPT_PK1 --부모테이블
   WHERE DNO = 3; --자식데이터에서 DNO 3 점유 해지했으니 삭제가 될 것이다!!
           
SELECT *
    FROM DEPT_PK1;



--CASCADE 옵션 추가된 FK 생성


CREATE TABLE EMP_PK_FK2(
        ENO NUMBER PRIMARY KEY,
        ENAME VARCHAR2(20),
        JOB VARCHAR2(10),
        MGR NUMBER,
        HDATE DATE,
        SAL NUMBER(10, 3),
        COMM NUMBER(5, 2), --전체 5자리 + 소수점 2자리
        DNO NUMBER,
        CONSTRAINT FK_EMP_DNO2 FOREIGN KEY(DNO) --남은 제약조건명으로는 만들 수 없어서 다르게 외래키 이름을 부여해야 합니다!
                        REFERENCES DEPT_PK1(DNO)
                        ON DELETE CASCADE
                        --ON UPDATE CASCADE는 ORACLE에서 지원하지 않는다!!
);  


--제약조건 목록 조회
--남은 제약조건명으로는 만들 수 없어서 동일한 거 안씀
SELECT * FROM ALL_CONSTRAINTS
    WHERE OWNER = 'C##STUDY';

--데이터 저장
INSERT INTO DEPT_PK1
VALUES(1, '개발1', '서울', 1);

INSERT INTO DEPT_PK1
VALUES(2, '개발2', '부산', 2);



INSERT INTO EMP_PK_FK2
VALUES(1, '홍길동', '개발', 0, SYSDATE, 3000, 300, 1);

INSERT INTO EMP_PK_FK2
VALUES(2, '장길산', '개발', 0, SYSDATE, 3000, 300, 2);

SELECT *
    FROM DEPT_PK1;

SELECT *
    FROM EMP_PK_FK2; 

--DELETE CASCADE 옵션일 때 부모데이터 삭제
--오라클에서는 UPDATE CASCADE는 지원안됨
--DELETE CASCADE 옵션은 부모테이블 데이터를 삭제할 수 있게 해주는데
--부모테이블에서 삭제되는 데이터를 참조하고 있는 자식테이블의 데이터도 같이 삭제된다.
--UPDATE CASCADE 옵션은 부모테이블의 데이터를 수정할 수 있다.
--부모테이블에서 수정되는 데이터를 참조하고 있는 자식테이블의 데이터도 같이 수정된다.
DELETE FROM DEPT_PK1
    WHERE DNO = 1;
    
ALTER TABLE EMP_PK_FK1 
    DROP CONSTRAINT FK_EMP_DNO; --DEPT_PK1과 관계가 있다. 1에 물린 외래키를 삭제해줍니다! 원활한 삭제를 위함입니다.

--DELETE FROM DEPT_PK1; --이러면 부모(DEPT_PK1), 자식(EMP_PK_FK2)도 함께 삭제가 됩니다.

SELECT *
    FROM EMP_PK_FK2; 


--FK 관계의 종류
--1:1 부모테이블 데이터 1개당 자식테이블 데이터 1개가 생성되는 구조
--부모테이블의 PK, UK 컬럼이 자식테이블의 FK면서 PK,UK로 잡혀야된다.
CREATE TABLE T_USER(
        USER_ID VARCHAR(20) PRIMARY KEY,
        PASSWORD VARCHAR2(50),
        JOIN_DATE DATE
);


INSERT INTO T_USER
VALUES('gogi', '1234', SYSDATE); --하나만 존재
--gogi 아이디 더이상 못만듦.
COMMIT;


CREATE TABLE T_USER_DETAIL(
        USER_ID VARCHAR2(20) PRIMARY KEY,
        USER_NAME VARCHAR2(20),
        USER_EMAIL VARCHAR2(100),
        USER_TEL NUMBER(11),
        CONSTRAINT FK_USER_ID FOREIGN KEY(USER_ID)
            REFERENCES T_USER(USER_ID)
);        


INSERT INTO T_USER_DETAIL
VALUES('gogi', NULL, NULL, NULL); --하나만 존재할 수 있다.

COMMIT;

--1: N 관계
--부모테이블의 데이터 1개로 자식테이블 데이터 여러개를 생성할 수 있는 관계
--DEPT_PK1과 EMP_PK_FK100는 1:N관계
--DEPT_PK1의 PK인 DNO으로 EMP_PK_FK2에서는 여러개의 데이터(중복)을 생성할 수 있기 때문에 1:N관계
--T_BOARD, T_BOARD_FILE을 1:N관계로 만들어보기
DROP TABLE T_BOARD_FILE;


CREATE TABLE T_BOARD_FILE(
        BOARD_NO NUMBER,
        BOARD_FILE_NO NUMBER,
        BOARD_FILE_NM VARCHAR2(200),
        BOARD_FILE_PATH VARCHAR2(2000),
        ORIGIN_FILE_NM VARCHAR2(200),
        CONSTRAINT PK_BF_BOARD_FILE_NO PRIMARY KEY (BOARD_NO, BOARD_FILE_NO), --다중컬럼이므로 PK에서는 문제 없음.(1,1), (1,2), ... (1, N) 가능.
        CONSTRAINT PK_BOARD_BOARD_NO FOREIGN KEY(BOARD_NO)
            REFERENCES T_BOARD(BOARD_NO)
);

INSERT INTO T_BOARD
VALUES(1, NULL, NULL, NULL, NULL, NULL); --이거는 더이상 PK 1인 데이터 입력 불가.


INSERT INTO T_BOARD_FILE
VALUES(1, 1, NULL, NULL, NULL);

INSERT INTO T_BOARD_FILE
VALUES(1, 2, NULL, NULL, NULL); --이거는 여러개 파일 데이터 생성이 가능하다. (1,1 ~ N개)
INSERT INTO T_BOARD_FILE
VALUES(1, 3, NULL, NULL, NULL); --이거는 여러개 파일 데이터 생성이 가능하다. (1,1 ~ N개)
INSERT INTO T_BOARD_FILE
VALUES(1, 4, NULL, NULL, NULL); --이거는 여러개 파일 데이터 생성이 가능하다. (1,1 ~ N개)
INSERT INTO T_BOARD_FILE
VALUES(1, 5, NULL, NULL, NULL); --이거는 여러개 파일 데이터 생성이 가능하다. (1,1 ~ N개)




--1-3. Unique Key
--UK 생성
CREATE TABLE EMP_UK(
    ENO NUMBER CONSTRAINT UK_EMP_ENO UNIQUE,
    ENAME VARCHAR2(20)
);

--데이터 저장
INSERT INTO EMP_UK
VALUES(1, '홍길동');

INSERT INTO EMP_UK
VALUES(1, '장길산'); --ORA-00001: 무결성 제약 조건(C##STUDY.UK_EMP_ENO)에 위배됩니다

INSERT INTO EMP_UK
VALUES(2, '장길산'); --해결.


--NULL값은 중복 저장 가능합니다.
INSERT INTO EMP_UK
VALUES(NULL, '홍길동1');
INSERT INTO EMP_UK
VALUES(NULL, '홍길동2');
INSERT INTO EMP_UK
VALUES(NULL, '홍길동3');
INSERT INTO EMP_UK
VALUES(NULL, '홍길동4');
INSERT INTO EMP_UK
VALUES(NULL, '홍길동5');
COMMIT;

SELECT *
    FROM EMP_UK;


--1-4. CHECK
--체크 생성
CREATE TABLE EMP_CHK(
    ENO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    MGR NUMBER,
    SAL NUMBER(11, 3),
    COMM NUMBER(5, 2),
    CONSTRAINT CHK_EMP_SAL CHECK(SAL >= 3000),
    CONSTRAINT CHK_EMP_COMM CHECK(COMM BETWEEN 100 AND 1000)
);

--CHECK 조건에 맞지 않는 데이터 저장
INSERT INTO EMP_CHK
VALUES(1, NULL, NULL, 0, 1000, 900); -- ORA-02290: 체크 제약조건(C##STUDY.CHK_EMP_SAL)이 위배되었습니다

INSERT INTO EMP_CHK
VALUES(1, NULL, NULL, 0, 3000, 500);

















