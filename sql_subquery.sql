--1. 서브쿼리
--단일 행 쿼리
SELECT *
    FROM PROFESSOR
    WHERE PNAME = '송강'; --한행만 출력됨.
    
    
--1-1. 단일 행 서브쿼리
--송강 교수보다 부임일시가 빠른 교수들의 목록 조회
SELECT P.*
    FROM PROFESSOR P 
    WHERE P.HIREDATE < ( 
                            SELECT HIREDATE 
                            FROM PROFESSOR
                            WHERE PNAME = '송강'
                        );
                        
                        
--손하늘 사원보다 급여가 높은 사원목록 조회
SELECT *
    FROM EMP
    WHERE ENAME = '손하늘'; --SAL 3510

SELECT EM.*
    FROM EMP EM
    WHERE EM.SAL > ( 
                            SELECT SAL 
                            FROM EMP
                            WHERE ENAME = '손하늘'
                        )
    ORDER BY SAL;
                        
-- 이렇게 SELECT 문에 *을 입력하면, ORA-00913: 값의 수가 너무 많습니다 에러를 반환한다.
SELECT EM.*
    FROM EMP EM
    WHERE EM.SAL > ( 
                            SELECT * 
                            FROM EMP
                            WHERE ENAME = '손하늘'
                        );

-- 이렇게 SELECT 문에 *을 입력해서도 수행할 수 있게 조정해보기.
-- 테이블 형태임을 인지했고, 그러므로 JOIN절로 넣어주면 ON절에서 바로 비교도 가능하다.
SELECT EM.*
    FROM EMP EM
    JOIN ( 
                            SELECT *
                            FROM EMP
                            WHERE ENAME = '손하늘'
                        ) B
    ON EM.SAL > B.SAL;
--    ON EM.SAL != B.SAL; --이렇게도 가능하다.


--1-2. 다중 행 서브쿼리
--노육학생의 정보
SELECT * 
    FROM STUDENT
    WHERE SNAME = '노육';


-- 노육이라는 학생들(동명이인)과 학점이 같은 학생 목록 조회
SELECT ST.*
    FROM STUDENT ST
    WHERE AVR IN (
                    SELECT AVR
                        FROM STUDENT
                        WHERE SNAME = '노육'
                ); --IN절로 묶어서 세명의 학점을 조회하고 이것과 같은 모든 학생이 출력됨.
                
--에러 발생!!                
SELECT ST.*
    FROM STUDENT ST
    WHERE AVR IN (
                    SELECT *
                        FROM STUDENT
                        WHERE SNAME = '노육'
                );
                
SELECT ST.*
    FROM STUDENT ST
    JOIN (
                    SELECT *
                        FROM STUDENT
                        WHERE SNAME = '노육'
                ) B
    ON ST.AVR = B.AVR;
--    ON ST.AVR IN B.AVR; --이것도 가능하다!


--기말고사 성적이 95점이상인 학번, 과목번호, 과목명, 성적 => 서브쿼리
--학생테이블이랑 조인해서 학번, 학생이름, 과목번호, 과목명, 성적, 전공 조회
--서브쿼리
SELECT SC.SNO
    , SC.CNO
    , C.CNAME
    , SC.RESULT
    FROM SCORE SC
    JOIN COURSE C
    ON SC.CNO = C.CNO
    AND RESULT >= 95;


--SELECT ST.SNO
--    , ST.SNAME
--    , C.CNO
--    , C.CNAME
--    , SC.RESULT
--    , ST.MAJOR
--    FROM STUDENT ST
--    JOIN ( 
--                SELECT SC.SNO
--                , SC.CNO
--                , C.CNAME
--                , SC.RESULT
--                FROM SCORE SC
--                JOIN COURSE C
--                ON SC.CNO = C.CNO
--                AND RESULT >= 95
--            ) B
--    ON ST.SNO = B.SNO;
--    

SELECT B.SNO
    , ST.SNAME
    , ST.SYEAR
    , ST.MAJOR
    , B.CNO
    , B.CNAME
    , B.RESULT
        FROM (
                SELECT SC.SNO
                , SC.CNO
                , C.CNAME
                , SC.RESULT
                FROM SCORE SC
                JOIN COURSE C
                ON SC.CNO = C.CNO
                AND RESULT >= 95
    ) B
    JOIN STUDENT ST
    ON B.SNO = ST.SNO;



SELECT SC.SNO
    , ST.SNAME
    , ST.SYEAR
    , ST.MAJOR
    , SC.CNO
    , C.CNAME
    , SC.RESULT
    FROM SCORE SC
    JOIN COURSE C
    ON SC.CNO = C.CNO
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    AND SC.RESULT >= 95;