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
--별칭을 사용하지 않을 때는 테이블명.컬럼으로 지정할 수도 있다. (근데 너무 길어서 별칭 쓴다.)

SELECT ST.SNO --SNO는 STUDENT, SCORE에 둘다 있어서 애매한 정의라고 에러가 나오기도한다!
    , ST.SNAME
    , ST.SYEAR
    FROM STUDENT ST,
         SCORE SC
    WHERE ST.SNAME LIKE '%우%'; --우자가 들어간 학생 이름만 뽑는다.
    
--SELECT SNO
--    , SNAME
--    , SYEAR
--    FROM STUDENT,
--         SCORE
--    WHERE SNAME LIKE '%우%'; --우자가 들어간 학생 이름만 뽑는다.
    
--SELECT SCORE.SNO 
--    , SCORE.SNAME
--    , SCORE.SYEAR
--    FROM STUDENT SCORE
--    WHERE SCORE.SNAME LIKE '%우%'; 
    
    
    
--4. NULL을 처리해주는 NVL
--4-1. NVL을 사용하지 않았을 경우
SELECT ENO
    , ENAME
    , SAL
    , COMM
    FROM EMP;

--4-2. NVL 사용
--NVL: NULL을 0으로 표기한다.
--자바와 연동했을 때 NULL값이 자바로 그대로 넘어가면
--NullPointerException이 발생할 확률이 높아지기 때문에
--null값이 나올 확률이 있는 컬럼에는 항상 NVL처리를 해준다.
SELECT ENO
    , ENAME
    , SAL
    , NVL(COMM, 0) AS COMM
    FROM EMP;


--5. 연결연산자(||)
--사람과 급여를 연결함.
--5-1. 사원이름 급여 연결해서 출력
SELECT ENO
    ,  ENAME || '-' || SAL AS EMAMESAL
    FROM EMP;

--학생번호랑 - 기말고사 성적(SCORE)
SELECT SNO 
      , RESULT
      , SNO || '-' || RESULT AS SNO_RESULT
    FROM SCORE;
    
--학생번호 : 학생이름 연결해서 출력(STUDENT)
SELECT SNO
    , SNAME
    , SNO || '-' || SNAME AS SNO_SNAME
    FROM STUDENT;