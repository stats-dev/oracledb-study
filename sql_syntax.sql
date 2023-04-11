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
--��Ī�� ������� ���� ���� ���̺��.�÷����� ������ ���� �ִ�. (�ٵ� �ʹ� �� ��Ī ����.)

SELECT ST.SNO --SNO�� STUDENT, SCORE�� �Ѵ� �־ �ָ��� ���Ƕ�� ������ �����⵵�Ѵ�!
    , ST.SNAME
    , ST.SYEAR
    FROM STUDENT ST,
         SCORE SC
    WHERE ST.SNAME LIKE '%��%'; --���ڰ� �� �л� �̸��� �̴´�.
    
--SELECT SNO
--    , SNAME
--    , SYEAR
--    FROM STUDENT,
--         SCORE
--    WHERE SNAME LIKE '%��%'; --���ڰ� �� �л� �̸��� �̴´�.
    
--SELECT SCORE.SNO 
--    , SCORE.SNAME
--    , SCORE.SYEAR
--    FROM STUDENT SCORE
--    WHERE SCORE.SNAME LIKE '%��%'; 
    
    
    
--4. NULL�� ó�����ִ� NVL
--4-1. NVL�� ������� �ʾ��� ���
SELECT ENO
    , ENAME
    , SAL
    , COMM
    FROM EMP;

--4-2. NVL ���
--NVL: NULL�� 0���� ǥ���Ѵ�.
--�ڹٿ� �������� �� NULL���� �ڹٷ� �״�� �Ѿ��
--NullPointerException�� �߻��� Ȯ���� �������� ������
--null���� ���� Ȯ���� �ִ� �÷����� �׻� NVLó���� ���ش�.
SELECT ENO
    , ENAME
    , SAL
    , NVL(COMM, 0) AS COMM
    FROM EMP;


--5. ���Ῥ����(||)
--����� �޿��� ������.
--5-1. ����̸� �޿� �����ؼ� ���
SELECT ENO
    ,  ENAME || '-' || SAL AS EMAMESAL
    FROM EMP;

--�л���ȣ�� - �⸻��� ����(SCORE)
SELECT SNO 
      , RESULT
      , SNO || '-' || RESULT AS SNO_RESULT
    FROM SCORE;
    
--�л���ȣ : �л��̸� �����ؼ� ���(STUDENT)
SELECT SNO
    , SNAME
    , SNO || '-' || SNAME AS SNO_SNAME
    FROM STUDENT;