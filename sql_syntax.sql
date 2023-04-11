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
      , SNO || ' - ' || RESULT AS SNO_RESULT
    FROM SCORE;
 
 SELECT SNO || ' - ' || RESULT AS  �й�����
    FROM SCORE;

 
    
--�л���ȣ : �л��̸� �����ؼ� ���(STUDENT)
SELECT SNO
    , SNAME
    , SNO || ' : ' || SNAME AS SNO_SNAME
    FROM STUDENT;
    
SELECT SNO || ' : ' || SNAME AS �й��̸�
    FROM STUDENT;
    
    
--6. �ߺ������� DISTINCT
--����JOB
SELECT JOB 
    FROM EMP;

--6-1. �÷� �ϳ��� ���� �ߺ� ����
SELECT DISTINCT JOB
    FROM EMP;
    
--6-2. �÷� �� ���̻� ���� �ߺ� ����
--���� �÷��� DISTINCT�� �ٿ��ִ°� �ƴϰ�
--�� ���� Ŀ���� �� ���� ������ ���� �ż�
--�� �� �÷��� �����Ͱ� ��� �ߺ����� ������
--�ߺ����� �ν����� �ʴ´�.
SELECT DISTINCT JOB
    , MGR
    FROM EMP;
    
-- *�� ����ϸ� ��� �÷����� �ߺ������ ��µȴ�.
SELECT DISTINCT *
    FROM EMP;
    
--7. �����͸� �������ִ� ORDER BY
--7-1. �� �� �÷��� ���� ����
--������������ ����, ASC ���� ����
SELECT *
    FROM STUDENT
    ORDER BY SYEAR ASC; --SYEAR �г� ������ ������ �� �˴ϴ�.
    
SELECT *
    FROM STUDENT
    ORDER BY SYEAR ASC; 
    
--������������ ����. DESC�� ���� �Ұ���.
SELECT *
    FROM STUDENT
    ORDER BY SYEAR DESC;
    
--7-2. �� ���� �÷��� �������� ����
--������������ ����, ASC ���� ����
--�ĸ��� ����ؼ� ���� ���ĵ� ��� �÷��� ����
--���� ������ �÷����� ������ �����ϰ�, 
--���� ���� �÷��� ���� ������ �����Ѵ�.
SELECT *
    FROM STUDENT
    ORDER BY SYEAR, SNAME ASC; --�г� > �̸� ������ �ٽ� �����ϰ� �˴ϴ�
    
SELECT *
    FROM STUDENT
    ORDER BY SYEAR, MAJOR, AVR ASC; --�г� > ���� ����(��) > �������� �ٽ� ����
    
--�� �÷��� ���� ���� ����� ���� ������ �� �ִ�.
SELECT *
    FROM STUDENT
    ORDER BY SYEAR DESC, MAJOR, AVR ASC; --�г� �������� > ���� ����(��) > ���� ������������ �ٽ� ����
    
-- �μ���(DNO)�� �����ϴµ� �޿�(SAL)�� ���� ��� ���� ��������(EMP)
-- ENO, ENAME, DNO, SAL
SELECT ENO
    , ENAME
    , DNO AS �μ���ȣ
    , SAL AS �޿�
    FROM EMP
    ORDER BY DNO, SAL DESC; -- (ASC) ���� ����
    

--��Ī�� ���� ��쿡�� ��Ī���� ���ĵ� ����
SELECT ENO
    , ENAME
    , DNO AS �μ���ȣ
    , SAL AS �޿�
    FROM EMP
    ORDER BY �μ���ȣ, �޿� DESC; -- (ASC) ���� ����
    
    
--8. ������ �ɾ��ִ� WHERE
--8-1. ���� ũ�� ��
--�޿��� 3000�̻��� ������� ��ȸ
SELECT *
    FROM EMP
    WHERE SAL >= 3000;

--������ ȭ�а��� �л��� ���
SELECT * 
    FROM STUDENT
    WHERE MAJOR = 'ȭ��';


    
--�������� ����� ���� �÷��� Ÿ������ ���� ���� �����Ѵ�.
--���� �÷��� Ÿ�԰� �ٸ� Ÿ������ ���� ���
--�÷��� ��� �����Ͱ� ���� Ÿ������ ����� ���� �񱳸� �ϰ� �ȴ�.
--�����Ͱ� ������ ��� ��� �����Ϳ��� �ѹ��� ����ȯ�� �Ͼ�� ������
--���� �ӵ��� �ſ� ���ϵȴ�.
SELECT *
    FROM EMP
    WHERE SAL >= 3000;
    
--���������� ���� �� �÷��� Ÿ���� ��ȯ�ϴ� ���� �־�� �ȵȴ�.
--���� ���� �÷��� Ÿ�԰� �����ּž� �Ѵ�.
--SELECT *
--    FROM table
--    WHERE TO_CHAR(DATE) = '���� ��'; -- �̷��� ���������͸� ��ȯ�ؼ��� �ȵȴ�! ���� ���� �����.
    

--COMM�� null ���� ��� ��ȸ
SELECT *
    FROM EMP
    WHERE COMM IS NULL;

--9. ���� ���� ����� AND, OR
--9-1. ��� ������ �����ϴ� �����͸� ��ȸ
--1�г��̸鼭 �̸��� '��'�� ������ �л� ��� ��ȸ
SELECT *
    FROM STUDENT
    WHERE  SYEAR = 1
        AND SNAME LIKE '%��';
        
--ȸ������� �ϸ鼭 �޿��� 3000�̻��̰� �̸��� ������ ���� ��� ��ȸ
SELECT *
    FROM EMP
    WHERE JOB = 'ȸ��'
        AND SAL >= 3000
        AND ENAME LIKE '___';
        
--�⸻��� ������ 75�̻��̰ų� �����ȣ�� 1211�� �л� ��� ��ȸ
SELECT *
    FROM SCORE
    WHERE RESULT >= 75
        OR CNO = '1211'; --VARCHAR2�� �Ǿ� ����. ���ڿ��� �ֱ�.

--AND, OR ȥ�ջ��.
--DNO�� 10�̰ų� �޿��� 1600�̻��� ������ ���ʽ��� 600�̻��� ���� ��ȸ
--() ��ȣ�� �̿��ؼ� �켱������ ���� �� �ִ�.
SELECT *
    FROM EMP
    WHERE (DNO = '30'
        OR SAL >= 2000) --�̷��� �켱���� ����
        AND COMM >= 600;

--������ 2.0�̻��̰ų� �̸��� 3���� �л��� ȭ�� ������ �л� ��� ���
SELECT *
    FROM STUDENT
    WHERE (AVR >= 2.0
        OR SNAME LIKE '___')
        AND MAJOR = 'ȭ��';

