--1) 각 학생의 평점을 검색하라(별칭을 사용)!
SELECT AVR AS 학생평점
    FROM STUDENT;

--2) 각 과목의 학점수를 검색하라(별칭을 사용)
SELECT ST_NUM AS 학점수
    FROM COURSE;

--3) 각 교수의 지위를 검색하라(별칭을 사용)
SELECT ORDERS AS 지위
    FROM PROFESSOR;

--4) 급여를 10%인상했을 때 연간 지급되는 급여를 검색하라(별칭을 사용)
SELECT SAL
    , SAL * 1.1 AS 인상급여
    , SAL * 1.1 * 12 AS 연간인상급여
    FROM EMP;

--5) 현재 학생의 평균 평점은 4.0만점이다. 이를 4.5만점으로 환산해서 검색하라(별칭을 사용)
SELECT AVR
    , ROUND((AVR / 4) * 4.5, 2) AS "4.5학점"
    , ROUND(AVR * (4.5/4), 2) AS "환산학점"
    FROM STUDENT;



