--WHERE ������ ��뤱
--1) ȭ�а� �л��� �˻��϶�
SELECT *
    FROM STUDENT
    WHERE MAJOR = 'ȭ��';

--2) ������ 2.0 �̸��� �л��� �˻��϶�
SELECT SNAME, AVR
    FROM STUDENT
    WHERE AVR < 2.0;

--3) ���� �л��� ������ �˻��϶�
SELECT SNAME, AVR
    FROM STUDENT
    WHERE SNAME = '����';

--4) ������ ����� �˻��϶�
SELECT PNAME, ORDERS
    FROM PROFESSOR
    WHERE ORDERS = '������';

--5) ȭ�а� �Ҽ� ������ ����� �˻��϶�
SELECT PNAME, SECTION
    FROM PROFESSOR
    WHERE SECTION = 'ȭ��';

--6) �۰� ������ ������ �˻��϶�
SELECT *
    FROM PROFESSOR
    WHERE PNAME = '�۰�';

--7) �г⺰�� ȭ�а� �л��� ������ �˻��϶�
SELECT *
    FROM STUDENT
    WHERE MAJOR = 'ȭ��'
    ORDER BY SYEAR;
    

--8) 2000�� ������ ������ ������ ������ �����ϼ����� �˻��϶�
SELECT PNAME
    , HIREDATE
    FROM PROFESSOR
    WHERE EXTRACT(YEAR FROM HIREDATE) <= 2000
    ORDER BY HIREDATE;

--9) ��� ������ ���� ������ ������ �˻��϶�
SELECT *
    FROM COURSE
    WHERE PNO IS NULL;

