--1) 학생중에 동명이인을 검색한다
SELECT ST.SNO
    , ST.SNAME
    , S.SNO
    , S.SNAME
    FROM STUDENT ST
    JOIN STUDENT S
    ON ST.SNAME = S.SNAME
    AND ST.SNO != S.SNO; --본인을 빼는 절이다.

--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다
SELECT P.*
    , C.CNO
    , C.CNAME
    FROM PROFESSOR P
    LEFT JOIN COURSE C --모두가 나오게 해야 하므로 OUTER JOIN을 한다.
    ON P.PNO = C.PNO
    ORDER BY P.SECTION; --전체의 명단이 나와야 하므로, LEFT OUTER JOIN을 수행하였다.(PROFESSOR 기준)


--3) 이번 학기 등록된 모든 과목과 담당 교수의 학점 순으로 검색한다
SELECT C.*
    , P.PNAME
    FROM COURSE C
    LEFT JOIN PROFESSOR P
    ON C.PNO = P.PNO
    ORDER BY C.ST_NUM;

-- right로도 가능함.
SELECT P.*
    , C.CNO
    , C.CNAME
    FROM PROFESSOR P
    RIGHT JOIN COURSE C
    ON P.PNO = C.PNO
    ORDER BY C.ST_NUM;