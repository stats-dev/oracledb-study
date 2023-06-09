--1) 어제 만든 SCORE_STGR 테이블의 SNO 컬럼에 INDEX를 추가하세요.
CREATE INDEX SCORE_STGR_SNO_IDX
            ON SCORE_STGR(SNO);


CREATE INDEX STGR_SO_IDX
    ON SCORE_STGR(SNO);


--2) 어제 만든 ST_COURSEPF 테이블의 SNO, CNO, PNO 다중 컬럼에 INDEX를 추가하세요.
CREATE INDEX ST_COURSEPF_SNO_CNO_PNO_IDX
            ON ST_COURSEPF(SNO, CNO, PNO);


CREATE INDEX STCOPF_SCPNO_IDX
    ON ST_COURSEPF(SNO, CNO, PNO);
            
----인덱스 확인
--SELECT UIC.INDEX_NAME
--     , UIC.COLUMN_NAME
--     , UIC.COLUMN_POSITION
--     , UI.UNIQUENESS
--    FROM USER_INDEXES UI
--    JOIN USER_IND_COLUMNS UIC
--    ON UI.INDEX_NAME = UIC.INDEX_NAME
--    AND UI.TABLE_NAME IN ('SCORE_STGR', 'ST_COURSEPF')
--    ORDER BY UI.TABLE_NAME, UIC.INDEX_NAME, UIC.COLUMN_POSITION;
