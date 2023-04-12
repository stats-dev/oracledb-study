--1)student 테이블 구조를 검색해라!
DESC STUDENT;

--2)course 테이블 구조를 검색해라
DESC COURSE;

--3)professor 테이블 구조를 검색해라
DESC PROFESSOR;

--4)score 테이블 구조를 검색해라
DESC SCORE;

--5) 모든 학생의 정보를 검색해라
SELECT *
    FROM STUDENT;

--7) 모든 과목의 정보를 검색해라
SELECT *
    FROM COURSE;

--8) 기말고사 시험점수를 검색해라
SELECT RESULT
    FROM SCORE;

-- 조회할때는 PKO를 함께 넣어주어야 올바르게 출력이 가능하다! 기억!
--9) 학생들의 학과와 학년을 검색해라
SELECT SNO
    , SNMAE
    , MAJOR
    , SYEAR
    FROM STUDENT;

--10) 각 과목의 이름과 학점을 검색해라
SELECT CNO
    , CNAME
    , ST_NUM
    FROM COURSE;

--11) 모든 교수의 직위를 검색해라
SELECT ORDERS
    FROM PROFESSOR;
