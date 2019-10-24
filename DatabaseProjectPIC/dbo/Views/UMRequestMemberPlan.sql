
CREATE VIEW [dbo].[UMRequestMemberPlan]
AS

select distinct req.Id RequestId, p.REVIEW_STATUS AS thesysstatus, req.TheSysRequest, req.CreatedBy, req.DateCreated, p.AUTH_NO, dbo.precertp.CODE ProcedureCode, 
ISNULL(dbo.UM_DENIAL_CD.DESCRIPTION, '') AS Denial, ISNULL(dbo.UM_PEND_CD.DESCRIPTION, '') AS Pending, req.LocationId, p.ID AS PrecertID, 
ISNULL(RSC.DecisionTreeRecommendedStatus, '') AS RecommendedStatus, isnull(pat.ID,0) Id, isnull(pat.FIRST_NAME,'') as FirstName, isnull(PAT.LAST_NAME,'') LastName, PLNH.PLAN_ID PlanId, 
dbo.PLN.NAME AS PlanName, req.ServiceDate, req.LevelId, req.providerId, req.completed, lvl.name LevelName, p.AUTH_NO as AuthNumber, grp.GRPTYPE GroupType, INS.Payor_id PayerId
from requests req
left JOIN Levels  lvl on req.levelid = lvl.id
left JOIN dbo.Precert AS p ON CAST(req.TheSysRequest AS nvarchar) + 'P' = p.AUTH_NO 
left JOIN dbo.precertp ON p.ID = dbo.precertp.ID 
LEFT OUTER JOIN  dbo.UMDecisionTreeRecommendedStatusCriteria AS RSC ON p.ID = RSC.ThesysPrecertId OR req.Id = RSC.RequestId AND RSC.ProcedureCode = dbo.precertp.CODE 
LEFT OUTER JOIN  dbo.UM_DENIAL_CD ON dbo.UM_DENIAL_CD.CODE = p.Denial_Code 
LEFT OUTER JOIN  dbo.UM_PEND_CD ON dbo.UM_PEND_CD.CODE = p.Pend_Code
LEFT JOIN dbo.RPATACCT AS PAT WITH (NOLOCK) ON req.MemberId = pat.ID
AND req.ServiceDate between PAT.EFF_DATE and PAT.EXP_DATE
LEFT JOIN dbo.PLNHIST AS PLNH WITH (NOLOCK) ON PLNH.PAT_ID = PAT.ID 
AND req.ServiceDate between PLNH.EFF_DATE and PLNH.EXP_DATE
LEFT JOIN dbo.PLN WITH (NOLOCK) ON dbo.PLN.PLAN_NBR = PLNH.PLAN_ID 
AND pat.Eff_Date BETWEEN dbo.PLN.EFF_DATE AND dbo.PLN.EXP_DATE 
LEFT JOIN dbo.RPATINS AS INS WITH (NOLOCK) ON req.MemberId = INS.ACCT_ID
AND req.ServiceDate between INS.EFF_DATE and INS.EXP_DATE
LEFT JOIN dbo.GRP grp on PLNH.group_nbr = grp.group_nbr

--Where precertp.code is not null