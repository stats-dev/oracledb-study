--WHERE 조건절 사용!
--1) 화학과 학생을 검색하라
SELECT *
    FROM STUDENT
    WHERE MAJOR = '화학';

--2) 평점이 2.0 미만인 학생을 검색하라
SELECT SNAME, AVR
    FROM STUDENT
    WHERE AVR < 2.0;

--3) 관우 학생의 평점을 검색하라
SELECT SNAME, AVR
    FROM STUDENT
    WHERE SNAME = '관우';

--4) 정교수 명단을 검색하라
SELECT PNAME, ORDERS
    FROM PROFESSOR
    WHERE ORDERS = '정교수';

--5) 화학과 소속 교수의 명단을 검색하라
SELECT PNAME, SECTION
    FROM PROFESSOR
    WHERE SECTION = '화학';

--6) 송강 교수의 정보를 검색하라
SELECT *
    FROM PROFESSOR
    WHERE PNAME = '송강';

--7) 학년별로 화학과 학생의 성적을 검색하라
SELECT *
    FROM STUDENT
    WHERE MAJOR = '화학'
    ORDER BY SYEAR;
    

--8) 2000년 이전에 부임한 교수의 정보를 부임일순으로 검색하라
SELECT PNAME
    , HIREDATE
    , EXTRACT(YEAR FROM HIREDATE)
    FROM PROFESSOR
    WHERE EXTRACT(YEAR FROM HIREDATE) < 2000
    ORDER BY HIREDATE;

SELECT PNAME
    , HIREDATE
    , substr(HIREDATE, 1, 2) as YEAR
    FROM PROFESSOR
    WHERE substr(HIREDATE, 1, 2) > 00
    ORDER BY HIREDATE;



--9) 담당 교수가 없는 과목의 정보를 검색하라
SELECT *
    FROM COURSE
    WHERE PNO IS NULL;

