--1) 학생중에 동명이인을 검색한다(SELF JOIN)
SELECT A.SNO
    , A.SNAME
    , B.SNO
    , B.SNAME
    FROM STUDENT A
    JOIN STUDENT B
    ON A.SNAME = B.SNAME
        AND A.SNO != B.SNO;

--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다(COURSE, PROFESSOR JOIN)
SELECT C.CNO
    , C.CNAME
    , C.PNO
    , P.PNO
    , P.PNAME
    , P.SECTION
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO
    ORDER BY P.SECTION;
    

--3) 이번 학기 등록된 모든 과목과 담당 교수의 학점 순으로 검색한다
SELECT C.CNO
    , C.CNAME
    , C.ST_NUM
    , C.PNO
    , P.PNO
    , P.PNAME
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO
    ORDER BY C.ST_NUM;
