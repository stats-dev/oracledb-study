--1) 각 학과별 학생 수를 검색하세요
SELECT COUNT(*)
     , MAJOR
     FROM STUDENT
     GROUP BY MAJOR;

--2) 화학과와 생물학과 학생 4.5 환산 평점의 평균(모든 학생)을 각각 검색하세요
SELECT AVG(AVR / 4 * 4.5)
     , MAJOR
    FROM STUDENT
    GROUP BY MAJOR
    HAVING MAJOR IN ('화학', '생물');

--3) 부임일이 10년 이상 된 직급별(정교수, 조교수, 부교수) 교수의 수를 검색하세요
SELECT COUNT(*)
     , ORDERS
    FROM (
            SELECT ORDERS
            , HIREDATE
            FROM PROFESSOR
            WHERE (MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12) >= 10
            )
    GROUP BY ORDERS;


--4) 과목명에 화학이 포함된 과목의 학점수 총합을 검색하세요
-- (SUM, ESTINUM?)
SELECT SUM(ST_NUM)
    FROM COURSE
    WHERE CNAME LIKE '%화학%';


SELECT SUM(ST_NUM_ALL)
    FROM (SELECT CNAME
             , SUM(ST_NUM) AS ST_NUM_ALL
             FROM COURSE
             GROUP BY CNAME
             HAVING CNAME LIKE '%화학%'
    );


--5) 학과별 기말고사 평균을 성적순(성적 내림차순)으로 검색하세요
-- JOIN, 학과별 평균
SELECT AVG(SC.RESULT)
     , ST.MAJOR
     FROM SCORE SC
     JOIN STUDENT ST
     ON SC.SNO = ST.SNO
     GROUP BY ST.MAJOR
     ORDER BY AVG(SC.RESULT) DESC;

--6) 30번 부서의 업무별 연봉의 평균을 검색하세요(소수점 두자리까지 표시)
SELECT ROUND(AVG(SAL), 2)
     , JOB
     FROM EMP
     WHERE DNO = 30
     GROUP BY JOB;
     

--7) 물리학과 학생 중에 학년별로 성적이 가장 우수한 학생의 평점을 검색하세요(학과, 학년, 평점)
-- MAX
SELECT MAX(AVR)
     , SYEAR
     , MAJOR
     FROM STUDENT
     WHERE MAJOR = '물리'
     GROUP BY MAJOR, SYEAR
     ORDER BY SYEAR;