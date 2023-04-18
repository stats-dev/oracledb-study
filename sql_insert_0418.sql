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

--alter session set nls_date_format='YYYY/MM/DD HH24:MI:SS';

--PROFESSOR 테이블의 HIREDATE를 + 20년해서 업데이트
UPDATE PROFESSOR
SET
    HIREDATE = ADD_MONTHS(HIREDATE, 20 * 12);

COMMIT; --이걸 하면 작업이 완료되어 롤백이 안된다.
    
--ROLLBACK;    
SELECT * FROM PROFESSOR;

    
--EMP_COPY의 데이터 삭제
DELETE FROM EMP_COPY;

--EMP의 전체 데이터를 EMP_COPY에 저장
INSERT INTO EMP_COPY
SELECT * FROM EMP;
COMMIT;

SELECT * FROM EMP_COPY;
--20, 30번 부서 사원들을 60부서로 통합, 보너스가 현재 보너스의 * 1.5
UPDATE EMP_COPY
    SET 
        DNO = '60',
        COMM = COMM * 1.5
    WHERE DNO IN ('20', '30');   

COMMIT;


--DEPT_COPY 테이블 생성
CREATE TABLE DEPT_COPY --AS SELECT FROM을 기억하자!
    AS SELECT * FROM DEPT; --이러면 그대로 카피해서 타입 지정 및 데이터를 입력해줍니다.
 
 
SELECT *
    FROM DEPT_COPY;
    
    
--서브쿼리를 이용한 데이터 수정
UPDATE DEPT_COPY
    SET
        (DNO, DNAME, LOC) = (
                        SELECT DNO
                             , DNAME
                             , LOC --추가할 때는 그 순서를 맞춰줘야 한다.
                            FROM DEPT
                            WHERE DNO = '50'
                        )
     WHERE DNO IN ('20', '30');                   


--40번 부서의 DIRECTOR를 EMP테이블의 급여가 제일 높은 사원으로 업데이트
UPDATE DEPT_COPY
    SET
        (DIRECTOR) = (
                                    SELECT ENO
                                        FROM EMP
                                        WHERE SAL = (
                                                        SELECT MAX(SAL)
                                                            FROM EMP
                                                    )
         )
       WHERE DNO = '40';

SELECT *
    FROM DEPT_COPY;


UPDATE DEPT_COPY
    SET
        DIRECTOR = (
                        SELECT ENO
                            FROM EMP
                            WHERE SAL = (
                                            SELECT MAX(SAL)
                                                FROM EMP
                                            )
                    ) 
  WHERE DNO = '40';

COMMIT;

SELECT *
    FROM DEPT_COPY;
    
--1-4. DELETE FROM
--전체 데이터 삭제 => 조건절 생략
DELETE FROM EMP_COPY; --롤백

SELECT *
    FROM EMP_COPY;

--일부 데이터 삭제 => WHERE절로 조건 추가
DELETE FROM EMP_COPY
    WHERE JOB = '지원';
    
--WHERE 절에 서브쿼리를 사용하여 특정 데이터 삭제
--EMP_COPY에서 급여가 4000이상되는 사원 정보 삭제
DELETE FROM EMP_COPY
    WHERE ENO IN (
                    SELECT ENO
                        FROM EMP_COPY
                        WHERE SAL >= 4000
                    );


--STUDENT 테이블 참조하여 ST_COPY 테이블 생성
CREATE TABLE ST_COPY
    AS SELECT * FROM STUDENT;


--CREATE TABLE ST_COPY
--    AS SELECT * FROM STUDENT;

--SCORE 학생별 기말고사 성적 평균이 60점 이상인 학생정보 ST_COPY에서 삭제
DELETE FROM ST_COPY
    WHERE SNO IN (     
                    SELECT SNO
                        FROM SCORE
                        GROUP BY SNO
                        HAVING AVG(RESULT) >= 60
                    );
--COMMIT;

--사라진 것 확인.
SELECT *
    FROM ST_COPY
    WHERE SNO IN ('915301', '935602');



--1-5. LOCK
--수정후 트랜잭션 완료 안함.
UPDATE EMP_COPY
    SET ENAME = 'rrr'
    WHERE DNO = '60'; --60인 사원 이름을 다 바꾼다.


SELECT * FROM EMP_COPY;
--SQLPLUS에서는 그대로 유지되는 것을 확인.(COMMIT 해야 변경됨)


--점유 상태, 
--SQLPLUS에서,
--SQL> UPDATE EMP_COPY SET JOB = '개발' WHERE DNO = '60';

ROLLBACK;
--롤백, 커밋과 동시에 SQLPLUS에서도 업데이트가 된다.
--마찬가지로, SQLDEVELOPER에서도 SQLPLUS가 점유중(커밋, 롤백)이면 계속 대기상태로 있게 된다.
--대량의 데이터 처리할 때도 유사한 현상이 있는데, KILL SESSION을 쓸 수 있다.
SELECT * FROM EMP_COPY;


--SELECT, DEADLOCK 구문(데이터가 많을 경우)
--이렇게 쿼리를 짜면? 모든 테이블을 다 매핑해서 맞추게 된다. 데드락 걸릴 수 있음!
SELECT A.*
     , B.*
     , C.*
    FROM STUDENT A,
         SCORE B,
         PROFESSOR C;
         

