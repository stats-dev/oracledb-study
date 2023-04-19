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
--현재 접속한 사용자가     
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

