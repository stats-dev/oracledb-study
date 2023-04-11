--1. 테이블 구조 확인 명령(DESC)
DESC STUDENT;


--2. 데이터를 조회하는 기본 Select 구문
SELECT SNO --comma는 앞에 찍어야 확인이 편해요.
      , SNAME
      FROM STUDENT; --여러 컬럼중 두개만 골라서 가져왔다고 생각해도 된다.
      
-- * : 테이블의 모든 컬럼을 조회
SELECT *
    FROM STUDENT;
    
--3. 조회하는 컬럼과 테이블에 별칭 붙이기
--3-1. 컬럼에 별칭붙이기(거의 영어로 별칭을 붙인다.)
SELECT substr(SNO, 0, 3) AS STUDENT_NO
    , SNAME AS 학생이름
    FROM STUDENT;

--예시 WITH SUBQUERY
--SELECT A.학생번호
--FROM
--(
--SELECT SNO AS 학생번호
--    , SNAME AS 학생이름
--    FROM STUDENT
--) A,
--SCORE B

--3-2. 테이블에 별칭 붙이기
--테이블에 대한 별칭은 해당 쿼리(SQL안에서
--테이블을 별칭으로 사용하겠다는 뜻이다.
--두 개이상 테이블을 사용해서 조회할 때 
--중복된 컬럼이 존재하면 어떤 테이블에서 컬럼을
--조회할지 결정해야하는데 그럴 때 주로 테이블에
--별칭을 붙여서 애매한 컬럼을 조회할 테이블을 지정할 수 있다.

SELECT ST.SNO --SNO는 STUDENT, SCORE에 둘다 있어서 애매한 정의라고 에러가 나오기도한다!
    , ST.SNAME
    , ST.SYEAR
    FROM STUDENT ST
    WHERE ST.SNAME LIKE '%우%'; --우자가 들어간 학생 이름만 뽑는다.
    
--SELECT SNO
--    , SNAME
--    , SYEAR
--    FROM STUDENT,
--         SCORE
--    WHERE SNAME LIKE '%우%'; --우자가 들어간 학생 이름만 뽑는다.
    
    
    
    