--���Ῥ����
--1) '__�а��� __�л��� ���� ������ __�Դϴ�' ���·� �л��� ������ ����϶�
SELECT MAJOR || '�а��� ' || SNAME || '�л��� ���� ������ ' || AVR || '�Դϴ�'
    FROM STUDENT;
   


--2) '__������ __���� �����Դϴ�.' ���·� ������ ������ ����϶�
SELECT CNAME || '������ ' || ST_NUM || '���� �����Դϴ�.'
    FROM COURSE;

--3) '__������ __�а� �Ҽ��Դϴ�.' ���·� ������ ������ ����϶�
SELECT PNAME || '������ ' || SECTION || '�а� �Ҽ��Դϴ�.'
    FROM PROFESSOR;

--�ߺ����� ����
--4) �б����� � �а��� �ִ��� �˻��Ѵ�(�л� ���̺� ������� �˻��Ѵ�)
SELECT DISTINCT MAJOR
    FROM STUDENT;

--5) �б����� � �а��� �ִ��� �˻��Ѵ�(���� ���̺� ������� �˻��Ѵ�)
SELECT DISTINCT SECTION
    FROM PROFESSOR;

--6) ������ ������ � �͵��� �ִ��� �˻��Ѵ�
SELECT DISTINCT ORDERS
    FROM PROFESSOR;







