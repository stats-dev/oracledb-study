--1. 그룹함수
--1-1. MAX
--전체 학생 중 최대 평점
--모든 데이터에서 조회하는건 그룹화 필요 없음.
SELECT MAX(AVR) --따로 그룹화할 필요 없음.
    FROM STUDENT;
    
--전공별 최대 평점
SELECT MAX(AVR)
     , MAJOR
    FROM STUDENT
    GROUP BY MAJOR;
    
--전공별로 학년별로 최대 평점
SELECT MAX(AVR)
     , MAJOR
     , SYEAR
--     , SNO 불가능! SNO는 겹치는 값이 없다.
--     , SNAME
    FROM STUDENT
    GROUP BY MAJOR, SYEAR; --COMMA로 연결해서, 전공별 학년별로 묶는다.
    

--SNO를 굳이 만든다면? 서브쿼리로 묶어서 각자 가져와서 쓰도록 해야 한다. JOIN을 활용한다.
SELECT ST.SNO
     , ST.SNAME
     , MAXAVR.AVR
     , MAXAVR.MAJOR
     , MAXAVR.SYEAR
     FROM STUDENT ST
     JOIN
        (
        SELECT MAX(AVR)AS AVR
      , MAJOR
      , SYEAR
        FROM STUDENT
        GROUP BY MAJOR, SYEAR --COMMA로 연결해서, 전공별 학년별로 묶는다.
        HAVING MAJOR = '화학' --GROUP BY에서 조건절 역할
--        AND SYEAR = 1
        AND MAX(AVR) > 2.5 --저 위에 별칭은 밖에서만 쓸 수 있다. 같은 쿼리에서는 별칭 사용이 안된다!!!
        ) MAXAVR
    ON ST.AVR = MAXAVR.AVR
    AND ST.MAJOR = MAXAVR.MAJOR
    AND ST.SYEAR = MAXAVR.SYEAR; --3개가 다 같아야 함.
    
    
    
    
-- 기말고사 성적(SCORE) 중 과목별 가장 높은 점수 조회
SELECT CNO
     , MAX(RESULT)
     , MIN(RESULT)
    FROM SCORE
    GROUP BY CNO;


SELECT C.CNO
     , C.CNAME
     , MAX(S.RESULT)
    FROM SCORE S
    JOIN COURSE C
    ON S.CNO = C.CNO
    GROUP BY C.CNAME, C.CNO;
    
--GROUP BY 컬럼의 이름이 동일한 친구를 묶어서 그룹화한다!!
    
--해설 : 기말고사 성적 중 과목별 가장 높은 점수 조회
--CNO 데이터가 같은 값들을 그룹으로 묶어서 그 그룹중에 최대값을 꺼내온다.
SELECT CNO
     , MAX(RESULT)
    FROM SCORE
    GROUP BY CNO;
    
--해설 : 기말고사 성적 중 과목별 가장 높은 점수 조회 + 과목명
SELECT SC.CNO
     , C.CNAME
     , SC.MAXRESULT
    FROM COURSE C
    JOIN (
            SELECT CNO
          , MAX(RESULT) AS MAXRESULT
            FROM SCORE
            GROUP BY CNO
        ) SC
    ON C.CNO = SC.CNO;
    
-- SNO, SNAME 가져오기(SNO만 가져옴)
SELECT SC.CNO
     , C.CNAME
     , SC.SNO
     , SC.MAXRESULT
    FROM COURSE C
    JOIN (
            SELECT CNO
                 , SNO
                 , MAX(RESULT) AS MAXRESULT
            FROM SCORE
            GROUP BY CNO,SNO
        ) SC
    ON C.CNO = SC.CNO;

--과목별 기말고사 성적의 최대값(과목명, 학생이름)

SELECT SC.SNO --과목별 최고점수 학생 번호가 나온다.
     , ST.SNAME
     , MXRS.CNO
     , C.CNAME
     , MXRS.MAXRESULT
     FROM SCORE SC
     JOIN (
     --과목별 최대 점수 값인 테이블을 만든다.
            SELECT CNO
            , MAX(RESULT) AS MAXRESULT
            FROM SCORE
            GROUP BY CNO
    ) MXRS
    ON SC.CNO = MXRS.CNO
    AND SC.RESULT = MXRS.MAXRESULT
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    JOIN COURSE C --과목 매칭시켜서 MAX인 학생의 번호부터 가져오게 설정해야 합니다.
    ON C.CNO = SC.CNO --동점자를 고려해서 32개 과목 중 50개 과목이 나옴.
    ORDER BY SC.CNO; --과목별로 빠르게 정렬함.


--과목 개수
SELECT DISTINCT CNO
    FROM SCORE;


--GROUP BY 통계함수 함께 사용
--SELECT절에 통계함수
--GROUP BY절에 통계함수를 어떤 기준으로 통계를 낼건지
--GROUP BY절에 특정 컬럼을 지정하면 그 컬럼의 값이 같은 데이터들끼리
--모아서 통계를 내준다.
--예로 SCORE 테이블에 CNO을 GROUP BY절에 작성하면
--CNO이 같은 결국 같은 과목의 데이터만 모아서 통계를 내주는 식으로 진행한다.


--1-2. MIN
--기말고사 성적 전체 과목중 최저 값 조회
--테이블 전체 데이터의 통계를 낼 때는 GROUP BY를 사용할 필요가 없다.
SELECT MIN(RESULT)
    FROM SCORE;
    
--부서별 연봉 최저값
SELECT DNO
    , MIN(SAL)
    FROM EMP
    GROUP BY DNO;


--이러면 ENAME 때문에 GROUP의 의미가 없어짐. 다 나온다. 굳이 하려면 별도의 서브쿼리로 잡는다.
--SELECT DNO
--     , MIN(SAL)
--     , ENAME
--    FROM EMP
--    GROUP BY DNO, ENAME; 
    
    
--부서별 연봉 최저값 부서명 포함
SELECT D.DNO
     , D.DNAME
     , MINS.MINSAL
    FROM DEPT D
    JOIN (
            SELECT DNO
                 , MIN(SAL) AS MINSAL
             FROM EMP
             GROUP BY DNO
        ) MINS
    ON D.DNO = MINS.DNO
    ORDER BY MINSAL;


SELECT MNSL.DNO
     , D.DNAME
     , MNSL.MINSAL
--     , MNSL.MIN(SAL) --이거는 다시 통계내는 것이므로 무조건 별칭으로 수행한다.
    FROM DEPT D
    JOIN (
            SELECT DNO
            , MIN(SAL) AS MINSAL --요 별칭으로 밖에서 사용해야 합니다!
            FROM EMP
            GROUP BY DNO     
    ) MNSL
    ON D.DNO = MNSL.DNO;



--부서별 연봉 최저값 부서명, 사원이름 포함(잘못된 GROUP BY)
--공통된 값이 없는 컬럼을 GROUP BY하면 그룹화의 의미가 없어진다.
SELECT MNSL.DNO
     , D.DNAME
     , MNSL.ENAME
     , MNSL.MINSAL
--     , MNSL.MIN(SAL) --이거는 다시 통계내는 것이므로 무조건 별칭으로 수행한다.
    FROM DEPT D
    JOIN (
            SELECT DNO
                , ENAME
                , MIN(SAL) AS MINSAL --요 별칭으로 밖에서 사용해야 합니다!
                FROM EMP
                GROUP BY DNO, ENAME
    ) MNSL
    ON D.DNO = MNSL.DNO;


--
SELECT MNSL.DNO
     , D.DNAME
     , E.ENO
     , E.ENAME
     , MNSL.MINSAL
     FROM (
                 SELECT DNO
                , MIN(SAL) AS MINSAL --요 별칭으로 밖에서 사용해야 합니다!
                FROM EMP
                GROUP BY DNO
     ) MNSL --FROM, JOIN 순서 상관없음. 같은 값만 있으면 된다.
     JOIN EMP E --OUTER JOIN은 순서 중요함.
     ON E.DNO = MNSL.DNO
     AND E.SAL = MNSL.MINSAL --급여 중 최소값과 같은 사원을 찾아서 출력
     JOIN DEPT D
     ON D.DNO = MNSL.DNO;
     
--잘못된 GROUP BY
--SELECT절에 컬럼이 하나 추가되는 순간 GROUP BY에도 추가해줘야되기 대문에
--GROUP BY의 의미가 변질된다. 그래서 GROUP BY로 이미 묶여있는 데이터는
--서브쿼리로 빼서 별도의 테이블로 생각하고 사용한다.     
    --잘못된 GROUP BY +원본테이블 그대로 가져오게 되는 케이스.
SELECT SNO
     , CNO
     , MAX(RESULT)
    FROM SCORE
    GROUP BY SNO, CNO
    ORDER BY SNO, CNO; --이러면 그냥 원본테이블과 같음.
    
    
--학생별 최대점수
SELECT SNO
     , MAX(RESULT) AS MAXRES
    FROM SCORE
    GROUP BY SNO;
    
    
--학생별 최대점수의 과목번호
    --SELECT 절에 컬럼 하나 추가된 순간, 전혀 다른 결과
    --GROUP BY는 서브쿼리로 넣어 하나로 묶는게 좋습니다,
SELECT MXRS.SNO
     , SC.CNO
     , MXRS.MAXRES
     FROM ( --학생별 최대점수
             SELECT SNO
             , MAX(RESULT) AS MAXRES
            FROM SCORE
            GROUP BY SNO
     ) MXRS
     JOIN SCORE SC
     ON MXRS.SNO = SC.SNO
     AND MXRS.MAXRES = SC.RESULT --이학생이 가진 것 중 최고점수인 과목 번호 나오게함.
     ORDER BY SNO, CNO;
     
--1-3. SUM
--각 부서별 보너스의 합계
--COMM에 NULL값이 있는 부서가 존재하기 때문에
--NVL로 NULL값을 처리한 COMM값으로 합계를 내야 한다.
SELECT DNO
     , SUM(COMM)
    FROM EMP
    GROUP BY DNO; --COMM이 NULL인 경우와 더해지면, NULL로 나와버린다.
    
SELECT DNO
     , SUM(NVL(COMM,0)) --이렇게 0으로 처리해야함.
    FROM EMP
    GROUP BY DNO;


--1-4. COUNT
--각 학과별 학년별 학생수
SELECT MAJOR
     , SYEAR
     , COUNT(*) -- 모든 컬럼의 카운트
--     , COUNT(SYEAR) -- SYEAR의 카운트 동일
    FROM STUDENT 
    GROUP BY MAJOR, SYEAR; --과/전공별, 학생별 학생수가 나타난다.

--학과별 교수의 수
SELECT SECTION
     , COUNT(*)
    FROM PROFESSOR
    GROUP BY SECTION;
    
--1-5. AVG (평균)
--학과별 평점의 평균
SELECT AVG(AVR)
    FROM STUDENT
    GROUP BY MAJOR;
    
--학과별 평점의 최대 평균
--학과별 평점의 평균을 가져오는 쿼리 만들어진 가상 테이블의 전체 데이터를 사용해서
--통계를 내는 거니까 별도의 GROUP BY는 필요없다.
SELECT MAX(AVG(AVR))
    FROM STUDENT
    GROUP BY MAJOR;
    
--1-6. HAVING절 : GROUP BY절에 명시된 컬럼들에 대한 조건 작성
--DNO에 10, 20, 30인 부서의 평균 급여
SELECT DNO
     , AVG(SAL)
    FROM EMP
    GROUP BY DNO
    HAVING DNO IN ('10','20','30'); --부서번호 102030 평균 연봉 가져온다.
    
--GROUP BY에 명시됐거나 통계함수가 아닌 칼럼은 HAVING절에 사용불가
SELECT DNO
     , AVG(SAL)
    FROM EMP
    GROUP BY DNO
    HAVING COMM > 600; -- COMM이 GROUP BY에 없고, 통계함수 AVG(SAL)이 아닌 이상 사용 불가하다.
    

--AND/OR 여러개의 조건을 붙일 수 있다.
SELECT DNO
     , AVG(SAL)
    FROM EMP
    GROUP BY DNO
    HAVING DNO IN ('10','20','30')
    AND AVG(SAL) <= 3000;
    
--부서 중 평균급여가 가장 높은 부서번호와 평균급여만 조회(EMP 테이블만 사용)
--그룹함수에 대한 조건은 WHERE절에서 사용불가
SELECT DNO
     , AVG(SAL)
    FROM EMP
    GROUP BY DNO
    HAVING AVG(SAL) = (
                            SELECT MAX(AVG(SAL))
                                FROM EMP
                                GROUP BY DNO
                        );

--WHERE절에서 그룹함수를 쓰는 방식은 그룹함수를 사용한 쿼리를 서브쿼리로 묶어서 
--테이블로 만든 다음 사용한다. 별칭을 이용한다.
SELECT *
    FROM (
        SELECT DNO
         , AVG(SAL) AS AVG_SAL
        FROM EMP
        GROUP BY DNO
    ) AVGSAL
    WHERE AVGSAL.AVG_SAL = (
                                SELECT MAX(AVG(SAL))
                                FROM EMP
                                GROUP BY DNO
          
                            );



--임용년도가 동일한 교수의 수를 조회
SELECT TO_CHAR(HIREDATE, 'YYYY')
     , COUNT(*)
    FROM PROFESSOR
    GROUP BY TO_CHAR(HIREDATE, 'YYYY')
    ORDER BY TO_CHAR(HIREDATE, 'YYYY');
