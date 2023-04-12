--1. OUTER JOIN 연습
CREATE TABLE BOARD(
    BOARD_NO NUMBER,
    BOARD_TITLE VARCHAR(50)

);

CREATE TABLE BOARD_FILE(
    BOARD_NO NUMBER,
    FILE_NM VARCHAR(50)
    
);


--INSERT INTO BOARD VALUES(10, 'a');
--INSERT INTO BOARD_FILE VALUES(13, 'a');

SELECT * FROM BOARD;
SELECT * FROM BOARD_FILE;

SELECT A.*
    , NVL(B.FILE_NM, 'no file exist')
    FROM BOARD A
--    INNER JOIN BOARD_FILE B
    LEFT OUTER JOIN BOARD_FILE B
--    RIGHT OUTER JOIN BOARD_FILE B
    ON A.BOARD_NO = B.BOARD_NO;


SELECT A.BOARD_TITLE
    , B.BOARD_NO
    , NVL(A.BOARD_TITLE, 'no file exist')
    , NVL(B.FILE_NM, 'no file exist')
    FROM BOARD A
--    RIGHT OUTER JOIN BOARD_FILE B
    FULL OUTER JOIN BOARD_FILE B
    ON A.BOARD_NO = B.BOARD_NO;

--DELETE FROM BOARD 
--    WHERE BOARD_NO = '10';
        
        
SELECT NVL(A.BOARD_TITLE, 'no file exist') BOARD_TITLE
    , NVL(B.FILE_NM, 'no file exist') BOARD_NO
    FROM BOARD A
--    RIGHT OUTER JOIN BOARD_FILE B
    FULL OUTER JOIN BOARD_FILE B
    ON A.BOARD_NO = B.BOARD_NO;
    

--2. INNER JOIN
--SCORE 테이블의 모든 데이터와 STUDENT 테이블의 학생이름 조회
SELECT SC.*
    , ST.SNAME
    FROM SCORE SC
    INNER JOIN STUDENT ST
    ON SC.SNO = ST.SNO; -- 조건확인
    
    
--모든 사원정보와 부서명 동시에 조회
--SELECT EP.* --모든 사원정보
--    , DP.DNAME -- 부서명
--    FROM EMP EP
----    INNER JOIN DEPT DP
----    LEFT OUTER JOIN DEPT DP
--    FULL OUTER JOIN DEPT DP
--    ON EP.DNO = DP.DNO;
--    

--모든 사원정보와 부서명 동시에 조회
--ANSI 표준 작성 요망.
SELECT EM.*
    , DE.DNAME
    , DE.LOC
    FROM EMP EM
    JOIN DEPT DE -- INNER는 생략이 가능하다.
    ON EM.DNO = DE.DNO;
    
    
--다른 형태의 INNER JOIN
--JOIN과 ON을 없애고, FROM에 다 넣고, WHERE에 ON 조건을 넣는다.
SELECT EM.*
    , DE.DNAME
    , DE.LOC
    FROM EMP EM
        , DEPT DE
    WHERE EM.DNO = DE.DNO;


-- 오라클만 가능한 방식 FULL OUTER는 안된다.
--SELECT EM.*
--    , DE.DNAME
--    , DE.LOC
--    FROM EMP EM
--        , DEPT DE
--    WHERE EM.DNO = DE.DNO(+);

--비등가 조인
--같은 값이 없어서 등가조인이 불가능
SELECT SC.*
    , GR.GRADE
    FROM SCORE SC
    INNER JOIN SCGRADE GR
    ON SC.RESULT BETWEEN GR.LOSCORE AND GR.HISCORE;
    

--사원의 모든 정보와 해당 사원에 대한 급여등급 정보 조회
SELECT EM.*
    , GR.GRADE
    FROM EMP EM
    INNER JOIN SALGRADE GR
    ON EM.SAL BETWEEN GR.LOSAL AND GR.HISAL;
    
    
    
    