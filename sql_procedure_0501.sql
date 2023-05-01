--1. STORED PROCEDURE
--1-1. 파라미터가 없는 프로시저
--프로시저 선언
CREATE OR REPLACE PROCEDURE PRO_NOPARAM
IS
    ENO VARCHAR2(8);
    ENAME VARCHAR2(20);
BEGIN
    ENO := '9999';
    ENAME := '장길산';
    
    INSERT INTO EMP (ENO, ENAME)
    VALUES(ENO, ENAME);
END;
/
    
-- Procedure PRO_NOPARAM이(가) 컴파일되었습니다.

--프로시저 실행
EXEC PRO_NOPARAM;

SELECT *
    FROM EMP
    WHERE ENO = '9999';
    

--일반화학의 학생별 기말고사 성적을 저장하는 테이블 생성
CREATE TABLE T_NCHE_SC1
AS SELECT SC.*, ST.SNAME 
    FROM SCORE SC 
    JOIN COURSE C
    ON SC.CNO = C.CNO
    RIGHT JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    WHERE C.CNAME = '일반화학1';

    
SELECT *
    FROM T_NCHE_SC1;
    
--GRADE까지 가지는 일반화학 학생별 기말고사 성적 테이블    
CREATE TABLE T_NCHE_SCGR1(
    SNO NUMBER PRIMARY KEY,
    SNAME VARCHAR2(20),
    RESULT NUMBER(5, 2),
    GRADE CHAR(1)
);

--T_NCHE_SC1을 참조해서 T_NCHE_SCGR에 데이터를 저장하는
--프로시저 선언
CREATE OR REPLACE PROCEDURE P_NCHE_SCGR
IS 
    --레코드
    TYPE P_NCHE_REC IS RECORD(
        SNO T_NCHE_SCGR.SNO%TYPE,
        SNAME T_NCHE_SCGR.SNAME%TYPE,
        RESULT T_NCHE_SCGR.RESULT%TYPE,
        GRADE T_NCHE_SCGR.GRADE%TYPE      
    );
    --레코드변수 선언
    NCREC P_NCHE_REC;
    
    --커서 (조회할때 등급 추가)
    CURSOR CURST IS
    SELECT T.SNO
         , T.SNAME
         , T.RESULT
         , GR.GRADE
        FROM T_NCHE_SCGR T
        JOIN SCGRADE GR
        ON T.RESULT BETWEEN GR.LOSCORE AND GR.HISCORE;
        
    ROW_NCREC P_NCHE_REC%ROWTYPE;
        

BEGIN
    --커서 오픈
    OPEN CURST;
    --루프
    LOOP
        --FETCH
        FETCH CURST INTO ROW_NCREC;
        
        --점수별 등급 조건문(IF THEN~ELSIF THEN~ELSE)
        IF P_NCHE_REC.SCORE >= 90
        THEN P_NCHE_REC.GRADE := 'A';
        ELSIF P_NCHE_REC.SCORE >= 80
        THEN P_NCHE_REC.GRADE := 'B';
        ELSIF P_NCHE_REC.SCORE >= 70
        THEN P_NCHE_REC.GRADE := 'C';
        ELSE P_NCHE_REC.SCORE >= 60
        THEN P_NCHE_REC.GRADE := 'D';
        
        
        --인서트문 
        INSERT INTO ();
        
    --루프끝
    END LOOP;
    
    --커서 클로즈
    
END;
/
    
    
CREATE OR REPLACE PROCEDURE P_NCHE_SCGR
IS

    --레코드
    TYPE NCHE_SCGR_REC IS RECORD(
        SNO T_NCHE_SCGR1.SNO%TYPE,
        SNAME T_NCHE_SCGR1.SNAME%TYPE,
        RESULT T_NCHE_SCGR1.RESULT%TYPE,
        GRADE T_NCHE_SCGR1.GRADE%TYPE
    );
    
    --레코드 변수 선언
    NCHESCGRREC NCHE_SCGR_REC;
    
    --커서(쿼리의 결과를 저장하는 자료형)
    CURSOR CUR_NCHE_SCGR IS
    SELECT NCS.SNO
         , NCS.SNAME
         , NCS.RESULT
         , 'X' --GRADE가 없으니 이렇게 들어가게 짜면 된다. 한글자만 가능.
        FROM T_NCHE_SC1 NCS;
        
BEGIN
    --커서 오픈
    OPEN CUR_NCHE_SCGR;
    --루프
    LOOP
        --패치 : 패치할 때 같아야 한다.
        FETCH CUR_NCHE_SCGR INTO NCHESCGRREC; --결과의 한 행씩 담는다.
        
        EXIT WHEN CUR_NCHE_SCGR%NOTFOUND; --없으면 빠져나가라
        
        --점수별 등급 조건문
        IF NCHESCGRREC.RESULT >= 90 THEN
            NCHESCGRREC.GRADE := 'A';
        ELSIF NCHESCGRREC.RESULT >= 80 THEN
            NCHESCGRREC.GRADE := 'B';
        ELSIF NCHESCGRREC.RESULT >= 70 THEN
            NCHESCGRREC.GRADE := 'C';
        ELSIF NCHESCGRREC.RESULT >= 60 THEN
            NCHESCGRREC.GRADE := 'D';            
        ELSE NCHESCGRREC.GRADE := 'F';
        END IF;
    
    
        --인서트문
        INSERT INTO T_NCHE_SCGR1
        VALUES NCHESCGRREC;
        
        
    --루프 끝
    END LOOP;
    
    --커서 클로즈
    CLOSE CUR_NCHE_SCGR;
END;
/


EXEC P_NCHE_SCGR;

SELECT *
    FROM T_NCHE_SCGR1;