CREATE view [dbo].[COAPcpHistory]
as
select
distinct 
pp.pat_id [MemberId] , 
 '['+pt.Code+'] '+pt.[Description] PcpType
	,'['+cast(p.Id as varchar(10))+'] '+p.[Name] PcpProviderName
	,pp.Eff_Date [EffectiveDate]
	,pp.Exp_Date [ExpirationDate]
	,'['+mrp.Code+'] '+mrp.[Description] ChangeReason
	,r.First_Name+' '+r.last_Name [MemberName] 
from dbo.Pat_Pcp pp
inner join dbo.Pcp_Type pt on pt.Code=pp.Pcp_Type 
inner join dbo.Maint_Reason_Pat mrp on mrp.Code=pp.Maintenance_Reason
inner join dbo.[PROVIDERS] p on p.Id=pp.Provider_Id 
	and pp.Exp_Date between p.Eff_Date and p.Exp_Date
inner Join [dbo].[RPATACCT] r on r.id=pp.Pat_Id 
	and pp.Exp_Date between r.Eff_Date and r.Exp_Date