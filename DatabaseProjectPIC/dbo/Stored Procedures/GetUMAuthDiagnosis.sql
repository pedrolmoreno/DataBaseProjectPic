﻿
CREATE PROCEDURE [dbo].[GetUMAuthDiagnosis]
	@precert_id	INT
AS
BEGIN

SET NOCOUNT ON

 
DECLARE @RETURN_TABLE TABLE(
	DIAG_CODE	VARCHAR(100),
	Description	VARCHAR(100))

--
/*****************************************************************************************************
--  GET DETAIL DATA FOR DIAG CODE AND DESCRIPTION FOR AUTHORIZATION
******************************************************************************************************/
INSERT INTO @RETURN_TABLE
SELECT TOP 4 DIAG_CODE, Description FROM (
SELECT DIAG_CODE, ICDD.Description  FROM precertd PD INNER JOIN ICDDIAG ICDD ON PD.DIAG_CODE=ICDD.Code WHERE ID=@precert_id AND DIAG_SEQ=5
UNION
SELECT DIAG_CODE, ICDD.Description  FROM precertd PD INNER JOIN ICDDIAG ICDD ON PD.DIAG_CODE=ICDD.Code WHERE ID=@precert_id AND DIAG_SEQ=6
UNION
SELECT DIAG_CODE, ICDD.Description  FROM precertd PD INNER JOIN ICDDIAG ICDD ON PD.DIAG_CODE=ICDD.Code WHERE ID=@precert_id AND DIAG_SEQ=0
UNION
SELECT DIAG_CODE, ICDD.Description  FROM precertd PD INNER JOIN ICDDIAG ICDD ON PD.DIAG_CODE=ICDD.Code WHERE ID=@precert_id AND DIAG_SEQ=1
UNION
SELECT DIAG_CODE, ICDD.Description  FROM precertd PD INNER JOIN ICDDIAG ICDD ON PD.DIAG_CODE=ICDD.Code WHERE ID=@precert_id AND DIAG_SEQ=2
UNION
SELECT DIAG_CODE, ICDD.Description  FROM precertd PD INNER JOIN ICDDIAG ICDD ON PD.DIAG_CODE=ICDD.Code WHERE ID=@precert_id AND DIAG_SEQ=3
UNION
SELECT DIAG_CODE, ICDD.Description  FROM precertd PD INNER JOIN ICDDIAG ICDD ON PD.DIAG_CODE=ICDD.Code WHERE ID=@precert_id AND DIAG_SEQ=4
) DIAGCODE
 
SELECT * FROM @RETURN_TABLE 
END




