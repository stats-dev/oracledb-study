--1. 사용자 권한 삭제해보기
REVOKE DBA FROM C##USERNAME;
GRANT DBA TO C##USERNAME;


--2. 사용자 및 권한 확인 //
SELECT * FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'C##USERNAME';

--3. 사용자 생성
CREATE USER C##USERNAME IDENTIFIED BY "password"; -- C##을 붙여줘야 실행이 됩니다.

--4. CREATE SESSION : DB 접속 시 해당 사용자가 DB에 대한 접속세션을 만들 수 있는 권한
-- CONNECT 권한을 줘서 DB 접속 세션을 만들 수 있도록 한다.
GRANT connect TO C##USERNAME;


--5. 사용자 권한 확인
SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'C##USERNAME';
 
 
--4. CONNECT가 어떠한 권한을 가지고 있는지 확인
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'C##USERNAME';

--5. 사용자 삭제 명령어
DROP USER C##USERNAME;
 