--1. 단일 함수
--1-1. 문자 함수
--LOWER, UPPER, INITCAP
SELECT DNO
     , LOWER(DNAME)
     , UPPER(DNAME)
     , INITCAP(DNAME)
    FROM DEPT;
    
SELECT *
    FROM DEPT;
    
    
--부서명이 erp인 정보를 조회
--부서명의 대, 소문자를 모를 때
SELECT DNO
     , DNAME
    FROM DEPT
    WHERE LOWER(DNAME) = 'erp'; --이렇게 다 소문자로 바구고 비교하면 끝난다.
    
SELECT *
    FROM DEPT
    WHERE LOWER(DNAME) = 'erp'; --이렇게 다 소문자로 바구고 비교하면 끝난다.

    

--1-2. 문자 연산 함수
--CONCAT
--그러나 ANSI 표준은 CONCAT 써야함.
SELECT CONCAT(DNO, ' : ' || DNAME || ' : ' || LOC)
    FROM DEPT;

    
SELECT DNO || ' : ' || DNAME || ' : ' || LOC
    FROM DEPT;
    

--SUBSTR
--SUBSTR(n, cnt)은 n 번째 글자부터(1부터) cnt개를 가져온다.
SELECT SUBSTR(ORDERS, 1, 1)
    FROM PROFESSOR;
    
SELECT *
    FROM PROFESSOR
    WHERE SUBSTR(ORDERS, 1, 1) = '정';
    
    
    
SELECT ENAME
     , SUBSTR(ENAME, 2) -- 두 번째 글자부터 모두 출력
     , SUBSTR(ENAME, -2) -- 뒤에서 두 번째 글자부터 모두
     , SUBSTR(ENAME, 1, 2) -- 첫 번째 글자부터 두 글자
     , SUBSTR(ENAME, -2, 2) --뒤에서 두 번째 글자부터 두 글자
    FROM EMP;



--LENGTH, LENGTHB
SELECT DNAME
     , LENGTH(DNAME)
     , LENGTHB(DNAME) --BYTE길이 한글은 3byte, 영어는 1byte 반환확인!
    FROM DEPT;
    
    
    
--현재 오라클이 사용중인 문자셋 AL32UTF8 => 이게 한글 3byte 씩 계산하고 있습니다!
--한글 3byte로 잘 나오고 있습니다.
SELECT *
    FROM NLS_DATABASE_PARAMETERS
    WHERE PARAMETER = 'NLS_CHARACTERSET'
        OR PARAMETER = 'NLS_NCHAR_CHARACTERSET';
        

--INSTR
--DUAL 테이블 : 오라클에서 제공해주는 가상의 기본 테이블
--             간단하게 날짜나 연산 또는 결과값을 보기 위해 사용
--             원래 DUAL 테이블 소유자는 SYS로 되어있는데 모든 USER에서 접근 가능
--             INSTR(대상문자, 찾으려는 문자, 기준이되는 글자 다음의 위치)
SELECT INSTR('DATABASE', 'A') -- 첫 번째 A의 위치
     , INSTR('DATABASE', 'A', 3) -- 세 번째 글자인 T 다음의 첫 번째 A의 위치
     , INSTR('DATABASE', 'A', 1, 3) -- 첫 번째 글자 D 다음의 세 번째 A의 위치
     , SYSDATE
     , 1 + 2
     FROM DUAL; --간단한 결과 먼저 출력
    

--TRIM
--TRIM(문자열) : 공백이 제거된 새로운 문자열 반환
SELECT TRIM('조' FROM '조병조')             --both 생략, 앞뒤의 조를 제거
     , TRIM(leading '조' FROM '조병조')     --앞에 있는 조 제거
     , TRIM(trailing '조' FROM '조병조')    --뒤에 있는 조 제거
     , TRIM(' 조 병 조 ')                   --공백 제거(앞뒤로 있는 공백만 제거) (글자 사이/안의 공백은 제거가 안된다!
    FROM DUAL;
     

-- LPAD, RPAD : CHARSET 한글을 3byte로 잡아도 컴퓨터에서는 2byte로 사용하기 대문에 한글연산 자체는 2byte로 진행된다.
--빈공간에 *을 넣는다.
SELECT LPAD(ENAME, 10, '*')  -- 사원명 앞(lead)에 *을 붙여서 총길이가 10으로 만듦.
     , RPAD(ENAME, 10, '*')  -- 사원명 뒤(rear)에 *을 붙여서 총길이를 10으로 만듦.
    FROM EMP;

