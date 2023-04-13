-- 2. 집합연산자
--2-1. 합집합 연산자
--2000년 이후에 임용된 교수와 2000년 이후에 입사한 직원의 목록조회
--COL 개수, 타입 맞추기
--공통적인 컬럼명을 사용할 수 있게 별칭을 넣어준다.
SELECT PNO AS 직원번호
     , PNAME AS 직원이름
     , HIREDATE AS 입사일시
     FROM PROFESSOR
     WHERE HIREDATE > TO_DATE('19991231 23:59:59', 'yyyyMMdd HH24:mi:ss')
UNION
SELECT ENO 
     , ENAME
     , HDATE
--     , JOB --이걸 넣는 순간 두 테이블에서 컬럼 수가 달라져서 에러 발생 : ORA-01789: 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.
     FROM EMP
     WHERE HDATE > TO_DATE('19991231 23:59:59', 'yyyyMMdd HH24:mi:ss');

--그냥 다 더해진다.


--2-2. 차집합 연산자
--성이 제갈이면서 지원업무를 하지 않은 사원의 사원번호, 사원이름, 업무 조회
SELECT ENO
     , ENAME
     , JOB
     FROM EMP
     WHERE ENAME LIKE '제갈%' --제갈로 시작한다. LIKE만 사용!
--     WHERE ENAME LIKE '제갈_'
MINUS --지원업무를 빼버린다.
SELECT ENO
     , ENAME
     , JOB
    FROM EMP
    WHERE JOB = '지원';
    
-- 이게 빠름.
--SELECT ENO
--     , ENAME
--     , JOB
--     FROM EMP
--     WHERE ENAME LIKE '제갈%'
--        AND JOB != '지원';


--과목중에서 담당교수가 배정이 안됐거나 담당교수의 정보가 존재하지 않는 과목번호, 과목명 조회
SELECT C.CNO
     , C.CNAME
     FROM COURSE C
     LEFT JOIN PROFESSOR P --코스에만 존재한다.
     ON C.PNO = P.PNO
MINUS
SELECT C.CNO
     , C.CNAME
     FROM COURSE C
     JOIN PROFESSOR P --코스에만 존재한다.
     ON C.PNO = P.PNO;

----빠르게 하는 법
--SELECT C.CNO
--     , C.CNAME
--     FROM COURSE C
--     LEFT JOIN PROFESSOR P
--     ON C.PNO = P.PNO
--     WHERE P.PNO IS NULL;

--화학과 교수 중에 일반화학 수업을 하지 않는 교수들만 조회
    --화학과 교수 & 일반화학 마이너스
    
SELECT P.PNO
     , P.PNAME
     , C.CNO
     , C.CNAME
    FROM PROFESSOR P
    JOIN COURSE C
    ON P.PNO = C.PNO
    WHERE SECTION = '화학'
MINUS
SELECT P.PNO
    , P.PNAME
    , C.CNO
    , C.CNAME
    FROM PROFESSOR P
    JOIN COURSE C
    ON P.PNO = C.PNO
    WHERE C.CNAME = '일반화학';
    

SELECT P.PNO
     , P.PNAME
     , C.CNO
     , C.CNAME
     FROM PROFESSOR P
     JOIN COURSE C
     ON P.PNO = C.PNO
        AND P.SECTION = '화학'
        AND C.CNAME != '일반화학';

SELECT P.PNO
     , P.PNAME
     , C.CNO
     , C.CNAME
    FROM PROFESSOR P
    JOIN COURSE C
    ON P.PNO = C.PNO
    WHERE SECTION = '화학'
    AND C.CNAME != '일반화학';
    
    
--2-3. 교집합 연산자 INTERSECT
--물리, 화학과 학생 중 학점이 3.0이상인 학생의 학번, 학생이름, 학과, 평점 조회
SELECT SNO
     , SNAME
     , MAJOR
     , AVR
    FROM STUDENT
    WHERE MAJOR IN ('물리', '화학')
--    AND AVR >= 3.0;
INTERSECT
SELECT SNO
     , SNAME
     , MAJOR
     , AVR
    FROM STUDENT
    WHERE AVR >= 3.0;


--훨씬 간단하다.
SELECT SNO
     , SNAME
     , MAJOR
     , AVR
    FROM STUDENT
    WHERE MAJOR IN ('물리', '화학')
        AND AVR >= 3.0; 
        
--현재 날짜와 시간을 보여주는 방법이다!
SELECT SYSDATE
    FROM DUAL;
        