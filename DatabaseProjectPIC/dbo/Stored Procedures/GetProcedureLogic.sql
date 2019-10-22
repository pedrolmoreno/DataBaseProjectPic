﻿
CREATE PROCEDURE [dbo].[GetProcedureLogic]
	(
		@PROVIDER_ID	INT,
		@PAT_ID			INT,
		@PROC_CODE		VARCHAR(7)
	)
	
AS

SET NOCOUNT ON

DECLARE @PAYOR_ID		INT
DECLARE @PLAN_ID		INT
--PLAN_ID Changes, we need original
DECLARE @ORIG_PLAN_ID	INT
DECLARE @PFSTYPE		INT
DECLARE @SFSTYPE		INT
DECLARE @TFSTYPE		INT
DECLARE @QFSTYPE		INT
DECLARE @return_value	INT
DECLARE @INNETWORK		CHAR(1)
DECLARE @SPECIALTY		int
DECLARE @FACILITY_IND	CHAr(1)
DECLARE @VDATE			DATETIME
DECLARE	@LOCSVC			INT
DECLARE @LOB			INT
DECLARE @GROUPNBR		INT

SELECT @VDATE = GETDATE()

--GET PAT info
--------------------------------------------------------
SELECT 
	@PAYOR_ID = INS.PAYOR_ID, @PLAN_ID = PH.PLAN_ID, @GROUPNBR = PH.GROUP_NBR
FROM 
	RPATINS INS
JOIN PLNHIST PH
ON
INS.ACCT_ID = PH.PAT_ID
AND
	GETDATE() BETWEEN PH.EFF_DATE AND PH.EXP_DATE
WHERE 
	INS.ACCT_ID = @PAT_ID
AND
	INS.PAYOR_IND = 'P'

--Set ORIG_PLAN_ID to keep for later
SELECT @ORIG_PLAN_ID = @PLAN_ID 

SELECT @LOB = LOB from GRP WHERE GROUP_NBR = @GROUPNBR and GETDATE() BETWEEN EFF_DATE and EXP_DATE

-- GET THE CORRECT PROV PAY RECORD!
---------------------------------------------------
EXEC	@return_value = [thesys].[dbo].[RBACK_PROVPAYOR]
		@LOB = @LOB OUTPUT,
		@PAYOR_ID = @PAYOR_ID OUTPUT,
		@PROVIDER_ID = @PROVIDER_ID OUTPUT,
		@REGION = '*',
		@GRP = 0,
		@PLN = @PLAN_ID OUTPUT,
		@LOCSVC = 1,
		@VDATE = @VDATE OUTPUT

-- NOW GET THE DATA FROM PROV PAY!
--------------------------------------------
SELECT 
	@PFSTYPE = PRI_FS_TYPE,
	@SFSTYPE = SEC_FS_TYPE,
	@TFSTYPE = TERT_FS_TYPE,
	@QFSTYPE = QUAD_FS_TYPE,
	@INNETWORK = NETWORK_FLAG,
	@SPECIALTY = SPECIALTY
FROM 
	PROV_PAYOR
WHERE
	PROVIDER_ID = @PROVIDER_ID
AND
	PAYOR_ID = @PAYOR_ID
AND 
	PLN_NBR = @PLAN_ID
AND
	LOB=@LOB

--Check CPTLogic Rollback for CPT
---------------------------------------------------
EXEC	@return_value = [thesys].[dbo].[RBACK_CPTLOGIC]
		@PAYOR = @PAYOR_ID OUTPUT,
		@REGION = '*',
		@PLAN_ID = @ORIG_PLAN_ID OUTPUT,
		@SPECIALTY = @SPECIALTY OUTPUT,
		@PROVIDER = @PROVIDER_ID OUTPUT
	
	SELECT *
		FROM CPTLOGIC(NOLOCK) WHERE PAYOR_ID=@PAYOR_ID AND REGION='*'
        AND PLAN_ID=@ORIG_PLAN_ID AND SPECIALTY=@SPECIALTY AND PROVIDER_ID=@PROVIDER_ID
        AND PRIMARY_CPT=@PROC_CODE	




