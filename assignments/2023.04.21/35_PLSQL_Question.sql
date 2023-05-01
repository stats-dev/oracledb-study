--1) 과목번호, 과목이름, 교수번호, 교수이름을 담을 수 있는 변수들을 선언하고 
--   유기화학 과목의 과목번호, 과목이름, 교수번호, 교수이름을 출력하세요.
DECLARE
        CNO COURSE.CNO%TYPE;
        CNAME COURSE.CNAME%TYPE;
        PNO PROFESSOR.PNO%TYPE;
        PNAME PROFESSOR.PNAME%TYPE;
BEGIN
    SELECT C.CNO
         , C.CNAME
         , PNO
         , P.PNAME
        INTO CNO, CNAME, PNO, PNAME --괄호치지 않고 그대로 콤마로 구분해서 넣으면 된다.
        FROM COURSE C
        NATURAL JOIN PROFESSOR P
        WHERE C.CNAME = '유기화학';
            
    DBMS_OUTPUT.PUT_LINE(CNO);
    DBMS_OUTPUT.PUT_LINE(CNAME);
    DBMS_OUTPUT.PUT_LINE(PNO);
    DBMS_OUTPUT.PUT_LINE(PNAME);
END;
/

SET SERVEROUTPUT ON;


DECLARE
    --변수 4개 선언
    CNO VARCHAR2(8);
    CNAME VARCHAR2(20);
    PNO VARCHAR2(8);
    PNAME VARCHAR2(20);
BEGIN
    SELECT C.CNO
         , C.CNAME
         , PNO
         , P.PNAME
        INTO CNO
            , CNAME
            , PNO
            , PNAME --한행씩 가져와서 넣겠다!
        FROM COURSE C
        NATURAL JOIN PROFESSOR P
        WHERE C.CNAME = '유기화학';
    
        DBMS_OUTPUT.PUT_lINE(CNO);
        DBMS_OUTPUT.PUT_lINE(CNAME);
        DBMS_OUTPUT.PUT_lINE(PNO);
        DBMS_OUTPUT.PUT_lINE(PNAME);
END;
/





--2) 위 데이터들을 레코드로 선언하고 출력하세요.
--SET SERVEROUTPUT ON;
DECLARE
    TYPE PRO_REC IS RECORD(
        CNO NUMBER,
        CNAME VARCHAR2(20),
        PNO NUMBER,
        PNAME VARCHAR2(20)
    );
    
    PROREC PRO_REC;
BEGIN
    
    SELECT C.CNO
         , C.CNAME
         , PNO
         , P.PNAME
        INTO PROREC.CNO
           , PROREC.CNAME
           , PROREC.PNO
           , PROREC.PNAME
        FROM COURSE C
        NATURAL JOIN PROFESSOR P
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


DECLARE
    TYPE COURPF_REC IS RECORD(
        CNO COURSE.CNO%TYPE,
        CNAME COURSE.CNAME%TYPE,
        PNO COURSE.PNO%TYPE,
        PNAME PROFESSOR.PNAME%TYPE
    );
    
   COURPfREC COURPF_REC;
   
BEGIN
    
    SELECT C.CNO
         , C.CNAME
         , PNO
         , P.PNAME
        INTO COURPfREC.CNO
           , COURPfREC.CNAME
           , COURPfREC.PNO
           , COURPfREC.PNAME
        FROM COURSE C
        NATURAL JOIN PROFESSOR P
        WHERE CNAME = '유기화학';
    
    DBMS_OUTPUT.PUT_LINE(COURPfREC.CNO);
    DBMS_OUTPUT.PUT_LINE(COURPfREC.CNAME);
    DBMS_OUTPUT.PUT_LINE(COURPfREC.PNO);
    DBMS_OUTPUT.PUT_LINE(COURPfREC.PNAME);

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
    LOOP
        SELECT CNO
             , C.CNAME
             , AVG(SC.RESULT) AS AVGRES
            BULK COLLECT INTO SCOARR
            FROM COURSE C
            NATURAL JOIN SCORE SC
            GROUP BY CNO, C.CNAME;
     
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).CNO);
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).CNAME);
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).AVGRES);
        
        IDX := IDX + 1;
        EXIT WHEN IDX > SCOARR.COUNT;
    END LOOP;
END;
/


-- 기본 LOOP로는 해결이 되지 않아서, FOR LOOP를 사용했습니다. 한 행씩 반복해서 가져올 수 없었습니다.
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
    FOR STROW IN(
        SELECT CNO
             , C.CNAME
             , AVG(SC.RESULT) AS AVGRES
            FROM COURSE C
            NATURAL JOIN SCORE SC
            GROUP BY CNO, C.CNAME
            ) LOOP
      
           SCOARR(IDX) := SCORE_REC(STROW.CNO, STROW.CNAME, STROW.AVGRES);
--            WHERE ROWNUM = IDX;
                    
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).CNO);
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).CNAME);
        DBMS_OUTPUT.PUT_LINE(SCOARR(IDX).AVGRES);
        
        IDX := IDX + 1;
        EXIT WHEN STROW.CNO IS NULL;
    END LOOP;
END;
/


--해설
--3) 과목번호, 과목이름, 과목별 평균 기말고사 성적을 갖는 레코드의 배열을 만들고
--   기본 LOOP문을 이용해서 모든 과목의 과목번호, 과목이름, 과목별 평균 기말고사 성적을 출력하세요.
--   기본 LOOP문은 커서를 무조건 선언해서 해결해야 한다.
--   아니면 FOR LOOP로 한다.
DECLARE
    TYPE COURSEAVG_REC IS RECORD(
        CNO COURSE.CNO%TYPE,
        CNAME COURSE.CNAME%TYPE,
        AVGRES NUMBER(5, 2)
    );

    TYPE COURSEAVG_ARR IS TABLE OF COURSEAVG_REC
    INDEX BY PLS_INTEGER;
    
    --배열 타입의 변수명 설정
    COURSEAVGARR COURSEAVG_ARR;
    
    IDX NUMBER := 1; --시작번호 1번

BEGIN
    FOR i IN ( --i.CNAME 이런식으로 꺼내서 평균값이 꺼내지도록 설정한다.
                SELECT CNO
                     , C.CNAME
                     , ROUND(AVG(SC.RESULT), 2) AS AVGRES
                    FROM COURSE C
                    NATURAL JOIN SCORE SC
                    GROUP BY CNO, C.CNAME
                ) LOOP
            COURSEAVGARR(IDX).CNO := i.CNO;
            COURSEAVGARR(IDX).CNAME := i.CNAME;
            COURSEAVGARR(IDX).AVGRES := i.AVGRES;
            
            DBMS_OUTPUT.PUT_LINE(COURSEAVGARR(IDX).CNO);
            DBMS_OUTPUT.PUT_LINE(COURSEAVGARR(IDX).CNAME);
            DBMS_OUTPUT.PUT_LINE(COURSEAVGARR(IDX).AVGRES);
            
            IDX := IDX + 1;
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
    
--ANSWER
CREATE  TABLE T_STAVGSC1 (
    SNO NUMBER,
    SNAME VARCHAR2(20),
    AVGRES NUMBER(5, 2)
);

--선언부
DECLARE
    CURSOR CUR_STAVGSC IS
    SELECT ST.SNO
         , ST.SNAME
         , NVL(ROUND(AVG(SC.RESULT), 2), 0) AS AVGRES --NULL이면 0점으로 처리
        FROM STUDENT ST
        LEFT JOIN SCORE SC
        ON ST.SNO = SC.SNO
        GROUP BY ST.SNO, ST.SNAME; --쿼리 결과를 커서에 담는다.
        
    ROW_STAVGSC T_STAVGSC1%ROWTYPE;
BEGIN
    OPEN CUR_STAVGSC; --커서명으로 오픈!
    
    LOOP
        FETCH CUR_STAVGSC INTO ROW_STAVGSC; --로우타입 한줄 데이터에 넣는다.
        
        EXIT WHEN CUR_STAVGSC%NOTFOUND; --더이상 커서 발견 못하면 루프문 종료
        
        INSERT INTO T_STAVGSC1
        VALUES ROW_STAVGSC; --로우타입에 넣는다.
    
    END LOOP;
END;
/

SELECT *
    FROM T_STAVGSC1;