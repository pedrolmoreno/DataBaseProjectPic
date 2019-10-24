﻿



CREATE VIEW [dbo].[MemberInfo]
AS

/*
	20170405	DT	Changed date filter to use the patient effective date
					Corrected references to reserved words
					Got rid of top (100) percent since there was no order by statement
	20170520    RR  WP-369: 				

*/
SELECT --TOP (100) PERCENT 
	 PAT.SUBSCRIBER_ID, PAT.DEPENDENT_SEQ, PAT.ID, PAT.LAST_NAME, PAT.FIRST_NAME, PAT.STREET1, PAT.STREET2
	,PAT.DATE_OF_BIRTH, PAT.SEX
	,ISNULL(REL.[DESCRIPTION], 'SELF') AS RELDESC, PAT.CITY
	,PAT.[STATE], PAT.ZIP_CODE
	,dbo.GRP.GROUP_NAME AS PGROUPNAME, dbo.PLN.NAME AS PPLANNAME, PAT.PHONE, PAT.EFF_DATE, PAT.EXP_DATE
	,C.[DESCRIPTION] AS COUNTY
	,PAT.COUNTRY, PAT.FAX, PAT.EMAIL, PAT.COUNTY AS Expr1, PLNH.PLAN_ID, PLNH.GROUP_NBR, dbo.GRP.PAYOR_ID
	, PLNH.EFF_DATE planhisteffdate, plnh.EXP_DATE planhistexpdate -- WP-369
	, GRP.grptype
FROM dbo.RPATACCT AS PAT WITH (NOLOCK)
LEFT JOIN dbo.Relation AS REL WITH (NOLOCK) ON REL.CODE = PAT.PAT_REL_TO_INSURED 
LEFT JOIN dbo.PLNHIST AS PLNH WITH (NOLOCK) ON PLNH.PAT_ID = PAT.ID 
	--AND pat.Eff_Date BETWEEN PLNH.EFF_DATE AND PLNH.EXP_DATE -- WP-369
	--AND GETDATE() BETWEEN PLNH.EFF_DATE AND PLNH.EXP_DATE LEFT OUTER JOIN
LEFT JOIN dbo.GRP WITH (NOLOCK) ON dbo.GRP.GROUP_NBR = PLNH.GROUP_NBR 
LEFT JOIN dbo.PLN WITH (NOLOCK) ON dbo.PLN.PLAN_NBR = PLNH.PLAN_ID 
	AND pat.Eff_Date BETWEEN dbo.PLN.EFF_DATE AND dbo.PLN.EXP_DATE 
	--AND PLNH.EFF_DATE BETWEEN dbo.PLN.EFF_DATE AND dbo.PLN.EXP_DATE LEFT OUTER JOIN
LEFT JOIN dbo.COUNTY AS C ON PAT.COUNTY = C.CODE
--WHERE        (GETDATE() BETWEEN PAT.EFF_DATE AND PAT.EXP_DATE)