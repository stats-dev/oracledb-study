--1) 각 과목의 과목명과 담당 교수의 교수명을 검색하라
SELECT C.CNO
    , C.CNAME
    , C.PNO
    , P.PNAME
    FROM PROFESSOR P
    RIGHT JOIN COURSE C
    ON P.PNO = P.PNO;

--2) 화학과 학생의 기말고사 성적을 모두 검색하라
SELECT SC.CNO
    , C.CNAME
    , SC.SNO
    , ST.SNAME
    , SC.RESULT
    FROM SCORE SC
    JOIN  COURSE C
    ON SC.CNO = C.CNO
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    AND ST.MAJOR = '화학';


--3) 유기화학과목 수강생의 기말고사 시험점수를 검색하라
SELECT SC.CNO
    , C.CNAME
    , SC.SNO
    , ST.SNAME
    , SC.RESULT
    FROM SCORE SC
    JOIN  COURSE C
    ON SC.CNO = C.CNO
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    AND C.CNAME = '유기화학';

--4) 화학과 학생이 수강하는 과목을 담당하는 교수의 명단을 검색하라
SELECT DISTINCT SC.CNO --겹치는게 많으면 디스팅트!
    , C.CNAME
    , P.PNO
    , P.PNAME
    FROM SCORE SC
    JOIN COURSE C
    ON SC.CNO = C.CNO
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    JOIN PROFESSOR P
    ON C.PNO = P.PNO
    AND ST.MAJOR = '화학';

--5) 모든 교수의 명단과 담당 과목을 검색한다
SELECT P.*
    , C.CNO
    , C.CNAME
    FROM PROFESSOR P
    LEFT JOIN COURSE C
    ON P.PNO = C.PNO;

--6) 모든 교수의 명단과 담당 과목을 검색한다(단 모든 과목도 같이 검색한다)
SELECT P.*
    , C.CNO
    , C.CNAME
    FROM PROFESSOR P
    FULL OUTER JOIN COURSE C
    ON P.PNO = C.PNO;
