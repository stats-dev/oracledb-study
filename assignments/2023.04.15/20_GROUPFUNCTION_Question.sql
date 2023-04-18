--1) 각 학과별 학년별 학생 수를 ROLLUP함수로 검색하세요
--학년별도 추가해야한다!
SELECT MAJOR
     , COUNT(*)
     FROM STUDENT
     GROUP BY ROLLUP(MAJOR);


SELECT MAJOR
     , SYEAR
     , COUNT(*)
    FROM STUDENT
    GROUP BY ROLLUP(MAJOR, SYEAR)
    ORDER BY MAJOR, SYEAR;


--2) 화학과와 생물학과 학생 4.5 환산 평점의 평균을 각각 검색하는 데 화학과 생물이 열로 만들어지도록 하세요.(PIVOT 사용) (화학, 생물 열 만들기)
SELECT *
    FROM (
            SELECT MAJOR
                 , AVR
            FROM STUDENT
    )
    PIVOT(AVG(AVR * 4.5 / 4)
        FOR MAJOR IN (
                        '화학' AS 화학,
                        '생물' AS 생물
                        
                        )
);

SELECT *
    FROM (
        SELECT MAJOR
             , AVR
        FROM STUDENT
    )

    PIVOT(AVG(AVR * 4.5 / 4.0) --ROUND쓰려면 컬럼이 같아야하는데 두 컬럼이 달라서 못쓴다.
        FOR MAJOR IN (
                        '화학' AS 화학,
                        '물리' AS 물리
            )
);

--3) 학과별 학생이름을 ,로 구분하여 모두 나오는데, 성적순으로(내림차순) 조회하세요.(LISTAGG 사용) 
SELECT MAJOR
     , LISTAGG(SNAME, ', ')
       WITHIN GROUP(ORDER BY AVR DESC)
    FROM STUDENT
    GROUP BY MAJOR;



SELECT MAJOR
     , LISTAGG(SNAME, ', ')
      WITHIN GROUP(ORDER BY AVR DESC)
    FROM STUDENT
    GROUP BY MAJOR;

--4) 부서별 업무별 연봉의 평균을 검색하세요(부서와 업무 컬럼의 그룹화 여부도 같이 검색, GROUPING 사용)
SELECT DNO
     , JOB
     , AVG(SAL)
     , GROUPING(DNO)
     , GROUPING(JOB)
    FROM EMP
    GROUP BY ROLLUP(DNO, JOB)
    ORDER BY DNO, JOB;
    
--ROLLUP, CUBE를 사용해서 잘 채워야 한다.
SELECT DNO
     , JOB
     , ROUND(AVG(SAL), 2)
     , GROUPING(DNO)
     , GROUPING(JOB)
    FROM EMP
    GROUP BY ROLLUP(DNO, JOB)
    ORDER BY DNO, JOB;
