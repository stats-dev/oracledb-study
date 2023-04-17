--1) 각 과목의 과목번호, 과목명, 담당 교수의 교수번호, 교수명을 검색하라(NATURAL JOIN 사용)
SELECT C.CNO
     , C.CNAME
     , PNO
     , P.PNAME
    FROM COURSE C
    NATURAL JOIN PROFESSOR P;

--2) 화학과 학생의 기말고사 성적을 모두 검색하라(JOIN USING 사용)
SELECT SNO
     , ST.SNAME
     , ST.MAJOR
     , SC.RESULT
    FROM STUDENT ST
    JOIN SCORE SC
    USING (SNO)
    WHERE ST.MAJOR = '화학';
    

--3) 화학 관련 과목을 강의하는 교수의 명단을 검색한다(NATURAL JOIN 사용)
SELECT C.CNO
     , C.CNAME
     , PNO
     , P.PNAME
    FROM COURSE C
    NATURAL JOIN PROFESSOR P
    WHERE C.CNAME LIKE '%화학%';

--4) 화학과 1학년 학생의 기말고사 성적을 검색한다(NATURAL JOIN 사용)
SELECT SNO
     , ST.SNAME
     , ST.MAJOR
     , ST.SYEAR
     , SC.RESULT
    FROM STUDENT ST
    NATURAL JOIN SCORE SC
    WHERE ST.MAJOR = '화학'
        AND ST.SYEAR = 1;
     

--5) 일반화학 과목의 기말고사 점수를 검색한다(JOIN USING 사용)
SELECT CNO
     , C.CNAME
     , SC.RESULT
    FROM COURSE C
    JOIN SCORE SC
    USING (CNO)
    WHERE C.CNAME = '일반화학';

--6) 화학과 1학년 학생이 수강하는 과목을 검색한다(NATURAL JOIN 사용)
SELECT CNO
     , C.CNAME
     , SNO
     , ST.SNAME
     , ST.MAJOR
     , ST.SYEAR
    FROM COURSE C
    NATURAL JOIN SCORE SC
    NATURAL JOIN STUDENT ST
    WHERE ST.MAJOR = '화학'
        AND ST.SYEAR = 1;
    