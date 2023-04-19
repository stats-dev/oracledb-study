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
    











