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

--***23 질문
WITH
    REGLARPF AS (SELECT * FROM PROFESSOR WHERE ORDERS = '정교수'),
    NORMALCS AS (SELECT * FROM COURSE WHERE CNAME LIKE '일반%') --일반으로 시작하는 데이터만 모으겠다.
SELECT NORMALCS.CNO
     , NORMALCS.CNAME
     , PNO
     , REGLARPF.PNAME
    FROM REGLARPF
    NATURAL JOIN NORMALCS;


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
    

WITH SALOVER AS (SELECT * FROM EMP WHERE SAL >= 3000),
     COMMOVER AS (SELECT * FROM EMP WHERE COMM >= 500) --사실상 SELF JOIN에 가깝다.
     --그래서 NATURAL JOIN을 하려면, 모든 별칭을 다 제거해야 한다.
SELECT ENO
     , ENAME
     , JOB
     , MGR
     , HDATE
     , SAL
     , COMM
     , DNO
    FROM SALOVER
    NATURAL JOIN COMMOVER;

WITH SALOVER AS (SELECT * FROM EMP WHERE SAL >= 3000),
     COMMOVER AS (SELECT * FROM EMP WHERE COMM >= 500)
SELECT COMMOVER.*
    FROM COMMOVER
    JOIN SALOVER
    ON COMMOVER.ENO = SALOVER.ENO;


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
     , TTHREE.SNAME
     , TTHREE.AVR
     , AVRESST.AVRES
    FROM TTHREE, 
    AVRESST
    WHERE TTHREE.SNO = AVRESST.SNO;
 
 
 
WITH
    AVROVER AS (SELECT * FROM STUDENT WHERE AVR >= 3.3),
    AVGRES AS (SELECT SNO, ROUND(AVG(RESULT), 2) AS AVGSC FROM SCORE GROUP BY SNO)

SELECT SNO
     , AVROVER.SNAME
     , AVROVER.AVR
     , AVGRES.AVGSC --기말평균
    FROM AVROVER
    NATURAL JOIN AVGRES;
    

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


WITH
     HIREOVER AS (SELECT * FROM PROFESSOR WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12 >= 25),
     COUSTPF AS (
                    SELECT CNO
                         , C.CNAME
                         , SNO
                         , ST.SNAME
                         , C.PNO
                         , SC.RESULT
                        FROM SCORE SC
                        NATURAL JOIN COURSE C
                        NATURAL JOIN STUDENT ST
                )
SELECT COUSTPF.CNO
     , COUSTPF.CNAME
     , COUSTPF.SNO
     , COUSTPF.SNAME
     , HIREOVER.PNO --이건 NULL인 케이스가 있어서 OUTER JOIN을 쓰며, 이 때는 별칭을 붙여야한다.
     , HIREOVER.PNAME
     , COUSTPF.RESULT
    FROM COUSTPF
    LEFT JOIN HIREOVER
    ON COUSTPF.PNO = HIREOVER.PNO
    WHERE COUSTPF.RESULT >= 90;

