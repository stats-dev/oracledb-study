--UPDATE STUDENT
--    SET SNAME = REPLACE(SNAME, ' ', '');
--    
--COMMIT; --이거 하거나 F11사용
----잘못 눌렀으면 커밋하지말고 F12(롤백)을 사용하면 됩니다.
----이것이 트랜젝션이 일어나고 종결시키는 커밋(F11)과 롤백(F12)입니다!!
--


--1-6. 변환 함수
--숫자를 문자로 변환 TO_CHAR
SELECT TO_CHAR(100000000, '999,999,999') --9자리까지 숫자를 표기하되, 3자리마다 ,를 표출.
    FROM DUAL;
-- 100,000,000

SELECT TO_CHAR(1000000, '099,999,999')  --9자리까지 숫자를 표기하되, 3자리마다 ,를 표출하고
    FROM DUAL;                          --앞 자리에 0을 붙여서 출력.
-- 001,000,000


SELECT TO_CHAR(1000000000, '999,999,999,999,999') --15자리 이상 숫자 들어오기 쉽지 않음. 그 이내에서 거의 모든 숫자가 3자리마다 ,표출 가능.
    FROM DUAL;
    

--문자를 숫자로 변환 TO_NUMBER
--형식지정자의 자리수만 잘 지정해서 사용하거나 형식지정자를 지정하지 않고 사용한다.
SELECT TO_NUMBER('-123.456', '999.999') -- 문자열 길이보다 형식지정자는 자리수를 같거나 더 많게 지정해줘야한다.
    FROM DUAL; --숫자형식으로 바꿔서 출력함.
    
SELECT TO_NUMBER('-123.456', '999.99') --에러: 지정한 문자보다 형식지정자가 더 짧음.
    FROM DUAL; --숫자형식으로 바꿔서 출력함.

SELECT TO_NUMBER('-123.456', '999.99999') --지정한 문자보다는 길게한다.
    FROM DUAL; 

SELECT TO_NUMBER('-123', '999.99999')
    FROM DUAL;
    
SELECT TO_NUMBER('1234') --형식지정자 없이도 사용 가능
    FROM DUAL;
    
--날짜를 문자로 변환하는 TO_CHAR
--TO_CHAR의 날짜 형식 지정 
         --형식 지정자는 대소문자 상관 없음.
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD')
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
     --12시간 짜리로 나온다. -> AM, PM 선택필요.
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') 
     --요일까지 출력
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY')
     , TO_CHAR(SYSDATE, '"오늘은 "YYYY"년 "MM"월 "DD"일 "DAY"입니다."') -- 형식지정자 안에서 문자열을 추가할 때 ""사용 (큰따옴표)
     , TO_CHAR(SYSDATE, 'YYYY"년 " MONTH DD"일"') -- MONTH 사용하면 4월 (한글로) 보여준다. 따로 월을 안붙여도 됨.
--     , TO_CHAR(SYSDATE, 'YYYY"년"') --현재 앞자리
--     , TO_CHAR(SYSDATE, 'RRRR"년"') --가까운 연도
    FROM DUAL;


--문자를 날짜로 변환하는 TO_DATE
--날짜 출력 형식인 NLS_DATE_FORMAT 기준으로 출력(최우선)
SELECT TO_DATE('20211201113512', 'YYYY/MM/DD HH24:MI:SS')
     , TO_DATE('202304141059', 'YYYYMMDD HH24MI')
     , TO_DATE('20230411', 'YYYY-MM-DD')
    FROM DUAL;


--TO_DATE 함수로 입사일이 19920201보다 빠른 사원목록 조회
SELECT ENO
     , ENAME
     , HDATE
     , TO_DATE('19920201', 'YYYYMMDD')
    FROM EMP
    WHERE HDATE < TO_DATE('19920201', 'YYYYMMDD');
    

SELECT *
    FROM EMP
    WHERE HDATE < TO_DATE('19920201', 'YYYYMMDD');


ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-MM-dd HH24:mi:ss';    
--송강교수의 임용일자를 XXXX년 XX월 XX일 XX요일입니다. 조회(TO_CHAR)
SELECT PNAME
     , HIREDATE
     , TO_CHAR(HIREDATE, '"송강교수의 임용일자는 "YYYY"년 "MM"월 "DD"일 "DAY"입니다."')
     FROM PROFESSOR
     WHERE PNAME = '송강';
     
     
SELECT PNO
     , PNAME
     , TO_CHAR(HIREDATE, 'YYYY"년 "MM"월 "DD"일 "DAY"입니다."') AS HIREDATE
     FROM PROFESSOR
     WHERE PNAME = '송강';
     

--1-7. Null값 처리를 해주는 NVL
SELECT ENO
     , ENAME
     , NVL(COMM, -1) AS COMM
    FROM EMP;
    
    
SELECT CNO
     , CNAME
     , NVL(PNO, 0)
    FROM COURSE;
--    WHERE PNO IS NULL;

--위 쿼리에서 PROFESSOR와 OUTER JOIN해서 PNAME이 NULL인 값들은 '교수 배정안됨'
SELECT C.CNO
     , C.CNAME
     , NVL(C.PNO, 0) --C.NVL 이런거 안됨.
--     , P.PNAME
     , NVL(P.PNAME, '교수 배정안됨')
    FROM COURSE C
    LEFT JOIN PROFESSOR P
    ON C.PNO = P.PNO;
    
    
SELECT C.CNO
     , C.CNAME
     , NVL(C.PNO, 0)
     , NVL(P.PNAME, '교수 배정안됨')
    FROM COURSE C
    LEFT JOIN PROFESSOR P
    ON C.PNO = P.PNO;
    
    
 --1-8. 조건 처리해주는 DECODE
 SELECT ENO
     , ENAME
     , JOB
     , SAL
     , DECODE(JOB,
                 '개발', SAL * 1.5, --업무가 개발인 사람들
                 '경영', SAL * 1.3, --업무가 개발이 아닌 사람들 중 업무가 경영인 사람들
                 '지원', SAL * 1.1, --업무가 개발, 경영이 아닌 사람들 중 업무가 ERP인 사람들
                 '분석', SAL,       --업무가 개발, 경영, ERP가 아닌 사람들 중 업무가 분석인 사람들
                        SAL * 0.95 --업무가 개발, 경영, ERP, 분석이 아닌 사람들
                ) AS CHANGE_SAL
    FROM EMP;            
    
    
--1-9. 조건 처리해주는 CASE~WHEN
 SELECT ENO
     , ENAME
     , JOB
     , SAL
     , CASE JOB
            WHEN '개발' THEN SAL * 1.5 --업무가 개발인 사람들
            WHEN '경영' THEN SAL * 1.3 --업무가 개발이 아닌 사람들 중 업무가 경영인 사람들
            WHEN '지원' THEN SAL * 1.1 --업무가 개발, 경영이 아닌 사람들 중 업무가 ERP인 사람들
            WHEN '분석' THEN SAL       --업무가 개발, 경영, ERP가 아닌 사람들 중 업무가 분석인 사람들
            ELSE SAL * 0.95 --업무가 개발, 경영, ERP, 분석이 아닌 사람들
                END AS CHANGE_SAL
    FROM EMP;            

--CASE~WHEN은 COMMA가 없다.
SELECT ENO
     , ENAME
     , JOB
     , SAL
     , CASE JOB
        WHEN '개발' THEN SAL * 1.5 --업무가 개발인 사람들
        WHEN '경영' THEN SAL * 1.3 --업무가 개발이 아닌 사람들 중 업무가 경영인 사람들
        WHEN '지원' THEN SAL * 1.1 --업무가 개발, 경영이 아닌 사람들 중 업무가 ERP인 사람들
        WHEN '분석' THEN SAL       --업무가 개발, 경영, ERP가 아닌 사람들 중 업무가 분석인 사람들
        ELSE SAL * 0.95           --업무가 개발, 경영, ERP, 분석이 아닌 사람들
       END AS CHANGE_SAL --END로 CASE문의 종결을 알림, 별칭을 붙여줌
    FROM EMP;            


    
--COMM이 NULL인 사람은 '해당사항 없음', COMM이 0인 사람은 '보너스 없음', 나머지 사람들은 '보너스 : " || COMM
--COMM_TXT, ENO, ENAME, COMM 조회
--재밌게도 여기서는 CASE 뒤에 컬럼명 안넣고 바로 WHEN에서 컬럼이랑 다 처리함.
--CASE ~ WHEN
SELECT ENO
     , ENAME
     , COMM
     , CASE 
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '보너스 없음'
        ELSE '보너스 : ' || COMM
      END AS COMM_TXT
    FROM EMP;
    
SELECT ENO
     , ENAME
     , COMM
     , CASE NVL(COMM, -1)
        WHEN -1 THEN '해당사항 없음'
        WHEN 0 THEN '보너스 없음'
        ELSE '보너스 : ' || COMM
      END AS COMM_TXT
    FROM EMP;


--DECODE
SELECT ENO
     , ENAME
     , COMM
    , DECODE(COMM,
        null, '해당사항 없음',
        0, '보너스 없음',
        '보너스 : ' || COMM
        ) AS COMM_TXT
    FROM EMP;

SELECT ENO
     , ENAME
     , COMM
    , DECODE(NVL(COMM, -1),
        -1, '해당사항 없음',
        0, '보너스 없음',
        '보너스 : ' || COMM
        ) AS COMM_TXT
    FROM EMP;
    

