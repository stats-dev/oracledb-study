--<단일 행 함수를 이용하세요>
--1) 교수들이 부임한 달에 근무한 일수는 몇 일인지 검색하세요
SELECT PNO
     , PNAME
     , SECTION
     , ORDERS
     , HIREDATE
     , LAST_DAY(HIREDATE) - HIREDATE
    FROM PROFESSOR;

--TRUNC 쓰는게 좀 더 정확하다고 한다.
SELECT PNO
     , PNAME
     , TRUNC(LAST_DAY(HIREDATE)) - TRUNC(HIREDATE)
     FROM PROFESSOR;

SELECT PNO
     , PNAME
     , LAST_DAY(HIREDATE) - HIREDATE
     FROM PROFESSOR;



--2) 교수들의 오늘까지 근무한 주가 몇 주인지 검색하세요
SELECT PNO
     , PNAME
     , SECTION
     , ORDERS
     , HIREDATE
--     , FLOOR(MONTHS_BETWEEN(TRUNC(SYSDATE,'dd'), TRUNC(HIREDATE,'dd'))) * 4
     , TRUNC((SYSDATE - HIREDATE) / 7) + 1 -- 1을 더할 필요가 없다.
    FROM PROFESSOR;
    
SELECT PNO
     , PNAME
     , TRUNC((SYSDATE - HIREDATE) / 7) --그냥 7로 나누면 끝나는 게임.
    FROM PROFESSOR;

--3) 1991년에서 1995년 사이에 부임한 교수를 검색하세요
SELECT PNO
     , PNAME
     , SECTION
     , ORDERS
     , HIREDATE
    FROM PROFESSOR
    WHERE HIREDATE BETWEEN TO_DATE('19910101 00:00:00') AND TO_DATE('19941231 23:59:59');




SELECT PNO
     , PNAME
     , HIREDATE
    FROM PROFESSOR
    WHERE TRUNC(HIREDATE, 'YYYY') --연도만 남기고 시작하는게 아주 정확함!!
        BETWEEN TO_DATE('1991', 'YYYY') AND TO_DATE('1995', 'YYYY');


--4) 학생들의 4.5 환산 평점을 검색하세요(단 소수 이하 둘째자리까지)
SELECT SNO
     , SNAME
     , SEX
     , SYEAR
     , MAJOR
     , AVR
     , ROUND((AVR / 4) * 4.5, 2) AS 환산평점
    FROM STUDENT;


SELECT SNO
     , SNAME
     , ROUND(AVR * 4.5 / 4.0, 2)
    FROM STUDENT;
    

--**5) 사원들의 오늘까지 근무 기간이 몇 년 몇 개월 며칠인지 검색하세요
SELECT ENO
     , ENAME
     , JOB
     , MGR
     , HDATE
--     , TRUNC((SYSDATE - HDATE) / 365) AS HYEARS
--     , TRUNC(MOD((SYSDATE - HDATE), 365) / 12) AS HMONTHS
--     , TRUNC(MOD(MOD((SYSDATE - HDATE), 365), 12)) AS HDAYS
     , TRUNC((SYSDATE - HDATE) / 365) || '년 ' 
     || TRUNC(MOD((SYSDATE - HDATE), 365) / 12) || '개월 '
     || TRUNC(MOD(MOD((SYSDATE - HDATE), 365), 12)) || '일'  AS 근무기간
    FROM EMP;
    
    
--강사님
SELECT ENO
     , ENAME
     , TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) / 12) || '년'
    || MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE)), 12) || '개월'
    || TRUNC(SYSDATE - ADD_MONTHS(HDATE, MONTHS_BETWEEN(SYSDATE, HDATE))) || '일' --개월 수 뺀 날짜만큼 일수로 보여주면 됨!!
    FROM EMP;
    

--은희님
SELECT ENAME
    , HDATE
    , TRUNC (MONTHS_BETWEEN (SYSDATE, HDATE)/12) "년"
    , TRUNC (MOD(MONTHS_BETWEEN (SYSDATE, HDATE),12)) "개월"
    , TRUNC(SYSDATE - ADD_MONTHS(HDATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE)/12) * 12 
        + TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, HDATE), 12)))) "일"
    FROM EMP; 
    
