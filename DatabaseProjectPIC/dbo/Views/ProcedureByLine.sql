﻿

CREATE VIEW [dbo].[ProcedureByLine]
AS
SELECT        HCFA_LINE.PROCEDURE_CODE, CPT.Description, HCFA_LINE.CLAIM_ID, HCFA_LINE.LINE, HCFA_LINE.EXCEPTION_CODE_01 as ExceptionCode, ACT.Description as ExceptionDescription
FROM            dbo.HCFA_LINE AS HCFA_LINE INNER JOIN
                         dbo.CPT AS CPT ON CPT.Code = HCFA_LINE.PROCEDURE_CODE
						 INNER JOIN ACTCODE ACT ON ACT.Code = HCFA_LINE.EXCEPTION_CODE_01