--1. 추가적인 조인 방식
--1-1. NATURAL JOIN
--학생들의 평균 결과값을 추출할 수 있다.
--NATURAL JOIN에서는 테이블에 별칭을 달 수 없다.
SELECT SNO
     , SNAME
     , AVG(RESULT)
    FROM SCORE
    NATURAL JOIN STUDENT --알아서 SNO 조인?
    GROUP BY SNO, SNAME;
    