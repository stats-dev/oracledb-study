--1)student ���̺� ������ �˻��ض�
DESC STUDENT;

--2)course ���̺� ������ �˻��ض�
DESC COURSE;

--3)professor ���̺� ������ �˻��ض�
DESC PROFESSOR;

--4)score ���̺� ������ �˻��ض�
DESC SCORE;

--5) ��� �л��� ������ �˻��ض�
SELECT *
    FROM STUDENT;

--7) ��� ������ ������ �˻��ض�
SELECT *
    FROM COURSE;

--8) �⸻��� ���������� �˻��ض�
SELECT RESULT
    FROM SCORE;

--9) �л����� �а��� �г��� �˻��ض�
SELECT MAJOR
    ,SYEAR
    FROM STUDENT;

--10) �� ������ �̸��� ������ �˻��ض�
SELECT CNAME
    , ST_NUM
    FROM COURSE;

--11) ��� ������ ������ �˻��ض�
SELECT ORDERS
    FROM PROFESSOR;
