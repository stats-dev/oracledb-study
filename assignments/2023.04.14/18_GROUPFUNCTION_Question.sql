--1) 화학과를 제외하고 학과별로 학생들의 평점 평균을 검색하세요
SELECT ROUND(AVG(AVR), 2)
     , MAJOR
    FROM STUDENT
    GROUP BY MAJOR
    HAVING MAJOR != '화학';


--2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 이상인 정보를 검색하세요
SELECT ROUND(AVG(AVR), 2)
     , MAJOR
    FROM STUDENT
    GROUP BY MAJOR
    HAVING MAJOR != '화학'
    AND ROUND(AVG(AVR), 2) >= 2.0; --  통계함수는 HAVING 절로 맞춰야 한다.?



--3) 기말고사 평균이 60점 이상인 학생의 정보를 검색하세요
SELECT ST_ALL.SNO
     , ST_ALL.SNAME
     , ST_ALL.SYEAR
     , ST_ALL.MAJOR
     , ST_ALL.AVR
     , AVGSC.AVRES
    FROM STUDENT ST_ALL
    JOIN (
            SELECT AVG(SC.RESULT) AS AVRES
                 , SC.SNO
            FROM SCORE SC
            JOIN STUDENT ST
            ON SC.SNO = ST.SNO
            GROUP BY SC.SNO
            HAVING AVG(SC.RESULT) >= 60    
        )AVGSC
    ON ST_ALL.SNO = AVGSC.SNO;
    
  
  
SELECT SC.SNO
     , ST.SNAME
     , ROUND(AVG(SC.RESULT), 2)
    FROM SCORE SC
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    GROUP BY SC.SNO, ST.SNAME
    HAVING ROUND(AVG(SC.RESULT), 2) >= 60;


--4) 강의 학점이 3학점 이상인 교수의 정보를 검색하세요
--ESTINUM이 하나 이상 혹은 둘 이상일 수 있으니 GROUP BY로 해줘야 겠다.
--SUM
SELECT P.PNO
     , P.PNAME
     , P.SECTION
     , C.ST_NUM
    FROM PROFESSOR P
    JOIN COURSE C
    ON P.PNO = C.PNO
    WHERE C.ST_NUM >= 3;


SELECT C.PNO
     , P.PNAME
     , SUM(C.ST_NUM)
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO
    GROUP BY C.PNO, P.PNAME
    HAVING SUM(C.ST_NUM) >= 3;


--5) 기말고사 평균 성적이 핵 화학과목보다 우수한 과목의 과목명과 담당 교수명을 검색하세요
--과목별 평균성적: AVG(SCORE.RESULT), GROUP BY CNO, JOIN COURSE.CNAME, JOIN PROFEEOR.PNAME
--JOIN 많이. (서브쿼리 써야함.)
SELECT C.CNO
     , C.CNAME
     , P.PNAME
     , AVRE_ALL.AVRE
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO
    JOIN (
            SELECT AVG(RESULT) AVRE
             , CNO
             FROM SCORE
             GROUP BY CNO   
        ) AVRE_ALL
    ON C.CNO = AVRE_ALL.CNO
    WHERE AVRE_ALL.AVRE > (
                                SELECT AVG(RESULT)
                                FROM (
                                        SELECT SC.RESULT
                                             , SC.CNO
                                             , C.CNAME
                                             FROM SCORE SC
                                             JOIN COURSE C
                                             ON SC.CNO = C.CNO 
                                             WHERE C.CNAME = '핵화학'
                                )
                                GROUP BY CNO
    )
    ORDER BY AVRE;
                                        
    
SELECT AVGRESULT.CNO
     , AVGRESULT.CNAME
     , AVGRESULT.PNO
     , P.PNAME
     , AVGRESULT.RESAVG
    FROM (
            SELECT SC.CNO
                 , C.CNAME
                 , C.PNO
                 , ROUND(AVG(SC.RESULT), 2) AS RESAVG
                FROM SCORE SC
                JOIN COURSE C
                ON SC.CNO = C.CNO
                GROUP BY SC.CNO, C.CNAME, C.PNO
    ) AVGRESULT
    JOIN PROFESSOR P
    ON AVGRESULT.PNO = P.PNO
    WHERE AVGRESULT.RESAVG > (
                                SELECT ROUND(AVG(SCO.RESULT), 2)
                                    FROM SCORE SCO
                                    JOIN COURSE CO
                                    ON SCO.CNO = CO.CNO
                                    AND CO.CNAME = '핵화학'
                                    GROUP BY SCO.CNO
                             );



--6) 근무 중인 직원이 4명 이상인 부서를 검색하세요(부서번호, 부서명, 인원수)
--COUNT(부서) >= 4
SELECT D.DNO
     , D.DNAME
     , COUNT(*) AS 인원수
    FROM EMP E
    JOIN DEPT D
    ON E.DNO = D.DNO
    GROUP BY D.DNO, D.DNAME
    HAVING COUNT(*) >= 4;


SELECT E.DNO
     , D.DNAME
     , COUNT(*)
    FROM EMP E
    JOIN DEPT D
    ON E.DNO = D.DNO
    GROUP BY E.DNO, D.DNAME
    HAVING COUNT(*) >= 4;


--7) 업무별 평균 연봉이 3000 이상인 업무를 검색하세요
SELECT ROUND(AVG(SAL),2) AS 평균연봉
     , JOB
    FROM EMP
    GROUP BY JOB
    HAVING AVG(SAL) >= 3000
    ORDER BY AVG(SAL) ASC;


SELECT JOB
     , ROUND(AVG(SAL), 2)
    FROM EMP
    GROUP BY JOB
    HAVING ROUND(AVG(SAL), 2) >= 3000;

--8) 각 학과의 학년별 인원중 인원이 5명 이상인 학년을 검색하세요
SELECT COUNT(*)
     , MAJOR
     , SYEAR
    FROM STUDENT
    GROUP BY MAJOR, SYEAR
    HAVING COUNT(*) >= 5
    ORDER BY MAJOR, SYEAR;

SELECT MAJOR
     , SYEAR
     , COUNT(*)
    FROM STUDENT
    GROUP BY MAJOR, SYEAR
    HAVING COUNT(*) >=5;
