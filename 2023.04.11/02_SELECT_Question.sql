--1) �� �л��� ������ �˻��϶�(��Ī�� ���)
SELECT AVR AS �л�����
    FROM STUDENT;

--2) �� ������ �������� �˻��϶�(��Ī�� ���)
SELECT ST_NUM AS ������
    FROM COURSE;

--3) �� ������ ������ �˻��϶�(��Ī�� ���)
SELECT ORDERS AS ����
    FROM PROFESSOR;

--4) �޿��� 10%�λ����� �� ���� ���޵Ǵ� �޿��� �˻��϶�(��Ī�� ���)
SELECT SAL
    , SAL * 1.1 AS �λ�޿�
    FROM EMP;

--5) ���� �л��� ��� ������ 4.0�����̴�. �̸� 4.5�������� ȯ���ؼ� �˻��϶�(��Ī�� ���)
SELECT AVR
    , ROUND((AVR / 4) * 4.5, 2) AS "4.5����"
    FROM STUDENT;



