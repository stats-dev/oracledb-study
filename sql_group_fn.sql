--1. 그룹함수
--1-1. MAX
--전체 학생 중 최대 평점
--모든 데이터에서 조회하는건 그룹화 필요 없음.
SELECT MAX(AVR) --따로 그룹화할 필요 없음.
    FROM STUDENT;
    
--전공별 최대 평점
SELECT MAX(AVR)
     , MAJOR
    FROM STUDENT
    GROUP BY MAJOR;
    
--전공별로 학년별로 최대 평점
SELECT MAX(AVR)
     , MAJOR
     , SYEAR
--     , SNO 불가능! SNO는 겹치는 값이 없다.
--     , SNAME
    FROM STUDENT
    GROUP BY MAJOR, SYEAR; --COMMA로 연결해서, 전공별 학년별로 묶는다.
    

--SNO를 굳이 만든다면? 서브쿼리로 묶어서 각자 가져와서 쓰도록 해야 한다. JOIN을 활용한다.
SELECT ST.SNO
     , ST.SNAME
     , MAXAVR.AVR
     , MAXAVR.MAJOR
     , MAXAVR.SYEAR
     FROM STUDENT ST
     JOIN
        (
        SELECT MAX(AVR)AS AVR
      , MAJOR
      , SYEAR
        FROM STUDENT
        GROUP BY MAJOR, SYEAR --COMMA로 연결해서, 전공별 학년별로 묶는다.
        HAVING MAJOR = '화학' --GROUP BY에서 조건절 역할
--        AND SYEAR = 1
        AND MAX(AVR) > 2.5 --저 위에 별칭은 밖에서만 쓸 수 있다. 같은 쿼리에서는 별칭 사용이 안된다!!!
        ) MAXAVR
    ON ST.AVR = MAXAVR.AVR
    AND ST.MAJOR = MAXAVR.MAJOR
    AND ST.SYEAR = MAXAVR.SYEAR; --3개가 다 같아야 함.
    
    
    
    
-- 기말고사 성적(SCORE) 중 과목별 가장 높은 점수 조회
SELECT CNO
     , MAX(RESULT)
     , MIN(RESULT)
    FROM SCORE
    GROUP BY CNO;


SELECT C.CNO
     , C.CNAME
     , MAX(S.RESULT)
    FROM SCORE S
    JOIN COURSE C
    ON S.CNO = C.CNO
    GROUP BY C.CNAME, C.CNO;
    
--GROUP BY 컬럼의 이름이 동일한 친구를 묶어서 그룹화한다!!
    
--해설 : 기말고사 성적 중 과목별 가장 높은 점수 조회
--CNO 데이터가 같은 값들을 그룹으로 묶어서 그 그룹중에 최대값을 꺼내온다.
SELECT CNO
     , MAX(RESULT)
    FROM SCORE
    GROUP BY CNO;
    
--해설 : 기말고사 성적 중 과목별 가장 높은 점수 조회 + 과목명
SELECT SC.CNO
     , C.CNAME
     , SC.MAXRESULT
    FROM COURSE C
    JOIN (
            SELECT CNO
          , MAX(RESULT) AS MAXRESULT
            FROM SCORE
            GROUP BY CNO
        ) SC
    ON C.CNO = SC.CNO;
    
-- SNO, SNAME 가져오기(SNO만 가져옴)
SELECT SC.CNO
     , C.CNAME
     , SC.SNO
     , SC.MAXRESULT
    FROM COURSE C
    JOIN (
            SELECT CNO
                 , SNO
                 , MAX(RESULT) AS MAXRESULT
            FROM SCORE
            GROUP BY CNO,SNO
        ) SC
    ON C.CNO = SC.CNO;

--과목별 기말고사 성적의 최대값(과목명, 학생이름)

SELECT SC.SNO --과목별 최고점수 학생 번호가 나온다.
     , ST.SNAME
     , MXRS.CNO
     , C.CNAME
     , MXRS.MAXRESULT
     FROM SCORE SC
     JOIN (
     --과목별 최대 점수 값인 테이블을 만든다.
            SELECT CNO
            , MAX(RESULT) AS MAXRESULT
            FROM SCORE
            GROUP BY CNO
    ) MXRS
    ON SC.CNO = MXRS.CNO
    AND SC.RESULT = MXRS.MAXRESULT
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    JOIN COURSE C --과목 매칭시켜서 MAX인 학생의 번호부터 가져오게 설정해야 합니다.
    ON C.CNO = SC.CNO --동점자를 고려해서 32개 과목 중 50개 과목이 나옴.
    ORDER BY SC.CNO; --과목별로 빠르게 정렬함.


--과목 개수
SELECT DISTINCT CNO
    FROM SCORE;













