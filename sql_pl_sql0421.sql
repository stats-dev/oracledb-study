--1. PL/SQL
SET SERVEROUTPUT ON;


--1-6. 레코드
--레코드는 다양한 데이터타입의 변수를 갖는 데이터들의 집합(자바의 클래스에서 메소드만 빠진 형태랑 비슷)
DECLARE
    --레코드 선언부
    TYPE STU_REC IS RECORD( --변수명 아무거나 가능.
        --사용할 다양한 데이터타입의 변수들 선언
        SNO VARCHAR2(5) NOT NULL := '11012',
        SNAME STUDENT.SNAME%TYPE,
        SEX STUDENT.SEX%TYPE,
        SYEAR NUMBER(1) DEFAULT 1,
        MAJOR STUDENT.MAJOR%TYPE,
        AVR STUDENT.AVR%TYPE  
    );
    
    --레코드 변수 선언
    STUDENTREC STU_REC;
BEGIN
    --속성정의
    STUDENTREC.SNO := '11010'; --위에서 만든 변수명 넣기
    STUDENTREC.SNAME := '고기천';
    STUDENTREC.SEX := '남';
    STUDENTREC.MAJOR := '화학';
    STUDENTREC.AVR := 2.5;
    
    --출력
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.SNO);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.SNAME);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.SEX);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.MAJOR);
    DBMS_OUTPUT.PUT_LINE(STUDENTREC.AVR);
END;
/

--레코드를 이용해서 데이터 저장할 테이블 생성
CREATE TABLE STUDENT_RECORD
AS SELECT * FROM STUDENT;


--레코드를 이용해서 데이터 저장
DECLARE
    TYPE STU_REC IS RECORD( --변수명 아무거나 가능.
        --데이터가 저장될 테이블의 컬럼의 순서와 타입을 모두 동일하게 맞춰야 한다.
        SNO VARCHAR2(8) NOT NULL := '11012',
        SNAME STUDENT.SNAME%TYPE,
        SEX STUDENT.SEX%TYPE,
        SYEAR NUMBER(1, 0) DEFAULT 1,
        MAJOR STUDENT.MAJOR%TYPE,
        AVR STUDENT.AVR%TYPE  
    );
    
    STUDENTREC STU_REC;
BEGIN
    STUDENTREC.SNO := '11010'; --위에서 만든 변수명 넣기
    STUDENTREC.SNAME := '고기천';
    STUDENTREC.SEX := '남';
    STUDENTREC.MAJOR := '화학';
    STUDENTREC.AVR := 2.5;
    
    STUDENTREC.SNO := '11011'; 
    STUDENTREC.SNAME := '문동주';
    STUDENTREC.SEX := '여';
    STUDENTREC.MAJOR := '컴공';
    STUDENTREC.AVR := 4.0;
    
    --인서트
    INSERT INTO STUDENT_RECORD
    VALUES STUDENTREC;
    
    --인서트
    INSERT INTO STUDENT_RECORD
    VALUES STUDENTREC; --위에 입력했던 것을 바로 집어넣겠다. 타입과 순서를 잘 맞춰야 합니다.
END;
/


--저장된 데이터 확인
SELECT *
    FROM STUDENT_RECORD
    WHERE SNO = '11011';


--레코드를 이용한 데이터 수정(UPDATE)

DECLARE
    TYPE STU_REC IS RECORD( --변수명 아무거나 가능.
        --데이터가 저장될 테이블의 컬럼의 순서와 타입을 모두 동일하게 맞춰야 한다.
        SNO VARCHAR2(8) NOT NULL := '11012',
        SNAME STUDENT.SNAME%TYPE,
        SEX STUDENT.SEX%TYPE,
        SYEAR NUMBER(1, 0) DEFAULT 1,
        MAJOR STUDENT.MAJOR%TYPE,
        AVR STUDENT.AVR%TYPE  
    );
    
    STUDENTREC STU_REC;
BEGIN
    STUDENTREC.SNO := '11011'; 
    STUDENTREC.SNAME := '문동주';
    STUDENTREC.SEX := '여';
    STUDENTREC.MAJOR := '생물';
    STUDENTREC.AVR := 3.7;
    STUDENTREC.SYEAR := 3;
        
    --데이터 수정
    UPDATE STUDENT_RECORD
        SET
            ROW = STUDENTREC --1. 한 행의 데이터 통째로 변경(ROW 이용) 편하다!
--            MAJOR = STUDENTREC.MAJOR, --2. 일부만 변경. 불편하다.
--            AVR = STUDENTREC.AVR,
--            SYEAR = STUDENTREC.SYEAR
        WHERE SNO = '11011';
END;
/

SELECT *
    FROM STUDENT_RECORD
    WHERE SNO = '11011';



--레코드 안에 레코드 변수 선언
DECLARE
    TYPE SCORE_REC IS RECORD(
        CNO SCORE.CNO%TYPE,
        SNO SCORE.SNO%TYPE,
        RESULT SCORE.RESULT%TYPE
    );
    
    TYPE STU_REC IS RECORD(
        SNO VARCHAR2(8) NOT NULL := '11012',
        SNAME STUDENT.SNAME%TYPE,
        SEX STUDENT.SEX%TYPE,
        SYEAR NUMBER(1, 0) DEFAULT 1,
        MAJOR STUDENT.MAJOR%TYPE,
        AVR STUDENT.AVR%TYPE,
        SCOREREC SCORE_REC --STU_REC 내부에서 SCORE_REC 레코드 변수로 선언함
    );
    
    STUDENTREC STU_REC;
    
BEGIN
    SELECT ST.SNO
         , ST.SNAME
         , ST.SEX
         , ST.SYEAR
         , ST.MAJOR
         , ST.AVR
         , SC.CNO
         , SC.SNO
         , SC.RESULT
        INTO STUDENTREC.SNO --담아줄 때는 INTO를 활용합니다.
           , STUDENTREC.SNAME
           , STUDENTREC.SEX
           , STUDENTREC.SYEAR
           , STUDENTREC.MAJOR
           , STUDENTREC.AVR
           , STUDENTREC.SCOREREC.CNO --객체 안의 객체 안에 있는 변수값(양파)
           , STUDENTREC.SCOREREC.SNO
           , STUDENTREC.SCOREREC.RESULT
        FROM STUDENT ST
        JOIN SCORE SC
        ON ST.SNO = SC.SNO
        WHERE ST.SNO = '915601'
            AND SC.CNO = '2368';
        
        DBMS_OUTPUT.PUT_LINE(STUDENTREC.SNO);  
        DBMS_OUTPUT.PUT_LINE(STUDENTREC.SNAME);
        DBMS_OUTPUT.PUT_LINE(STUDENTREC.SYEAR);
        DBMS_OUTPUT.PUT_LINE(STUDENTREC.MAJOR);
        DBMS_OUTPUT.PUT_LINE(STUDENTREC.AVR);
        DBMS_OUTPUT.PUT_LINE(STUDENTREC.SCOREREC.RESULT);
END;
/
        
--1-7. 연관배열
--동일한 데이터 타입의 데이터들을 모아놓은 자료형
DECLARE
    TYPE NUMBER_ARRAY IS TABLE OF NUMBER --괄호 X
    INDEX BY PLS_INTEGER; --인덱스는 정수형태로 가져온다.
    
    NUM NUMBER:=0;
    
    NUMARR NUMBER_ARRAY; -- 배열변수이름 배열명;
BEGIN
    LOOP
        NUM := NUM + 1;
        NUMARR(NUM) := NUM;
        EXIT WHEN NUM > 5;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(NUMARR(1));
    DBMS_OUTPUT.PUT_LINE(NUMARR(2));
    DBMS_OUTPUT.PUT_LINE(NUMARR(3));
    DBMS_OUTPUT.PUT_LINE(NUMARR(4));
    DBMS_OUTPUT.PUT_LINE(NUMARR(5));   
END; --12345 LOOP와 배열을 조합한 것을 확인할 수 있다.
/
 
--레코드와 배열을 조합하여 레코드타입의 배열 생성(자바의 객체배열과 비슷)
--위에서 만든 STUDENTREC    
DECLARE
    TYPE STU_REC IS RECORD( --변수명 아무거나 가능.
        --사용할 다양한 데이터타입의 변수들 선언
        SNO VARCHAR2(5) NOT NULL := '11012',
        SNAME STUDENT.SNAME%TYPE,
        SEX STUDENT.SEX%TYPE,
        SYEAR NUMBER(1) DEFAULT 1,
        MAJOR STUDENT.MAJOR%TYPE,
        AVR STUDENT.AVR%TYPE  
    );
    
    --레코드 타입의 배열 선언
    TYPE STUDENT_ARRAY IS TABLE OF STU_REC
    INDEX BY PLS_INTEGER;
    
    STUARR STUDENT_ARRAY;
    
    IDX NUMBER := 1; --인덱스 선언
    
BEGIN
    LOOP
        STUARR(IDX).SNO := 10000 + IDX;
        STUARR(IDX).SNAME := 'A'; --이건 동일하게 넣기
        STUARR(IDX).SYEAR := MOD(IDX, 4) + 1; --1234 나온다.
        STUARR(IDX).MAJOR := '컴공';
        
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SNO);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SNAME);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).SYEAR);
        DBMS_OUTPUT.PUT_LINE(STUARR(IDX).MAJOR);
    
        IDX := IDX + 1;
        EXIT WHEN IDX > 10;
    END LOOP;
END;
/


--레코드 연관배열 입력
DECLARE
    TYPE STU_REC IS RECORD( --변수명 아무거나 가능.
        --사용할 다양한 데이터타입의 변수들 선언
        SNO VARCHAR2(5) NOT NULL := '11012',
        SNAME STUDENT.SNAME%TYPE,
        SEX STUDENT.SEX%TYPE,
        SYEAR NUMBER(1) DEFAULT 1,
        MAJOR STUDENT.MAJOR%TYPE,
        AVR STUDENT.AVR%TYPE  
    );
    
    --레코드 타입의 배열 선언
    TYPE STUDENT_ARRAY IS TABLE OF STU_REC
    INDEX BY PLS_INTEGER;
    
    STUARR STUDENT_ARRAY;
    
    IDX NUMBER := 1; --인덱스 선언
    
BEGIN
    LOOP
        STUARR(IDX).SNO := 10000 + IDX;
        STUARR(IDX).SNAME := 'A'; --이건 동일하게 넣기
        STUARR(IDX).SYEAR := MOD(IDX, 4) + 1; --1234 나온다.
        STUARR(IDX).MAJOR := '컴공';
        
        
        INSERT INTO STUDENT_RECORD
        VALUES STUARR(IDX);
        
        IDX := IDX + 1;
        EXIT WHEN IDX > 10;
    END LOOP;
END;
/



--지정한 값만 들어가고 나머지 값(성별, 학점)은 NULL로 잡힙니다!
SELECT *
    FROM STUDENT_RECORD
    WHERE SNO LIKE '1000%';



--ROWTYPE을 이용해서 연관배열 생성
DECLARE
    TYPE STU_ARRAY IS TABLE OF STUDENT%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    IDX NUMBER := 1;
    
    STUARR STU_ARRAY;

BEGIN
    LOOP
        STUARR(IDX).SNO := 20000 + IDX;
        STUARR(IDX).SNAME := 'B' || IDX;
        STUARR(IDX).MAJOR := '소프트웨어';
        STUARR(IDX).SYEAR := MOD(IDX, 4) + 1; --IDX가 0이면 1234인데 1로 지정해서, 2학년부터 나올 수 밖에 없음.
        
        INSERT INTO STUDENT_RECORD
        VALUES STUARR(IDX); --하나씩 꺼내서 입력하도록 함.
        
        IDX := IDX + 1;
        EXIT WHEN IDX > 10;
    END LOOP;   
END;
/


SELECT *
    FROM STUDENT_RECORD
    WHERE SNO LIKE '2000%';





--연관배열의 메소드
DECLARE
    TYPE STU_ARRAY IS TABLE OF STUDENT%ROWTYPE
    INDEX BY PLS_INTEGER;
    STUARR STU_ARRAY;

BEGIN
    STUARR(1).SNO := 20000 + 1;
    STUARR(1).SNAME := 'B' || 1;
    STUARR(1).MAJOR := '소프트웨어';
    STUARR(1).SYEAR := 1;
    
    STUARR(2).SNO := 20000 + 2;
    STUARR(2).SNAME := 'B' || 2;
    STUARR(2).MAJOR := '소프트웨어';
    STUARR(2).SYEAR := 2;
    
    STUARR(3).SNO := 20000 + 3;
    STUARR(3).SNAME := 'B' || 3;
    STUARR(3).MAJOR := '소프트웨어';
    STUARR(3).SYEAR := 3;
    
    STUARR(10).SNO := 20000 + 10;
    STUARR(10).SNAME := 'B' || 10;
    STUARR(10).MAJOR := '소프트웨어';
    STUARR(10).SYEAR := 4;
    
    
    
    --EXISTS 함수는 TRUE/FAULSE를 리턴하기 때문에 출력하는 매개변수로 사용불가
    --IF나 CASE 조건절에 사용한다.
--    DBMS_OUTPUT.PUT_LINE(STUARR.EXISTS(4)); --4번 존재?
    DBMS_OUTPUT.PUT_LINE(STUARR.COUNT);
    DBMS_OUTPUT.PUT_LINE(STUARR.LIMIT);
    DBMS_OUTPUT.PUT_LINE(STUARR.FIRST);
    DBMS_OUTPUT.PUT_LINE(STUARR.LAST);
    DBMS_OUTPUT.PUT_LINE(STUARR.PRIOR(10)); --10번 앞에 SNO 반환
    DBMS_OUTPUT.PUT_LINE(STUARR.NEXT(1));
    
    
    STUARR.DELETE(3);--DELETE는 출력되진 않음.
--    DBMS_OUTPUT.PUT_LINE(STUARR.EXISTS(3)); --출력 문제 발생
    IF STUARR.EXISTS(3) THEN --EXITSTS는 조건식으로만 사용이 가능해보인다. 차후 추가하기.
        DBMS_OUTPUT.PUT_LINE('3번 INDEX 있음');
    ELSE
        DBMS_OUTPUT.PUT_LINE('3번 INDEX 없음');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(STUARR.COUNT);

END;
/




--3. 명시적 커서의 선언
--    - CURSOR 커서명 IS 쿼리문;
--    - 선언부(DECLARE)에서 작성
--
--4. 커서의 사용 방법
--    - 실행부(BEGIN)에서 사용
--    - OPEN 커서명;
--    - FETCH 커서명 INTO 변수; --커서로부터 읽어온 데이터를 사용
--    - CLOSE 커서명; --END가 아님에 유의한다.

--1-8. 커서
--한 행만 조회하는 커서
--쿼리의 결과를 저장하고 있는 커서
DECLARE
    --커서 선언
    CURSOR CURST IS 
        --쿼리문
        SELECT SNO
             , SNAME
             , MAJOR
             , SYEAR
            FROM STUDENT
            WHERE SNO='915301'; --한 행만 가져와야하기 때문이다. 여러행은? LOOP문 사용
            
    --담아줄 변수 선언 
        --(여기서는 레코드로 선언!)
    TYPE STREC IS RECORD(
        SNO VARCHAR2(8),
        SNAME VARCHAR2(20),
        MAJOR VARCHAR2(20),
        SYEAR NUMBER(1, 0)
    );
    
    STUREC STREC; --STUREC 이렇게 변수를 하나 만들어줘야 합니다!!
    
BEGIN
    OPEN CURST;
    
    FETCH CURST INTO STUREC; --레코드에 담기
    
    DBMS_OUTPUT.PUT_LINE(STUREC.SNO);
    DBMS_OUTPUT.PUT_LINE(STUREC.SNAME);
    DBMS_OUTPUT.PUT_LINE(STUREC.MAJOR);
    DBMS_OUTPUT.PUT_LINE(STUREC.SYEAR);
    
    CLOSE CURST;
END;
/


--여러개의 행을 담고 있는 커서의 처리 방식1
    --기본 LOOP, FOR LOOP 버전 두가지 
DECLARE
    CURSOR CURST IS
        SELECT SNO
             , SNAME
             , SEX
             , SYEAR
             , MAJOR
             , AVR
            FROM STUDENT
            WHERE SYEAR = 1;
    --변수 선언 STROW       
    STROW STUDENT%ROWTYPE;
BEGIN
    OPEN CURST; --CURST의 여러개의 데이터처리
    
    LOOP
        FETCH CURST INTO STROW; --FETCH는 한 행씩 가져오는 역할이다.
        
        DBMS_OUTPUT.PUT_LINE(STROW.SNO);
        DBMS_OUTPUT.PUT_LINE(STROW.SNAME);
        DBMS_OUTPUT.PUT_LINE(STROW.SYEAR);
        DBMS_OUTPUT.PUT_LINE(STROW.MAJOR);
        -- 커서명%ROWCOUNT : 현재까지 추출된 행의 개수를 리턴.
        DBMS_OUTPUT.PUT_LINE(CURST%ROWCOUNT);
        
        EXIT WHEN CURST%NOTFOUND; --다음 데이터(CURST) 없으면 끝나도록 합니다. NOTFOUND 정리 필요.
    END LOOP;
    
        CLOSE CURST; --JAVA의 SC.CLOSE같이 오픈된 상태로 계속 남아있어서 반드시 끝내야함.
END;
/

--여러행을 담고있는 CURSR의
            
DECLARE
    --커서 선언
    CURSOR CURST IS 
        --쿼리문
        SELECT SNO
             , SNAME
             , MAJOR
             , SYEAR
            FROM STUDENT
            WHERE SNO='915301'; --한 행만 가져와야하기 때문이다. 여러행은? LOOP문 사용
            
    --담아줄 변수 선언 
        --(여기서는 레코드로 선언!)
    TYPE STREC IS RECORD(
        SNO VARCHAR2(8),
        SNAME VARCHAR2(20),
        MAJOR VARCHAR2(20),
        SYEAR NUMBER(1, 0)
    );
    
    STUREC STREC; --STUREC 이렇게 변수를 하나 만들어줘야 합니다!!
    
BEGIN
    OPEN CURST;
    
    FETCH CURST INTO STUREC; --레코드에 담기
    
    DBMS_OUTPUT.PUT_LINE(STUREC.SNO);
    DBMS_OUTPUT.PUT_LINE(STUREC.SNAME);
    DBMS_OUTPUT.PUT_LINE(STUREC.MAJOR);
    DBMS_OUTPUT.PUT_LINE(STUREC.SYEAR);
    
    CLOSE CURST;
END;
/


--여러개의 행을 담고 있는 커서의 처리 방식1
    --기본 LOOP, FOR LOOP 버전 두가지 
DECLARE
    CURSOR CURST IS
        SELECT SNO
             , SNAME
             , SEX
             , SYEAR
             , MAJOR
             , AVR
            FROM STUDENT
            WHERE SYEAR = 1;
    --변수 선언 STROW       
    STROW STUDENT%ROWTYPE;
BEGIN    
    --자동 OPEN, FETCH, CLOSE 실행
        -- FOR 루프 사용하면 좋다.
    FOR STROW IN CURST LOOP
        DBMS_OUTPUT.PUT_LINE(STROW.SNO);
        DBMS_OUTPUT.PUT_LINE(STROW.SNAME);
        DBMS_OUTPUT.PUT_LINE(STROW.SYEAR);
        DBMS_OUTPUT.PUT_LINE(STROW.MAJOR);
        -- 커서명%ROWCOUNT : 현재까지 추출된 행의 개수를 리턴.
        DBMS_OUTPUT.PUT_LINE(CURST%ROWCOUNT);
    END LOOP;
    
END;
/


--커서의 파라미터
--고정된 쿼리 결과가 아닌 유동적인 쿼리의 결과를 커서에 담아준다.
DECLARE
    CURSOR CURST(PARAM_SYEAR NUMBER) IS
        SELECT SNO
             , SNAME
             , MAJOR
             , SYEAR
             FROM STUDENT
             WHERE SYEAR = PARAM_SYEAR;
             
        TYPE STREC IS RECORD( --다 가져와야함. 레코드 사용
            SNO STUDENT.SNO%TYPE,
            SNAME STUDENT.SNAME%TYPE,
            MAJOR STUDENT.MAJOR%TYPE,
            SYEAR STUDENT.SYEAR%TYPE
        
        
        );
        
        STROW STREC;
BEGIN
    OPEN CURST(2);
    LOOP
        FETCH CURST INTO STROW;
        
        EXIT WHEN CURST%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('--------------2학년----------------');
        DBMS_OUTPUT.PUT_LINE(STROW.SNO);
        DBMS_OUTPUT.PUT_LINE(STROW.SNAME);
        DBMS_OUTPUT.PUT_LINE(STROW.SYEAR);
        DBMS_OUTPUT.PUT_LINE(STROW.MAJOR);
    END LOOP;
    
    CLOSE CURST;
END;
/
        
        
        
--묵시적 커서
--실행된 쿼리문의 결과를 담고있는 커서
--따로 커서를 선언하지 않는다.
BEGIN
    UPDATE STUDENT
        SET
            SYEAR = 0
        WHERE SYEAR = 1; --1학년을 0으로!    
        
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
END;
/

SELECT *
    FROM STUDENT
    WHERE SYEAR = 0;
    


--1-9. 예외처리
--EXCEPTION으로 예외처리부를 작성한다.
DECLARE 
    VAL_SNO NUMBER;
BEGIN
    SELECT SNAME INTO VAL_SNO
        FROM STUDENT
        WHERE SNO = '915301'; --하나만 호출, 숫자는 자동 형변환..
        
    DBMS_OUTPUT.PUT_LINE('예외발생시 실행안됨');    
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('수치가 부적합');
        ROLLBACK; --대부분 롤백처리함.
END;
/


--EXCEPTION으로 예외처리부를 작성한다.
--UPDATE시 에러발생 처리 ROLLBACK
DECLARE
    VAL_SNO VARCHAR2(10);
BEGIN
    VAL_SNO := 'A';
    
    UPDATE STUDENT
        SET
            SYEAR = VAL_SNO --숫자에 문자 들어가니 예외처리 발생.
        WHERE SNO = '915301';
     
    DBMS_OUTPUT.PUT_LINE('예외발생시 실행안됨');    
EXCEPTION
    WHEN INVALID_NUMBER THEN --이경우 INVALID_NUMBER 써야함.
        DBMS_OUTPUT.PUT_LINE('수치가 부적합');
        ROLLBACK; --대부분 롤백처리함.
        DBMS_OUTPUT.PUT_LINE('롤백완료');
    
END;       
/



DECLARE
    VAL_SNO VARCHAR2(10);
BEGIN
    VAL_SNO := 'A';
    
    UPDATE STUDENT
        SET
            SYEAR = VAL_SNO --숫자에 문자 들어가니 예외처리 발생.
        WHERE SNO = '915301';
     
    DBMS_OUTPUT.PUT_LINE('예외발생시 실행안됨');    
EXCEPTION
    WHEN VALUE_ERROR THEN 
        DBMS_OUTPUT.PUT_LINE('값이 부적합');
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('롤백완료');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('행이 너무 많음');
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('롤백완료');
    WHEN OTHERS THEN --이경우 INVALID_NUMBER 써야함. 이걸 OTHERS에서 처리함.
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE('수치가 부적합');
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('롤백완료');
    
END;       
/


