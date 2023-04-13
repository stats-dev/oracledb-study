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


--직원이름을 출력하는데 마지막 글자만 제거해서 출력(SUBSTR, LENGTH)
SELECT ENAME
     , SUBSTR(ENAME, 1, LENGTH(ENAME) - 1) --그니까 처음부터 자기이름 - 1개수만큼 출력하면 된다!
    FROM EMP;
    
SELECT SUBSTR(ENAME, 1, LENGTH(ENAME) - 1)
    FROM EMP;
    
    
--1-3. 문자열 치환 함수
--TRANSLATE, REPLACE
SELECT TRANSLATE('World of Warcraft', 'Wo', '--') --문자 단위로 동작하기 때문에 모든 W, o 치환
     , REPLACE('World of Warcraft', 'Wo', '--') --문자열 단위로 동작하기 때문에 Wo가 치환.
    FROM DUAL;
    
    --TRANSLATE         REPLACE
    --rld -f -arcraft	--rld of Warcraft


--1-4. 숫자 함수
--ROUND(지정한 자리수까지 반올림)
SELECT ROUND(123.454678, 3) --소수점 세자리수
    FROM DUAL; --없으면 DUAL!
    
--TRUNC(지정한 자리수 뒤의 숫자 버림)
SELECT TRUNC(123.454678, 3)
    FROM DUAL;
    
--MOD(나머지 값)
SELECT MOD(10, 4)
    FROM DUAL;
    
--POWER(몇 제곱값)
SELECT POWER(10, 3)
    FROM DUAL;
    
--CEIL, FLOOR(제일 가까운 정수 값)
SELECT CEIL(2.59)
     , FLOOR(2.59)
    FROM DUAL;
    
--ABS(절대값)
SELECT ABS(10)
     , ABS(-10)
    FROM DUAL;
    
--SQRT(제곱근 값)
SELECT SQRT(9)
     , SQRT(25)
     , SQRT(100)
    FROM DUAL;
    
--SIGN(부호판단) : 음수 -1, 양수 1, 0은 0 반환!  
SELECT SIGN(-123)
     , SIGN(52)
     , SIGN(0)
    FROM DUAL;


--1-4. 날짜 연산
SELECT SYSDATE
     , SYSDATE + 100 -- 100일 후의 날짜
     , SYSDATE - 100 -- 100일 이전의 날짜
     , SYSDATE + 3 / 24 -- 3시간 후의 날짜
     , SYSDATE - 5 / 24 -- 5시간 이전의 날짜
     , SYSDATE - TO_DATE('20220413', 'YYYY/MM/DD') -- 두 날짜간 차이 일수(시간, 분, 초때문에 정확히 나오지 않음)
     , TRUNC(SYSDATE) - TO_DATE('20220413', 'YYYY/MM/DD')
    FROM DUAL;
    
    
    
    --ALTER SESSION SET NLS_DATE_FORMAT = 'yyyyMMDD HH24:mi:ss'
    
--1-5. 날짜 함수
--ROUND
-- 두 개 이상x, 오직 하나의 단위별로만 가능.
--SELECT ROUND(SYSDATE, 'MM/DD') -- ORA-01898: 정밀도 지정자가 너무 많습니다
--    FROM DUAL;
    
SELECT ROUND(SYSDATE, 'mm')
    FROM DUAL;
    
SELECT ROUND(SYSDATE, '20230423...')
    FROM DUAL;
    
--TRUNC : 아무것도 지정안하면 날짜 중 시분초가 0으로 초기화된 상태..
SELECT TRUNC(SYSDATE)
    FROM DUAL;
    
SELECT TRUNC(SYSDATE, 'YYYY') -- 연도까지만 가져오고 다 초기화 시킨다.
    FROM DUAL;
    
--두가지 비교
SELECT ROUND(SYSDATE, 'dd') --20230414
    FROM DUAL;
    
SELECT TRUNC(SYSDATE, 'dd')  --20230413
    FROM DUAL;
    
    
--MONTHS_BETWEEN
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2023/02/13', 'yyyy/MM/dd'))
    FROM DUAL;
    
    
--ADD_MONTHS
SELECT ADD_MONTHS(SYSDATE, 3) -- 3개월 후 날짜 반환
    FROM DUAL;
    
--NEXT_DAY
SELECT NEXT_DAY(SYSDATE, '수요일')
    FROM DUAL; --제일 처음 다음으로 만나는 수요일

--LAST_DAY
SELECT LAST_DAY(TO_DATE('20210618', 'yyyyMMdd'))
    FROM DUAL; --2021년 6월의 마지막 날짜를 반환한다!!
    
    
    
--사원들의 입사일과 입사 100일후의 날짜와 10년뒤 날짜 조회
SELECT ENO
     , ENAME
     , HDATE AS 날짜
     , HDATE + 100 AS 입사100일후날짜
     , ADD_MONTHS(HDATE, 10*12) AS 입사10년뒤날짜
    FROM EMP;
    
SELECT HDATE
     , HDATE + 100
     , ADD_MONTHS(HDATE, 120)
    FROM EMP;
    
--학생이름에 공백을 추가해서 과제를 제공
UPDATE STUDENT
    SET SNAME = SNAME || ' ';
    
COMMIT; --데이터를 조작하면 반드시 커밋해줘야 됨. 혹은 커밋버튼 눌러야 함.
    
