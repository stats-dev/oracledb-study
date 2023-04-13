--기말고사의 성적을 조회할 건데 과목이름, 담당교수 이름, 학생이름, 점수등급 함께 조회 과목번호 순서로 정렬
SELECT SC.SNO
     , ST.SNAME
     , SC.CNO
     , PCS.CNAME
     , SC.RESULT
     , SG.GRADE
     , PCS.PNO
     , PCS.PNAME
    FROM SCORE SC
    JOIN SCGRADE SG
    ON SC.RESULT BETWEEN SG.LOSCORE AND SG.HISCORE
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    RIGHT JOIN (
        SELECT CS.*
             , P.PNAME
            FROM COURSE CS
            LEFT JOIN PROFESSOR P
            ON CS.PNO = P.PNO
    ) PCS
    ON SC.CNO = PCS.CNO
    
    ORDER BY SNO, CNO;
    
    
--    COURSE, PROFESSOR OUTER JOIN으로 담당교수 없는 과목 조회
--    SCORE, STUDENT 조인된 서브쿼리 하나 더 만들어서 두 개에 대한 JOIN 다시 한다.? (SCORE, SCGRADE STUDENT 묶은 거 하나)
--    COURSE PRFESSOR 묶어서 OUTER JOIN으로 묶는 것?
--    
-- SCORE, SCGRADE, STUDENT => 하나의 서브쿼리
-- COURSE, PROFESSOR => 하나의 서브쿼리로(담당교수가 없는 과목도 조회)

-- 위 서브쿼리 테이블 2개를 다시 조인해서 결과
--기말고사의 성적을 조회할 건데 담당교수가 없는 과목도 나올 수 있도록
--과목이름, 담당교수 이름, 학생이름, 점수등급 함께 조회 과목번호 순서로 정렬
    --총 행이 3200개 행이 된다.

SELECT A.CNAME
    , A.PNAME
    , B.SNAME
    , B.RESULT
    , B.GRADE
    FROM (
            SELECT C.CNO
            , C.CNAME
            , P.PNO
            , P.PNAME
            FROM COURSE C
            LEFT JOIN PROFESSOR P
            ON C.PNO = P.PNO
    ) A
    LEFT JOIN (
            SELECT SC.SNO
            , SC.CNO
            , SC.RESULT
            , ST.SNAME
            , SG.GRADE
            FROM SCORE SC
            JOIN STUDENT ST
            ON SC.SNO = ST.SNO
            JOIN SCGRADE SG
            ON SC.RESULT BETWEEN SG.LOSCORE AND SG.HISCORE
    ) B
    ON A.CNO = B.CNO
    ORDER BY B.CNO;


--SCORE, SCGRADE, STUDENT => 하나의 서브쿼리
SELECT SC.SNO
    , ST.SNAME
    , SC.CNO
    , SC.RESULT
    , SG.GRADE
    FROM SCORE SC
    JOIN STUDENT ST
    ON SC.SNO = ST.SNO
    JOIN SCGRADE SG
    ON SC.RESULT BETWEEN SG.LOSCORE AND SG.HISCORE;

--COURSE, PROFESSOR -> 하나이ㅡ 서브쿼리로(담당교수가 없는 과목도 조회)
SELECT C.CNO
    , C.CNAME
    , C.PNO
    , P.PNAME
    FROM COURSE C
    JOIN PROFESSOR P
    ON C.PNO = P.PNO;
    


 --기말고사의 성적을 조회할 건데 담당교수가 없는 과목도 나올 수 있도록
--과목이름, 담당교수 이름, 학생이름, 점수등급 함께 조회 과목번호 순서로 정렬
    --총 행이 3200개 행이 된다.
    
SELECT A.SNO
    , A.SNAME
    , B.CNO --과목번호가 A에서 가져오면, B에 있는게 안나오므로 B에서 가져옴.
    , B.CNAME
    , B.PNO
    , B.PNAME
    , A.RESULT
    , A.GRADE
    FROM (
            SELECT SC.SNO
            , ST.SNAME
            , SC.CNO
            , SC.RESULT
            , SG.GRADE
            FROM SCORE SC
            JOIN STUDENT ST
            ON SC.SNO = ST.SNO
            JOIN SCGRADE SG
            ON SC.RESULT BETWEEN SG.LOSCORE AND SG.HISCORE
        ) A
        RIGHT JOIN ( --B에 정보가 더 많으니까 RIGHT OUTER JOIN 해주면 좋다.
                SELECT C.CNO
                , C.CNAME
                , C.PNO
                , P.PNAME
                FROM COURSE C
                LEFT JOIN PROFESSOR P
                ON C.PNO = P.PNO
    
        ) B
        --조인 조건을 걸어줘야 이상한 값이 안나온다.
        ON A.CNO = B.CNO
        ORDER BY B.CNO;

