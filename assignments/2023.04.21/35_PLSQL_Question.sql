--1) 과목번호, 과목이름, 교수번호, 교수이름을 담을 수 있는 변수들을 선언하고 
--   유기화학 과목의 과목번호, 과목이름, 교수번호, 교수이름을 출력하세요.
CREATE TABLE PRO_ALL(
        CNO,
        CNAME,
        PNO,
        PNAME
        ) AS (
        SELECT C.CNO
             , C.CNAME
             , PNO
             , P.PNAME
            FROM COURSE C
            NATURAL JOIN PROFESSOR P
);

SELECT *
    FROM PRO_ALL
    WHERE CNAME = '유기화학';


--2) 위 데이터들을 레코드로 선언하고 출력하세요.
SET SERVEROUTPUT ON;
DECLARE
    TYPE PRO_REC IS RECORD(
        CNO NUMBER,
        CNAME VARCHAR2(20),
        PNO NUMBER,
        PNAME VARCHAR2(20)
    );
    
    PROREC PRO_REC;
BEGIN
    
    SELECT CNO
         , CNAME
         , PNO
         , PNAME
        INTO PROREC.CNO
           , PROREC.CNAME
           , PROREC.PNO
           , PROREC.PNAME
        FROM PRO_ALL
        WHERE CNAME = '유기화학';
    
--    PROREC.CNO := 1212;
--    PROREC.CNAME := '유기화학';
--    PROREC.PNO := 1002;
--    PROREC.PNAME := '곤송승';
    
    DBMS_OUTPUT.PUT_LINE(PROREC.CNO);
    DBMS_OUTPUT.PUT_LINE(PROREC.CNAME);
    DBMS_OUTPUT.PUT_LINE(PROREC.PNO);
    DBMS_OUTPUT.PUT_LINE(PROREC.PNAME);

END;
/

--3) 과목번호, 과목이름, 과목별 평균 기말고사 성적을 갖는 레코드의 배열을 만들고
--   기본 LOOP문을 이용해서 모든 과목의 과목번호, 과목이름, 과목별 평균 기말고사 성적을 출력하세요.

DECLARE
    TYPE SCORE_REC IS RECORD(
        CNO COURSE.CNO%TYPE,
        CNAME COURSE.CNAME%TYPE,
        AVGRES NUMBER NOT NULL := 0
    );
    
    TYPE SCORE_ARRAY IS TABLE OF SCORE_REC
    INDEX BY PLS_INTEGER;
    
    SCOARR SCORE_ARRAY;
    
    IDX NUMBER := 1;



BEGIN
    FOR SCO IN(
        SELECT CNO
             , C.CNAME
             , AVG(SC.RESULT) AS AVGRES
            FROM COURSE C
            NATURAL JOIN SCORE SC
            GROUP BY CNO, C.CNAME
            ) LOOP
      
           SCOARR(IDX) := SCORE_REC(SCO.CNO, SCO.CNAME, SCO.AVGRES);
--            WHERE ROWNUM = IDX;
                    
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).CNO);
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).CNAME);
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).AVGRES);
        
        IDX := IDX + 1;
        EXIT WHEN SCO.CNO IS NULL;
    END LOOP;
END;
/


--4) 학생번호, 학생이름과 학생별 평균 기말고사 성적을 갖는 테이블 T_STAVGSC를 만들고
--   커서를 이용하여 모든 학생의 학생번호, 학생이름, 학생별 평균 기말고사 성적을 조회하고 
--   조회된 데이터를 생성한 테이블인 T_STAVGSC에 저장하세요.
CREATE TABLE T_STAVGSC(
                SNO NUMBER,
                SNAME VARCHAR2(20),
                AVGRES NUMBER
);

DECLARE
        CURSOR CURST IS
        SELECT SNO
             , ST.SNAME
             , AVG(SC.RESULT) AS AVGRES
        FROM STUDENT ST
        NATURAL JOIN SCORE SC
        GROUP BY SNO, ST.SNAME;
        
    STAVGSC T_STAVGSC%ROWTYPE;    
BEGIN
    FOR STAVGSC IN CURST LOOP
        --조회
        DBMS_OUTPUT.PUT_LINE(STAVGSC.SNO);
        DBMS_OUTPUT.PUT_LINE(STAVGSC.SNAME);
        DBMS_OUTPUT.PUT_LINE(STAVGSC.AVGRES);
        DBMS_OUTPUT.PUT_LINE(CURST%ROWCOUNT);
        
        --저장
        INSERT INTO T_STAVGSC
        VALUES STAVGSC;
    END LOOP;
    
END;
/

SELECT *
    FROM T_STAVGSC;