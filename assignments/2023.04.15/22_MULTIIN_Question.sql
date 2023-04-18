--1) 다중 컬럼 IN절을 이용해서 기말고사 성적이 80점 이상인 과목번호, 학생번호, 기말고사 성적을 모두 조회하세요.
SELECT CNO
     , SNO
     , RESULT
     FROM SCORE
     WHERE (CNO, SNO) IN (
                            SELECT CNO
                                 , SNO
                                FROM SCORE
                                WHERE RESULT >= 80
    );


--2) 다중 컬럼 IN절을 이용해서 화학과나 물리학과면서 학년이 1, 2, 3학년인 학생의 정보를 모두 조회하세요.
SELECT *
    FROM STUDENT
    WHERE(MAJOR, SYEAR) IN (
                        SELECT MAJOR
                             , SYEAR
                            FROM STUDENT
                            WHERE MAJOR IN ('화학', '물리')
                             AND SYEAR IN (1, 2, 3)
        )
    ORDER BY MAJOR, SYEAR;


SELECT SNO
     , SNAME
     , MAJOR
     , SYEAR
    FROM STUDENT
    WHERE (MAJOR, SYEAR) IN (
                                SELECT MAJOR
                                     , SYEAR
                                    FROM STUDENT
                                    WHERE MAJOR IN ('화학', '물리')
                                      AND SYEAR IN (1,2,3)
                            );


--3) 다중 컬럼 IN절을 사용해서 부서가 10, 20, 30이면서 보너스가 1000이상인 사원의 사원번호, 사원이름, 부서번호, 부서이름, 업무, 급여, 보너스를 
--   조회하세요.(서브쿼리 사용)
SELECT E.ENO
     , E.ENAME
     , DNO
     , D.DNAME
     , E.JOB
     , E.SAL
     , E.COMM
    FROM EMP E
    NATURAL JOIN DEPT D
    WHERE (DNO, COMM) IN (
                    SELECT DNO
                         , COMM
                        FROM EMP
                        WHERE DNO IN ('10', '20', '30')
                         AND COMM >= 1000
);


SELECT E.ENO
     , E.ENAME
     , DNO
     , D.DNAME
     , E.JOB
     , E.SAL
     , E.COMM
    FROM EMP E
    NATURAL JOIN DEPT D
    WHERE (E.ENO, DNO) IN (
                            SELECT ENO
                                 , DNO
                                FROM EMP
                                WHERE DNO IN ('10', '20', '30')
                                 AND COMM >= 1000
                            );


--4) 다중 컬럼 IN절을 사용하여 기말고사 성적의 최고점이 100점인 과목의 과목번호, 과목이름, 학생번호, 학생이름, 기말고사 성적을 조회하세요.(서브쿼리 사용)
SELECT CNO
     , C.CNAME
     , SNO
     , ST.SNAME
     , SC.RESULT
    FROM COURSE C
    NATURAL JOIN STUDENT ST
    NATURAL JOIN SCORE SC
    WHERE (CNO, RESULT) IN (
            SELECT CNO
                 , MAX(RESULT)
                FROM SCORE
                GROUP BY CNO
                HAVING MAX(RESULT) = 100
);

--NO GROUP BY HAVING MAX RESULT METHOD..
SELECT CNO
     , C.CNAME
     , SNO
     , ST.SNAME
     , SC.RESULT
    FROM COURSE C
    NATURAL JOIN STUDENT ST
    NATURAL JOIN SCORE SC
    WHERE RESULT IN (
            SELECT RESULT
                FROM SCORE
                WHERE RESULT = 100
)
    ORDER BY CNO;
    

SELECT CNO
     , C.CNAME
     , SNO
     , ST.SNAME
     , SC.RESULT
    FROM COURSE C --조인되는 순서는 OUTER JOIN 외에는 상관 없다. SCORE 먼저와도 된다.
    NATURAL JOIN SCORE SC -- COURSE, SCORE 조인 CNO
    NATURAL JOIN STUDENT ST --STUDENT, SCORE 조인 SNO
    WHERE (CNO, SNO) IN  (--보통 다중 IN 절에는 조인의 공통 컬럼을 많이 쓰는 것으로 보인다.
                            SELECT CNO
                                 , SNO
                                FROM SCORE
                                GROUP BY CNO, SNO
                                HAVING MAX(RESULT) = 100
                                --WHERE절로 그냥 해도 됩니다.
                            );
                            
