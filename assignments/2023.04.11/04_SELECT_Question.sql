--ORDER BY
--1) ���������� �л��� �̸��� �˻��϶�
SELECT AVR
    , SNAME
    FROM STUDENT
    ORDER BY AVR DESC;


--2) �а��� ���������� �л��� ������ �˻��϶�
SELECT *
    FROM STUDENT
    ORDER BY MAJOR, AVR DESC;

--3) �г⺰ ���������� �л��� ������ �˻��϶�
SELECT *
    FROM STUDENT
    ORDER BY SYEAR, AVR DESC;

--4) �а��� �г⺰�� �л��� ������ ���������� �˻��϶�
SELECT *
    FROM STUDENT
    ORDER BY MAJOR, SYEAR, AVR DESC;

--5) ���������� ���� �̸��� �˻��϶�
SELECT CNAME
    FROM COURSE
    ORDER BY ST_NUM DESC;

--6) �� �а����� ������ ������ �˻��϶�
SELECT *
    FROM PROFESSOR
    ORDER BY SECTION;

--7) �������� ������ ������ �˻��϶�
SELECT *
    FROM PROFESSOR
    ORDER BY ORDERS;

--8) �� �а����� ������ ������ �������� ������ �˻��϶�
SELECT *
    FROM PROFESSOR
    ORDER BY SECTION, HIREDATE ASC;

