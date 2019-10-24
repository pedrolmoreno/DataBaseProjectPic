-- =============================================
-- Author:		Renier Serven
-- Create date: 09/25/2019
-- Description:	Get All Coa Request MTD AND YTD
-- =============================================
CREATE FUNCTION [dbo].[GetCoaMtdYtdProvider] 
(	
	-- Add the parameters for the function here
	@ProviderId int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	With CoaHistory as (SELECT    distinct  dbo.COARequest.MemberId, TheSys.dbo.PAT_PCP.PROVIDER_ID, dbo.COARequest.EffectiveDate, dbo.COARequest.DecisionStatus, MONTH(dbo.COARequest.EffectiveDate) AS MonthEffCoaDate, 
							 YEAR(dbo.COARequest.EffectiveDate) AS YearEffCoaDate
	FROM            TheSys.dbo.PAT_PCP INNER JOIN
							 dbo.COARequest ON TheSys.dbo.PAT_PCP.PAT_ID = dbo.COARequest.MemberId AND CONVERT(varchar, TheSys.dbo.PAT_PCP.EFF_DATE, 101) = CONVERT(varchar, dbo.COARequest.EffectiveDate, 101)
	WHERE        (dbo.COARequest.DecisionStatus = N'A')),

	CoaMonth as(Select Count(*)  [Month] from CoaHistory
	Where PROVIDER_ID=@ProviderId and MonthEffCoaDate=Month(getDate()) and YearEffCoaDate=Year(getDate())), 

	CoaYear as (Select Count(*)  [Year] from CoaHistory
	Where PROVIDER_ID=@ProviderId and  YearEffCoaDate=Year(getDate())), 

	CoaFinal as(Select * from CoaMonth, CoaYear)

	Select * From CoaFinal
)