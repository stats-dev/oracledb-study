--1. DML
--1-1. INSERT INTO
--사수, 보너스, 부서 미정인 신입사원을 추가한다고 하자.
--일부 컬럼만 데이터를 저장
INSERT INTO EMP(ENO, ENAME, JOB, HDATE, SAL)
VALUES(3006, '홍길동', '개발', SYSDATE, 300);
COMMIT;

--모든 컬럼의 데이터를 저장
INSERT INTO EMP --모든 데이터 저장시 컬럼 생략 가능하다.
VALUES('3007', '임꺽정', '설계', '2008', SYSDATE, 3000, 200, '30'); --NUM, VARCHAR2는 자동 변환이 됩니다. 다만, DATE는 변환이 안된다.
COMMIT;


--COMMIT, ROLLBACK
--COMMIT은 작업의 완료
--ROLLBACK은 작업의 취소, COMMIT되기 전의 변경사항을 모두 취소.
INSERT INTO EMP --모든 데이터 저장시 컬럼 생략 가능하다.
VALUES('3008', '장길산1', '분석', '2008', SYSDATE, 3000, 100, '20'); --NUM, VARCHAR2는 자동 변환이 됩니다. 다만, DATE는 변환이 안된다.
INSERT INTO EMP --모든 데이터 저장시 컬럼 생략 가능하다.
VALUES('3008', '장길산2', '분석', '2008', SYSDATE, 3000, 100, '20'); --NUM, VARCHAR2는 자동 변환이 됩니다. 다만, DATE는 변환이 안된다.
INSERT INTO EMP --모든 데이터 저장시 컬럼 생략 가능하다.
VALUES('3008', '장길산3', '분석', '2008', SYSDATE, 3000, 100, '20'); --NUM, VARCHAR2는 자동 변환이 됩니다. 다만, DATE는 변환이 안된다.
INSERT INTO EMP --모든 데이터 저장시 컬럼 생략 가능하다.
VALUES('3008', '장길산4', '분석', '2008', SYSDATE, 3000, 100, '20'); --NUM, VARCHAR2는 자동 변환이 됩니다. 다만, DATE는 변환이 안된다.
ROLLBACK; --커밋되지 않은, 전에 있는 모든 정보, 작업을 취소한다.

--확인
SELECT *
    FROM EMP;
    
--1-2. INSERT INTO 다량의 데이터 한 번에 저장
CREATE TABLE EMP_COPY(
    ENO VARCHAR2(4),
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    MGR VARCHAR2(4),
    HDATE DATE,
    SAL NUMBER(5),
    COMM NUMBER(5),
    DNO VARCHAR2(2)
);


--EMP 테이블에서 DNO이 30인 데이터들만 가져와서 저장
INSERT INTO EMP_COPY --모든 데이터, 컬럼 생략, 컬럼 달라야 한다.
SELECT * 
    FROM EMP 
    WHERE DNO = '30';
COMMIT;



SELECT *
    FROM EMP_COPY;


--COURSE_PROFESS 테이블 생성
--PNAME까지 저장되게 한다.
CREATE TABLE COURSE_PROFESS(
    CNO VARCHAR2(8),
    CNAME VARCHAR2(20),
    ST_NUM NUMBER(1, 0),
    PNO VARCHAR2(8),
    PNAME VARCHAR2(20)
);

SELECT *
    FROM COURSE_PROFESS;

--COURSE, PROFESSOR 조인해서, PNAME까지 저장
INSERT INTO COURSE_PROFESS 
SELECT C.*
     , P.PNAME
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO;

COMMIT;


CREATE TABLE COURSE_PRFESS(
    CNO VARCHAR2(8),
    CNAME VARCHAR2(20),
    ST_NUM NUMBER(1, 0),
    PNO VARCHAR2(8),
    PNAME VARCHAR2(20)
);

INSERT INTO COURSE_PRFESS
SELECT C.CNO
     , C.CNAME
     , C.ST_NUM
     , PNO
     , P.PNAME
    FROM COURSE C
    NATURAL JOIN PROFESSOR P;

COMMIT;

SELECT *
    FROM COURSE_PRFESS;

    
--데이터를 삭제하는 DELETE FROM
DELETE FROM COURSE_PRFESS; --이러면 모두 삭제됨. WHERE로 조절

SELECT *
    FROM COURSE_PRFESS;

--교수가 NULL인것도 넣는 것. OUTER JOIN;
INSERT INTO COURSE_PRFESS
SELECT C.CNO
     , C.CNAME
     , C.ST_NUM
     , C.PNO
     , P.PNAME
    FROM COURSE C
    LEFT JOIN PROFESSOR P
    ON C.PNO = P.PNO;

COMMIT;
SELECT *
    FROM COURSE_PRFESS;
    
--1-3. UPDATE SET
--전체 데이터 수정
UPDATE EMP_COPY
    SET 
        MGR = '0001'; --모든 사수번호를 이걸로 변경.

ROLLBACK; --취소
        
SELECT *
    FROM EMP_COPY;
    
--사원번호 3005번 1800으로 수정
UPDATE EMP_COPY
    SET 
        COMM = 1800
    WHERE ENO = '3005';
    

--사원번호 3005번 1800으로 수정(연산사용)
--누가 접근하면 되는 듯 하다.
UPDATE EMP_COPY
    SET 
        COMM = COMM * 3 --현재COMM에 3배를 한 값이 다시 보너스로 잡힌다.
    WHERE ENO = '3005';

--PROFESSOR 테이블의 HIREDATE를 + 20년해서 업데이트
UPDATE PROFESSOR
SET
    HIREDATE = ADD_MONTHS(HIREDATE, 20 * 12);
    
--ROLLBACK;    
SELECT * FROM PROFESSOR;

    