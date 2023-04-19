--1. 오라클 객체
--1-1. 데이터 사전
--study 계정이 사용할 수 있는 데이터 사전 조회
SELECT *
    FROM DICT;



--위와 같은 결과를 나타낸다. DICT, DICTIONARY;    
SELECT *
    FROM DICTIONARY;


--USER_xxxx : 현재 데이터베이스에 접속한 사용자가 소유한 객체들의 정보를 제공
SELECT *
    FROM DICTIONARY
    WHERE TABLE_NAME LIKE '%USER%';



SELECT *
    FROM DICTIONARY
    WHERE TABLE_NAME LIKE 'V$%';
    

--study계정이 가지고 있는 객체의 정보를 확인
--소유권이 study인 테이블 목록 조회
SELECT TABLE_NAME
    FROM USER_TABLES;


--OWNER 컬럼이 존재
--다른 사용자가 소유하고 있는 테이블의 권한만 가지고 있을 수도 있기 때문에
SELECT *
    FROM ALL_TABLES;

--OWNER 컬럼이 없음.
--현재 접속한 사용자가 소유한 테이블의 정보만 담고 있어서
SELECT *
    FROM USER_TABLES;
    


--study계정이 권한을 가지고 사용할 수 있는 모든 객체 정보
--study계정에 DBA 권한이 있어서 SYS가 소유하고 있는 테이블도 사용할 수 있다.
SELECT OWNER, TABLE_NAME
    FROM ALL_TABLES;


--데이터베이스 시스템 관련 정보들
SELECT *
    FROM DBA_TABLES;
    
    
    
    
--현재 데이터베이스에 접속한 세션정보 확인
SELECT SID --SID, SERIAL#로 세션을 종료할 수 있음!
     , OSUSER
     , SERIAL#
     , PROGRAM
    FROM V$SESSION;
    

--세션을 KILL해서 접속 끊어버리는 쿼리(DB 락걸렸을 때 이 쿼리로 세션 종료시키기)
--ALTER SYSTEM KILL SESSION 'sid,serial#' IMMEDIATE 
--ALTER SYSTEM KILL SESSION SESSION '128, 33497' IMMEDIATE;

--lock 걸린 객체를 확인
SELECT OBJECT_ID
     , SESSION_ID
     , ORACLE_USERNAME
     , OS_USER_NAME
    FROM V$LOCKED_OBJECT;
    
UPDATE PF_TEMP
    SET
        PNAME = 'aaa';

--락 걸린 세션 조회(조인해서 찾기)
SELECT L.OBJECT_ID --V$LOCKED_OBJECT
     , S.SID --V$SESSION
     , L.ORACLE_USERNAME
     , S.SERIAL#
     , S.OSUSER
     , S.PROGRAM
    FROM V$SESSION S
    JOIN V$LOCKED_OBJECT L
    ON S.SID = L.SESSION_ID;

--현 세션은 종료할 수 없다.    
--ALTER SYSTEM KILL SESSION '504, 42188' IMMEDIATE;


--1-2. 인덱스
--인덱스 생성
--STUDENT 테이블에 SNAME을 인덱스로 생성(비 고유 인덱스)
CREATE INDEX STUDENT_SNAME_IDX
        ON STUDENT(SNAME);

--여러개의 컬럼을 선택하여 복합 인덱스 생성
--PROFESSOR 테이블에 PNO, PNAME을 복합 인덱스로 생성
CREATE INDEX PROFESSOR_PNO_PNAME_IDX
ON PROFESSOR(PNO, PNAME); --두개 컬럼 선택해서 인덱스로 만든다.


--수식으로 인덱스 생성
--테이블에 여러개의 인덱스 생성 가능
--STUDENT 테이블에 평점을 4.5로 환산한 평점 인덱스로 지정.
--수식으로 만든 인덱스는 컬럼명이 표시되지 않고 시스템에서 자동으로 생성한 수식의 이름을 사용한다.
CREATE INDEX STUDENT_CONVERT_AVR_IDX
ON STUDENT(AVR * 4.5 / 4.0);

--생성된 인덱스 확인
--CONVERT IDX는 COLUMN_NAME이 아니라 시스템이 지정해준 이름으로 들어간 걸 확인할 수 있다.
SELECT UIC.INDEX_NAME
     , UIC.COLUMN_NAME
     , UIC.COLUMN_POSITION
     , UI.UNIQUENESS
    FROM USER_INDEXES UI
    JOIN USER_IND_COLUMNS UIC
    ON UI.INDEX_NAME = UIC.INDEX_NAME
    AND UI.TABLE_NAME IN ('STUDENT', 'PROFESSOR')
    ORDER BY UI.TABLE_NAME, UIC.INDEX_NAME, UIC.COLUMN_POSITION;

--인덱스 삭제: DROP INDEX 인덱스명;
DROP INDEX STUDENT_SNAME_IDX;
DROP INDEX PROFESSOR_PNO_PNAME_IDX;
DROP INDEX STUDENT_CONVERT_AVR_IDX;


SELECT *
    FROM STUDENT
    WHERE SNAME = '괴월';

--일반적으로 대량의 데이터에서는 인덱스를 생성해서 조회하는 게 더 빠르게 실행된다고 한다!    
CREATE INDEX STUDENT_SNAME_IDX
        ON STUDENT(SNAME);

SELECT *
    FROM STUDENT
    WHERE SNAME = '괴월';



--1-3. VIEW
--뷰의 생성
--과목별 학과별 기말고사의 평균을 저장하는 뷰 생성
CREATE OR REPLACE VIEW V_AVG_SCORE(
    CNO,
    CNAME,
    MAJOR,
    AVGRESULT --컬럼명을 커스터마이징해서 사용할 수 있기 때문에 원천 테이블의 컬럼명을 노출하지 않을 수 있다.
) AS (
        --위에서 지정한 컬럼의 순서와 개수가 일치해야 한다.
        SELECT CNO
             , C.CNAME
             , ST.MAJOR
             , ROUND(AVG(SC.RESULT), 2)
            FROM COURSE C
            NATURAL JOIN SCORE SC
            JOIN STUDENT ST
            ON SC.SNO = ST.SNO
            GROUP BY CNO, C.CNAME, ST.MAJOR
);

--뷰를 조회
--과목별 평균 점수해야 뷰를 조회 가능함.

SELECT *
    FROM V_AVG_SCORE;
    


--원천 테이블의 데이터가 변경되면 뷰의 데이터도 자동으로 변경
UPDATE COURSE
    SET
        CNAME = '일반화학1'
    WHERE CNAME = '일반화학';

COMMIT;

UPDATE STUDENT
    SET
        MAJOR = '유공1'
    WHERE MAJOR = '유공';
    
COMMIT;

--이렇게 보면 원천테이블 변경해두면 뷰가 바로 업데이트된걸 조회할 수 있다.
SELECT *
    FROM V_AVG_SCORE
    ORDER BY CNO, MAJOR;

--단순 뷰 생성(DML의 사용이 가능)
--DML을 사용하면 원천 테이블의 데이터가 추가/삭제/수정되는데
--조회쿼리가 1학년만 가져오는 쿼리라서 원천테이블 추가된 2, 3, 4학년의 
--데이터는 표출되지 않는다.

CREATE OR REPLACE VIEW ST_CH(
    SNO,
    SNAME,
    SYEAR,
    AVR
) AS (
    SELECT SNO
         , SNAME
         , SYEAR
         , AVR
        FROM STUDENT
        WHERE SYEAR = 1 --1학년만 한정하는 제약조건이 걸림.
);

SELECT *
    FROM ST_CH
    WHERE SNAME = '홍길동';
    
SELECT *
    FROM STUDENT
    WHERE SNAME = '홍길동';

--단순 뷰에서 DML의 사용
INSERT INTO ST_CH
VALUES (
            '9003',
            '홍길동',
            1,
            4.0
);

COMMIT;


--CHECK OPTION 추가하면 제약조건이 생성되어
--조회해온 조건에 맞는 데이터만 추가할 수 있도록 변경
--1학년 데이터만 조회해오기 때문에
--1학년 데이터만 입력할 수 있도록 변경.
CREATE OR REPLACE VIEW ST_CH(
    SNO,
    SNAME,
    SYEAR,
    AVR
) AS (
    SELECT SNO
         , SNAME
         , SYEAR
         , AVR
        FROM STUDENT
        WHERE SYEAR = 1 --1학년만 한정하는 제약조건이 걸림.
)
WITH CHECK OPTION CONSTRAINT VIEW_ST_CH_CK; --원천테이블에도 입력 안되게 막아버리는 뷰를 생성.


--1-5. 인라인 뷰 : FROM, JOIN 절 사용 서브쿼리
--부서별 최소 급여 받는 직원 조회
SELECT E.ENO
     , E.ENAME
     , E.DNO
     , B.SAL
    FROM EMP E
    JOIN (
            --인라인 뷰
            SELECT DNO
                 , MIN(SAL) AS SAL
                FROM EMP
                GROUP BY DNO
        ) B
    ON E.SAL = B.SAL;
    
    

--1-6. 뷰의 삭제
DROP VIEW ST_CH;
DROP VIEW V_AVG_SCORE;


--인라인 뷰와 ROWNUM을 이용해서 최상위 N데이터 조회
--급여가 최상위 3명 데이터 조회
SELECT ROWNUM
     , A.ENO
     , A.ENAME
     , A.SAL
    FROM (
            SELECT ENO
                 , ENAME
                 , SAL
                FROM EMP
                ORDER BY SAL DESC
        ) A
    WHERE ROWNUM <= 3; --이렇게 조건 걸면 TOP 1,2,3만 출력이 된다.


--학과별 기말고사 성적의 평균이 가장 높은 3개 학과 조회
SELECT ROWNUM
     , A.MAJOR
     , A.AVRES
    FROM (
            SELECT ST.MAJOR
                 , AVG(SC.RESULT) AS AVRES
                FROM STUDENT ST
                JOIN SCORE SC
                ON ST.SNO = SC.SNO
                GROUP BY ST.MAJOR
                ORDER BY AVG(SC.RESULT) DESC
    ) A
    WHERE ROWNUM <= 3;
    
    
    
SELECT ROWNUM
     , A.MAJOR
     , A.RES
    FROM (
            SELECT ST.MAJOR
                     , ROUND(AVG(SC.RESULT), 2) AS RES
                    FROM STUDENT ST
                    JOIN SCORE SC
                    ON ST.SNO = SC.SNO
                    GROUP BY ST.MAJOR
                    ORDER BY AVG(SC.RESULT) DESC
        ) A
      WHERE ROWNUM <= 3; --최상위 ROWNUM의 경우에는, 크다, 같다는 맞춰줄 수 없다.
--    WHERE ROWNUM > 3; --최상위 ROWNUM의 경우에는, 크다, 같다는 맞춰줄 수 없다.
--    WHERE ROWNUM = 3; --최상위 ROWNUM의 경우에는, 크다, 같다는 맞춰줄 수 없다.


SELECT A.*
    FROM (
            SELECT ROWNUM AS RN
                 , ST.*
                FROM STUDENT ST
        ) A
    WHERE A.RN > 5; --인라인 뷰 위치에서 ROWNUM이 들어가면, 크다 같다도 가능하다.
            
            
--이것도 최상위 B 칼럼 내에서는 크다, 같다 비교 다 가능하게 만들 수 있다.
--인라인뷰 안쪽으로 넣고 조회.
SELECT B.*
    FROM (
            SELECT ROWNUM AS RN
     , A.MAJOR
     , A.RES
    FROM (
            SELECT ST.MAJOR
                     , ROUND(AVG(SC.RESULT), 2) AS RES
                    FROM STUDENT ST
                    JOIN SCORE SC
                    ON ST.SNO = SC.SNO
                    GROUP BY ST.MAJOR
                    ORDER BY AVG(SC.RESULT) DESC
        ) A

    ) B
      WHERE B.RN > 3;    


--잘못된 ROWNUM의 사용
-- 급여가 높은 순으로 세명 동작할 것인가? NO
--ROWNUM이 붙은 다음 정렬이 일어남.
SELECT ROWNUM
     , ENO
     , ENAME
     , SAL
    FROM EMP
    WHERE ROWNUM <= 3 --잘못된 출력이다. 7200 순으로 나타나야함.
    ORDER BY SAL DESC;
    
-- =======> 수정
--ROWNUM은 위치에 따라서 결과가 바뀌기 때문에
--위치를 잘 지정해야하고 최상위 SELECT 구문에서의 ROWNUM은
-- <, <= 비교만 가능하다.
SELECT ROWNUM
     , A.ENO
     , A.ENAME
     , A.SAL
    FROM (
            SELECT ENO
                 , ENAME
                 , SAL
                FROM EMP
                ORDER BY SAL DESC --이렇게 먼저 정렬된 상태로 진행된 후에 조건
    
            ) A
    WHERE ROWNUM <= 3; --크다, 같다 안된다.



SELECT B.*
    FROM (
            SELECT ROWNUM AS RN
                 , A.ENO
                 , A.ENAME
                 , A.SAL
                FROM (
                        SELECT ENO
                             , ENAME
                             , SAL
                            FROM EMP
                            ORDER BY SAL DESC --이렇게 먼저 정렬된 상태로 진행된 후에 조건
                
                        ) A
            ) B
    WHERE B.RN > 3; 
    
    
    
--1-4. SEQUENCE
--시퀀스를 사용할 테이블 생성
CREATE TABLE EMP_COPY1(
        ENO NUMBER,
        ENAME VARCHAR2(20),
        JOB VARCHAR2(10),
        MGR NUMBER,
        HDATE DATE,
        SAL NUMBER,
        COMM NUMBER,
        DNO NUMBER
);


CREATE TABLE DEPT_COPY1 (
        DNO NUMBER,
        DNAME VARCHAR2(10),
        LOC VARCHAR2(10),
        DIRECTOR NUMBER
);


--시퀀스 2개 생성
--옵션추가한 시퀀스 생성
CREATE SEQUENCE EMP_CO_ENO_SEQ
--START WITH --탭/들여쓰기 안주면 다른 오라클 함수로 인식
    START WITH 1
    INCREMENT BY 2
    MAXVALUE 10
    NOMINVALUE
    CYCLE
    NOCACHE;



--옵션을 하나도 추가하지 않은 시퀀스를 생성
CREATE SEQUENCE DEPT_CO_ENO_SEQ;
--DROP TABLE DEPT_COPY;

--NEXTVAL : 시퀀스가 가리키는 값을 다음 값으로 옮긴다. 그걸 CURRVAL가 다음에 받아준다.
--이걸 사용
INSERT INTO EMP_COPY1
VALUES(EMP_CO_ENO_SEQ.NEXTVAL,'F', '개발', 0, SYSDATE, 3000, 100, 0); --숫자는 NULL 못들감.
--좋은 시퀀스는 아니다. 중복이 우려되는 값들이 키로 가있다.


INSERT INTO EMP_COPY1
VALUES(EMP_CO_ENO_SEQ.CURRVAL,'F', '개발', 0, SYSDATE, 3000, 100, 0); --숫자는 NULL 못들감.


SELECT *
    FROM EMP_COPY1;
    
    
DELETE FROM  EMP_COPY1
    WHERE ENAME = 'F';


--옵션이 없는 시퀀스의 사용
INSERT INTO DEPT_COPY1
VALUES(DEPT_CO_ENO_SEQ.NEXTVAL, '개발', '서울', 0);


SELECT *
    FROM DEPT_COPY1;



--생성된 시퀀스를 조회하는 쿼리
SELECT SEQUENCE_NAME
    , MAX_VALUE
    , MIN_VALUE
    , INCREMENT_BY
    , CACHE_SIZE
    , LAST_NUMBER
    , CYCLE_FLAG
FROM USER_SEQUENCES;

