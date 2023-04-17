--1. 추가적인 조인 방식
--1-1. NATURAL JOIN
--학생들의 평균 결과값을 추출할 수 있다.
--NATURAL JOIN에서는 조인되는 컬럼에 테이블의 별칭을 달아서 사용할 수 없다.
SELECT SNO
     , ST.SNAME
     , AVG(SC.RESULT)
    FROM SCORE SC
    NATURAL JOIN STUDENT ST --알아서 SNO 조인?
    GROUP BY SNO, SNAME;
    
    
    
--학생별 기말고사 성적의 평균이 55점이상인 학생번호, 학생이름, 기말고사 평균 조회(Natural join)
SELECT SNO
     , SNAME
     , AVG(RESULT)
    FROM STUDENT
    NATURAL JOIN SCORE
    GROUP BY SNO, SNAME
    HAVING AVG(RESULT) >= 55;
    
    
SELECT SNO
     , ST.SNAME
     , AVG(SC.RESULT)
    FROM SCORE SC
    NATURAL JOIN STUDENT ST --알아서 SNO 조인?
    GROUP BY SNO, SNAME
    HAVING AVG(SC.RESULT) >= 55;
    
    
--최대 급여가 4000만원 이상되는 부서의 번호, 부서 이름, 급여(SAL) 조회
SELECT DNO
     , DNAME
     , MAX(SAL)
    FROM DEPT
    NATURAL JOIN EMP
    GROUP BY DNO, DNAME
    HAVING MAX(SAL) >= 4000;
    
    
SELECT DNO --JOIN 되는 건 별칭 X
     , D.DNAME
     , MAX(E.SAL)
     FROM EMP E
     NATURAL JOIN DEPT D
     GROUP BY DNO, D.DNAME
     HAVING MAX(E.SAL) >= 4000;
     

--1-2. JOIN~USING
--JOIN~ON
SELECT SC.CNO
     , C.CNAME
     , AVG(SC.RESULT)
    FROM SCORE SC
    JOIN COURSE C
    ON SC.CNO = C.CNO
    GROUP BY SC.CNO, C.CNAME
    HAVING AVG(SC.RESULT) >= 53;
    

--JOIN~USING
SELECT CNO
     , C.CNAME
     , AVG(SC.RESULT)
    FROM SCORE SC
    JOIN COURSE C
    USING (CNO) --조인될 컬럼 하나만 괄호로 묶어 쓴다.
    GROUP BY CNO, C.CNAME --조인될 컬럼은 별칭을 가질 수 없다!!
    HAVING AVG(SC.RESULT) >= 53;
    
    
    
--학점이 3점인 과목의 교수번호, 교수이름, 과목번호, 과목이름, 학점 조회(JOIN~USING 사용)
SELECT PNO
     , P.PNAME
     , C.CNO
     , C.CNAME
     , C.ST_NUM
    FROM PROFESSOR P
    JOIN COURSE C
    USING (PNO)
    WHERE C.ST_NUM = 3;
    

SELECT PNO
     , P.PNAME
     , C.CNO
     , C.CNAME
     , C.ST_NUM
    FROM COURSE C
    JOIN PROFESSOR P
    USING (PNO)
    WHERE C.ST_NUM = 3;
    

--2. 다중 컬럼 IN절
--DNO = 01이면서 JOB이 경영인 사원이나 DNO=30이면서 JOB이 회계인 사원 조회
SELECT DNO
     , ENO
     , ENAME
     , JOB
    FROM EMP
    WHERE (DNO, JOB) IN (('10', '분석'), ('20', '개발'));


--잘못 작성한 쿼리
SELECT DNO
     , ENO
     , ENAME
     , JOB
    FROM EMP
    WHERE DNO IN ('10', '20') 
        AND JOB IN ('분석', '개발');

SELECT DNO
     , ENO
     , ENAME
     , JOB
    FROM EMP
    WHERE (DNO = '10' AND JOB = '분석')
        OR (DNO = '10' AND JOB = '개발')
        OR (DNO = '20' AND JOB = '분석')
        OR (DNO = '20' AND JOB = '개발');


--총 4개 조건 나온다.
SELECT DNO
     , ENO
     , ENAME
     , JOB
    FROM EMP
    WHERE (DNO = '10' AND (JOB = '분석' OR JOB = '개발'))
        OR (DNO = '20' AND (JOB = '분석' OR JOB = '개발'));
        
--다중컬럼 in절(CNO, PNO)을 이용해서 기말고사 성적의 평균이 48점 이상인 과목번호 과목명 교수번호 교수이름 기말고사 성적 평균 조회
SELECT CNO
     , C.CNAME
     , PNO
     , P.PNAME
     , AVG(SC.RESULT)
    FROM COURSE C
    NATURAL JOIN PROFESSOR P
    NATURAL JOIN SCORE SC
    WHERE (CNO, PNO) IN (
                    -- 기말고사 성적의 평균이 48점 이상되는 과목의 CNO, PNO 뽑아주는 작업.
                    SELECT CNO
                         , PNO
                        FROM SCORE SCC
                        NATURAL JOIN COURSE CC
                        NATURAL JOIN PROFESSOR PP
                        GROUP BY CNO, PNO
                        HAVING AVG(SCC.RESULT) >= 48 --이러면 그과목에 해당하는 교수번호 과목번호 잘 뽑을 수 있다.
                    )
    GROUP BY CNO, C.CNAME, PNO, P.PNAME;




SELECT CNO
     , C.CNAME
     , PNO
     , P.PNAME
     , AVG(SC.RESULT)
    FROM COURSE C
    JOIN PROFESSOR P
    USING (PNO)
    JOIN SCORE SC
    USING (CNO)
    WHERE (CNO, PNO) IN (
                            SELECT CNO
                                 , PNO
                            FROM COURSE C
                            JOIN PROFESSOR P
                            USING (PNO)  
    
                            )
    GROUP BY CNO, C.CNAME, PNO, P.PNAME
    HAVING AVG(SC.RESULT) >= 48;         
    
    
    
--사원의 정보를 다중 컬럼 IN을 이용해서 조회
--(DNO, MGR) 부서번호는 01, 02 사수번호 0001인 (서브쿼리)
--사원번호, 사원이름, 사수번호, 부서번호 조회
SELECT ENO
     , ENAME
     , MGR
     , DNO
    FROM EMP
    WHERE(DNO, MGR) IN (
                        SELECT DNO
                             , MGR
                            FROM EMP
                            GROUP BY DNO, MGR
                            HAVING DNO IN (01, 02) 
                                AND MGR = '0001'
                        );
     