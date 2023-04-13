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

    
    