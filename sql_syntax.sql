--1. ���̺� ���� Ȯ�� ���(DESC)
DESC STUDENT;


--2. �����͸� ��ȸ�ϴ� �⺻ Select ����
SELECT SNO --comma�� �տ� ���� Ȯ���� ���ؿ�.
      , SNAME
      FROM STUDENT; --���� �÷��� �ΰ��� ��� �����Դٰ� �����ص� �ȴ�.
      
-- * : ���̺��� ��� �÷��� ��ȸ
SELECT *
    FROM STUDENT;
    
--3. ��ȸ�ϴ� �÷��� ���̺� ��Ī ���̱�
--3-1. �÷��� ��Ī���̱�(���� ����� ��Ī�� ���δ�.)
SELECT substr(SNO, 0, 3) AS STUDENT_NO
    , SNAME AS �л��̸�
    FROM STUDENT;

--���� WITH SUBQUERY
--SELECT A.�л���ȣ
--FROM
--(
--SELECT SNO AS �л���ȣ
--    , SNAME AS �л��̸�
--    FROM STUDENT
--) A,
--SCORE B

--3-2. ���̺� ��Ī ���̱�
--���̺� ���� ��Ī�� �ش� ����(SQL�ȿ���
--���̺��� ��Ī���� ����ϰڴٴ� ���̴�.
--�� ���̻� ���̺��� ����ؼ� ��ȸ�� �� 
--�ߺ��� �÷��� �����ϸ� � ���̺��� �÷���
--��ȸ���� �����ؾ��ϴµ� �׷� �� �ַ� ���̺�
--��Ī�� �ٿ��� �ָ��� �÷��� ��ȸ�� ���̺��� ������ �� �ִ�.

SELECT ST.SNO --SNO�� STUDENT, SCORE�� �Ѵ� �־ �ָ��� ���Ƕ�� ������ �����⵵�Ѵ�!
    , ST.SNAME
    , ST.SYEAR
    FROM STUDENT ST
    WHERE ST.SNAME LIKE '%��%'; --���ڰ� �� �л� �̸��� �̴´�.
    
--SELECT SNO
--    , SNAME
--    , SYEAR
--    FROM STUDENT,
--         SCORE
--    WHERE SNAME LIKE '%��%'; --���ڰ� �� �л� �̸��� �̴´�.
    
    
    
    