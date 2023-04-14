--1) 학생의 평균 평점을 다음 형식에 따라 소수점 이하 2자리까지 검색하세요
--'OOO 학생의 평균 평점은 O.OO입니다.'
SELECT SNO
     , SNAME
     , AVR
     , CONCAT((SNAME || '학생의 평균 평점은 '), (ROUND(AVR, 2) || '입니다.'))
    FROM STUDENT;
    
    
SELECT SNAME || '학생의 평균 평점은 ' || ROUND(AVR, 2) || '입니다.'
    FROM STUDENT;

--2) 교수의 부임일을 다음 형식으로 표현하세요
--'OOO 교수의 부임일은 YYYY년 MM월 DD일입니다.'

SELECT PNO
     , PNAME
     , HIREDATE
     , CONCAT((PNAME || ' 교수의 부임일은 '), (TO_CHAR(HIREDATE, 'yyyy') || '년 ' || TO_CHAR(HIREDATE, 'MM') || '월 ' || TO_CHAR(HIREDATE, 'dd') || '일 입니다.'))
    FROM PROFESSOR;


    
SELECT PNAME || '교수의 부임일은 ' || TO_CHAR(HIREDATE, 'YYYY') || '년 ' || TO_CHAR(HIREDATE, 'MM') || '월 ' || TO_CHAR(HIREDATE, 'dd') || '일 입니다.' AS "교수의 부임일"
    FROM PROFESSOR;
     
     
     
--참고: '"  "YYYY" "MM" "DD"   "' => 큰따옴표 안에 또 날짜 형식을 넣고, 나머지는 CHAR로 인식된다.
SELECT PNAME || TO_CHAR(HIREDATE, '"교수의 부임일은 "YYYY"년 "MM"월 "DD"일입니다."')
    FROM PROFESSOR;


--3) 교수중에 3월에 부임한 교수의 명단을 검색하세요(연도 상관없이 3월 조회)
SELECT PNAME
     , HIREDATE
     , TRUNC(HIREDATE, 'MM')
     FROM PROFESSOR
     WHERE TO_CHAR(HIREDATE, 'MM') = 3;



SELECT PNO
     , PNAME
     , HIREDATE
    FROM PROFESSOR
    WHERE TO_CHAR(HIREDATE, 'MM') = '03';
     
     
     
     
     