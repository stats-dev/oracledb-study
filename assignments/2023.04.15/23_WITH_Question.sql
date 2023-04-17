--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)
WITH
    PRO AS (SELECT PNO, PNAME, ORDERS FROM PROFESSOR WHERE ORDERS = '정교수'),
    CSE AS (SELECT PNO, CNO, CNAME FROM COURSE WHERE CNAME LIKE '%일반%')
SELECT CSE.CNO
     , CSE.CNAME
     , PRO.PNO
     , PRO.PNAME
    FROM PRO, CSE
    WHERE CSE.PNO = PRO.PNO;


--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.

WITH 
    EMTHREE AS (SELECT * FROM EMP WHERE SAL >= 3000),
    COMMFIVE AS (SELECT * FROM EMP WHERE COMM >= 500)
SELECT EMTHREE.ENO
     , EMTHREE.ENAME
     , EMTHREE.SAL
     , COMMFIVE.COMM
    FROM EMTHREE,
    COMMFIVE
    WHERE EMTHREE.ENO = COMMFIVE.ENO;
    


--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.
WITH 
    TTHREE AS (SELECT SNO, SNAME, AVR FROM STUDENT WHERE AVR >= 3.3),
    AVRESST AS (
                SELECT SNO
                     , ST.SNAME
                     , AVG(SC.RESULT) AS AVRES
                    FROM STUDENT ST
                    NATURAL JOIN SCORE SC
                    GROUP BY SNO, ST.SNAME    
    )
SELECT TTHREE.SNO
     , TTHREE.AVR
     , TTHREE.SNAME
     , AVRESST.AVRES
    FROM TTHREE, 
    AVRESST
    WHERE TTHREE.SNO = AVRESST.SNO;
    

--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을
--   갖는 가상테이블 하나를 생성하여 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.
WITH
    OLDPRO AS (SELECT * FROM PROFESSOR WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 25 * 12),
    COURSEALL AS (
                    SELECT CNO
                         , C.CNAME
                         , SNO
                         , ST.SNAME
                         , C.PNO
                         , SC.RESULT
                        FROM COURSE C
                        NATURAL JOIN STUDENT ST
                        NATURAL JOIN SCORE SC    
            )
SELECT COURSEALL.CNO
     , COURSEALL.CNAME
     , COURSEALL.SNO
     , COURSEALL.SNAME
     , OLDPRO.PNO
     , OLDPRO.PNAME
     , COURSEALL.RESULT
    FROM COURSEALL,
        OLDPRO
    WHERE COURSEALL.RESULT >= 90;


    

