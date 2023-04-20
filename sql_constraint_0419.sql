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



--1-2. FOREIGN KEY
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
VALUES(1, '개발1', '서울', 0);

INSERT INTO DEPT_PK1
VALUES(2, '개발2', '부산', 0);



INSERT INTO EMP_PK_FK2
VALUES(1, '홍길동', '개발', 0, SYSDATE, 3000, 300, 1);

INSERT INTO EMP_PK_FK2
VALUES(2, '장길산', '개발', 0, SYSDATE, 3000, 300, 2);

SELECT *
    FROM EMP_PK_FK2; 

--DELETE CASCADE 옵션일 때 부모데이터 삭제
ALTER TABLE EMP_PK_FK1
    DROP CONSTRAINT FK_EMP_DNO; --1에 물린 외래키를 삭제해줍니다! 원활한 삭제를 위함입니다.

DELETE FROM DEPT_PK1; --이러면 부모(DEPT_PK1), 자식(EMP_PK_FK2)도 함께 삭제가 됩니다.

SELECT *
    FROM EMP_PK_FK2; 




