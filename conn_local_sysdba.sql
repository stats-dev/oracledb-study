--1. 사용자 권한 삭제
REVOKE DBA FROM C##STUDY;
GRANT DBA TO C##STUDY;


--2. 사용자 및 권한 확인 //
SELECT * FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'C##STUDY';

--3. 사용자 생성
CREATE USER C##KHH IDENTIFIED BY "pass"; -- C##을 붙여줘야 싫ㅇ이 됩니다.

--4. CREATE SESSION : DB 접속 시 해당 사용자가 DB에 대한 접속세션을 만들 수 있는 권한
-- CONNECT 권한을 줘서 DB 접속 세션을 만들 수 있도록 한다.
GRANT connect TO C##KHH;


--5. 사용자 권한 확인
SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'C##KHH';
 
 
--4. CONNECT가 어떠한 권한을 가지고 ㅣㅇㅆ는지 확인
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'C##KHH';

--5. 사용자 삭제 명령어
DROP USER C##KHH;
 