--뷰 이름은 자유
--1) 학생의 평점 4.5 만점으로 환산된 정보를 검색할 수 있는 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_AVG_AVR(
        SNO,
        SNAME,
        MAJOR,
        AVR,
        CONV_AVR
    ) AS (
            SELECT SNO
                 , SNAME
                 , MAJOR
                 , AVR
                 , ROUND(AVR * 4.5 / 4.0, 2) AS CONV_AVR
                FROM STUDENT
    );

--DROP VIEW V_AVG_AVR;
SELECT *
    FROM V_AVG_AVR;

--2) 각 과목별 기말고사 평균 점수를 검색할 수 있는 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_AVG_SCORE(
        CNO,
        CNAME,
        AVRES
       ) AS (       
              SELECT CNO
                 , C.CNAME
                 , ROUND(AVG(SC.RESULT), 2) AS AVRES
                FROM COURSE C
                NATURAL JOIN SCORE SC
                GROUP BY CNO, C.CNAME
);

SELECT *
    FROM V_AVG_SCORE;



--3) 각 사원과 관리자의 이름을 검색할 수 있는 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_ALL_ENAME(
                ENO,
                ENAME,
                MGR,
                MGR_NAME
) AS (
            SELECT A.ENO
                 , A.ENAME
                 , A.MGR
                 , B.ENAME
                FROM EMP A
                LEFT JOIN EMP B
                ON A.MGR = B.ENO
);

SELECT *
    FROM V_ALL_ENAME;


--4) 각 과목별 기말고사 평가 등급(A~F)까지와 해당 학생 정보를 검색할 수 있는 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_CO_GRADE_STU(
        CNO,
        CNAME,
        RESULT,
        SCGRADE,
        SNO,
        SNAME,
        MAJOR,
        SYEAR
) AS (

        SELECT CNO
             , C.CNAME
             , SC.RESULT
             , SG.GRADE
             , SNO
             , ST.SNAME
             , ST.MAJOR
             , ST.SYEAR
            FROM COURSE C
            NATURAL JOIN SCORE SC
            NATURAL JOIN STUDENT ST
            JOIN SCGRADE SG
            ON SC.RESULT BETWEEN SG.LOSCORE AND SG.HISCORE

);

SELECT *
    FROM V_CO_GRADE_STU;
    
    
--5) 물리학과 교수의 과목을 수강하는 학생의 명단을 검색할 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_PHY_CO_STU (
                                            CNO,
                                            CNAME,
                                            PNAME,
                                            SECTION,
                                            SNO,
                                            SNAME,
                                            MAJOR,
                                            SYEAR
) AS (
        SELECT CNO
             , C.CNAME
             , P.PNAME
             , P.SECTION
             , SNO
             , ST.SNAME
             , ST.MAJOR
             , ST.SYEAR
            FROM COURSE C
            NATURAL JOIN PROFESSOR P
            NATURAL JOIN STUDENT ST
            WHERE P.SECTION = '물리'

);

SELECT *
    FROM V_PHY_CO_STU;
