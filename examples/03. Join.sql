--1. OUTER JOIN
CREATE TABLE BOARD(
    BOARD_NO NUMBER,
    BOARD_TITLE VARCHAR(50)
);

CREATE TABLE BOARD_FILE(
    BOARD_NO NUMBER,
    FILE_NM VARCHAR(50)
);

INSERT INTO BOARD_FILE VALUES(13, 'a');

SELECT * FROM BOARD_FILE;

SELECT A.BOARD_TITLE
     , B.BOARD_NO
     , NVL(B.FILE_NM, 'no file exist')
    FROM BOARD A
    FULL OUTER JOIN BOARD_FILE B
    ON A.BOARD_NO = B.BOARD_NO;



