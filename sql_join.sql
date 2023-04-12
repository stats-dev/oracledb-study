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

SELECT EMP.*
    , SALGRADE.GRADE
    FROM EMP
    INNER JOIN SALGRADE
    ON EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL;
    
    
--CrossJoin
--조인 조건을 명시하지 않으면 의미없는 데이터가 조회된다.
--모든 부서마다 모든 사원 출력하는 것으로 나타남.
SELECT A.ENO
    , A.ENAME
    , A.DNO
    , B.DNAME
    FROM EMP A
        , DEPT B; --조인조건을 명시하지 않으면 이상해짐. 1:1로만 들어감

    
--셀프조인
--FROM절의 테이블과 조인되는 테이블이 같을 때
--사원의 사수 이름 조회
SELECT A.ENO
    , A.ENAME
    , A.MGR
    , B.ENO
    , B.ENAME
    FROM EMP A
    JOIN EMP B
    ON A.MGR = B.ENO;
    

--3. OUTER JOIN
--사원의 사수 이름 조회 사수의 정보가 존재하지 않는 사원들도 모두 조회
--ANSI
SELECT A.ENO
    , A.ENAME
    , A.MGR
    , B.ENO
    , B.ENAME
    FROM EMP A
    LEFT JOIN EMP B --outer 생략 가능
    ON A.MGR = B.ENO;

--ORACLE
SELECT A.ENO
    , A.ENAME
    , A.MGR
    , B.ENO
    , B.ENAME
    FROM EMP A
       , EMP B
    WHERE A.MGR = B.ENO(+);



--과목들의 정보를 조회, 교수의 이름과 같이 조회, 담당교수가 배정되지 않은 과목도 함께 조회되도록 한다.
SELECT A.CNO
    , A.CNAME
    , A.ST_NUM
    , A.PNO
    , B.PNAME
    FROM COURSE A
    LEFT JOIN PROFESSOR B
    ON A.PNO = B.PNO;


















