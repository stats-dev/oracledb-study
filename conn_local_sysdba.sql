--1. ����� ���� ����
REVOKE DBA FROM C##STUDY;
GRANT DBA TO C##STUDY;


--2. ����� �� ���� Ȯ�� //
SELECT * FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'C##STUDY';

--3. ����� ����
CREATE USER C##KHH IDENTIFIED BY "pass"; -- C##�� �ٿ���� �Ȥ��� �˴ϴ�.

--4. CREATE SESSION : DB ���� �� �ش� ����ڰ� DB�� ���� ���Ӽ����� ���� �� �ִ� ����
-- CONNECT ������ �༭ DB ���� ������ ���� �� �ֵ��� �Ѵ�.
GRANT connect TO C##KHH;


--5. ����� ���� Ȯ��
SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'C##KHH';
 
 
--4. CONNECT�� ��� ������ ������ �Ӥ������� Ȯ��
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'C##KHH';

--5. ����� ���� ��ɾ�
DROP USER C##KHH;
 