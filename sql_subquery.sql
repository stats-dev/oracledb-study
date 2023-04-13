--1. 서브쿼리
--단일 행 쿼리
SELECT *
    FROM PROFESSOR
    WHERE PNAME = '송강'; --한행만 출력됨.
    
    
--단일 행 서브쿼리
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
                        





