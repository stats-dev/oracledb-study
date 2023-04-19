--DELETE FROM STUDENT
--    WHERE SNAME = '홍길동';


--1) 4.5 환산 평점이 가장 높은 3인의 학생을 검색하세요.
SELECT ROWNUM
     , A.SNO
     , A.SNAME
     , A.CONV_AVR
    FROM (
            SELECT SNO
                 , SNAME
                 , ROUND(AVR * 4.5 / 4.0, 2) AS CONV_AVR
                FROM STUDENT    
                ORDER BY CONV_AVR DESC
            ) A
    WHERE ROWNUM <= 3;



--2) 기말고사 과목별 평균이 높은 3과목을 검색하세요.
SELECT ROWNUM
     , A.CNO
     , A.CNAME
     , A.RES
    FROM (
            SELECT CNO
                 , C.CNAME
                 , ROUND(AVG(SC.RESULT), 2) AS RES
                FROM COURSE C
                NATURAL JOIN SCORE SC
                GROUP BY CNO, C.CNAME
                ORDER BY RES DESC
            ) A
    WHERE ROWNUM <= 3;


--3) 학과별, 학년별, 기말고사 평균이 순위 3까지를 검색하세요.(학과, 학년, 평균점수 검색)
SELECT ROWNUM
     , A.MAJOR
     , A.SYEAR
     , A.AV_MAJOR
    FROM (
            SELECT ST.SYEAR
                , ST.MAJOR
                 , ROUND(AVG(SC.RESULT), 2) AS AV_MAJOR
                FROM STUDENT ST
                JOIN SCORE SC
                ON ST.SNO = SC.SNO
                GROUP BY ST.MAJOR, ST.SYEAR
                ORDER BY AV_MAJOR DESC
    ) A
    WHERE ROWNUM <= 3;






--4) 기말고사 성적이 높은 과목을 담당하는 교수 3인을 검색하세요.(교수이름, 과목명, 평균점수 검색)
SELECT ROWNUM
     , P.PNAME
     , C.CNAME
     , A.AVRES
    FROM PROFESSOR P
    JOIN COURSE C
    ON P.PNO = C.PNO
    JOIN (
            SELECT CNO
                 , ROUND(AVG(SC.RESULT), 2) AS AVRES
                FROM COURSE C
                NATURAL JOIN SCORE SC
                GROUP BY CNO
                ORDER BY AVRES DESC
            ) A
    ON C.CNO = A.CNO
    WHERE ROWNUM <= 3;

    

--5) 교수별로 현재 수강중인 학생의 수를 검색하세요.
SELECT A.PNO
     , A.PNAME
     , COUNT(*)
    FROM (
          SELECT PNO
             , P.PNAME
             , CNO
             , SNO
            FROM PROFESSOR P
            NATURAL JOIN COURSE C
            NATURAL JOIN SCORE SC  
    ) A
    GROUP BY A.PNO, A.PNAME;



