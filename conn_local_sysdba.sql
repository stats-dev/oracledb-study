--1. ����� ���� ����
REVOKE DBA FROM C##USERNAME;
GRANT DBA TO C##USERNAME;


--2. ����� �� ���� Ȯ�� //
SELECT * FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'C##USERNAME';

--3. ����� ����
CREATE USER C##USERNAME IDENTIFIED BY "password"; -- C##�� �ٿ���� ������ �˴ϴ�.

--4. CREATE SESSION : DB ���� �� �ش� ����ڰ� DB�� ���� ���Ӽ����� ���� �� �ִ� ����
-- CONNECT ������ �༭ DB ���� ������ ���� �� �ֵ��� �Ѵ�.
GRANT connect TO C##USERNAME;


--5. ����� ���� Ȯ��
SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'C##USERNAME';
 
 
--4. CONNECT�� ��� ������ ������ �ִ��� Ȯ��
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'C##USERNAME';

--5. ����� ���� ��ɾ�
DROP USER C##USERNAME;
 