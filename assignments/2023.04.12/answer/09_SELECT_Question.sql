--1) 송강 교수가 강의하는 과목을 검색한다
SELECT C.*
    , P.PNAME
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO
    AND P.PNAME = '송강';
--    WHERE P.PNAME = '송강'; --WHERE절로 빼도 되고, AND절로 바로 조건을 더 넣어도 된다!!

--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
SELECT P.*
    , C.CNO
    , C.CNAME
    FROM PROFESSOR P
    JOIN COURSE C
    ON P.PNO = C.PNO
        AND C.CNAME LIKE '%화학%';

--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다
SELECT C.*
    , P.PNAME
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO
        AND C.ST_NUM = 2;

--4) 화학과 교수가 강의하는 과목을 검색한다
SELECT C.*
    , P.PNO
    , P.PNAME
    , P.SECTION
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO
        AND P.SECTION = '화학';

--5) 화학과 1학년 학생의 기말고사 성적을 검색한다
SELECT ST.*
    , SC.CNO
    , SC.RESULT
    FROM STUDENT ST
    JOIN SCORE SC
    ON ST.SNO = SC.SNO
        AND ST.MAJOR = '화학'
        AND ST.SYEAR = 1
    JOIN COURSE C
    ON SC.CNO = C.CNO
        ORDER BY SC.CNO, SC.RESULT DESC; --과목별 점수 순서대로 나온다.

--6) 일반화학 과목의 기말고사 점수를 검색한다
SELECT SC.CNO
    , C.CNAME
    , SC.RESULT
    , SC.SNO
    FROM SCORE SC
    JOIN COURSE C
    ON SC.CNO = C.CNO
        AND C.CNAME = '일반화학'
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    ORDER BY SC.RESULT DESC;

--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다
SELECT ST.*
    , C.CNAME
    , SC.CNO
    , SC.RESULT
    FROM STUDENT ST
    JOIN SCORE SC
    ON ST.SNO = SC.SNO
        AND ST.MAJOR = '화학'
        AND ST.SYEAR = 1
    JOIN COURSE C
    ON SC.CNO = C.CNO
        AND C.CNAME = '일반화학'
        ORDER BY SC.CNO, SC.RESULT DESC; --과목별 점수 순서대로 나온다.


--8) 화학과 1학년 학생이 수강하는 과목을 검색한다
SELECT DISTINCT SC.CNO --DISTINCT로 하나씩만 출력하게 한다.
    , C.CNAME
    FROM SCORE SC
    JOIN COURSE C --SCORE랑 COURSE 조인한다.
    ON SC.CNO = C.CNO
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO --STUDENT에서는 가져오는 내용이 없어야 DISTINCT가 가능하다!!!
    AND ST.MAJOR = '화학'
    AND ST.SYEAR = 1;

--9) 유기화학 과목의 평가점수가 F인 학생의 명단을 검색한다
SELECT ST.*
    , C.CNO
    , C.CNAME
    , SG.GRADE
    FROM STUDENT ST
    JOIN SCORE SC --SCORE랑 먼저 조인함.
    ON ST.SNO = SC.SNO
    JOIN COURSE C--COURSE랑 조인함.
    ON SC.CNO = C.CNO
    JOIN SCGRADE SG
    ON SC.RESULT BETWEEN LOSCORE AND HISCORE --여기서는 SG를 생략해도 되네? 신기하다. 질문하기.
    AND SG.GRADE = 'F'
    AND C.CNAME = '유기화학';
    

