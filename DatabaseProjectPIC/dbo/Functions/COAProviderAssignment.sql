CREATE function [dbo].[COAProviderAssignment](@memberId int, @pcpType varchar(50))
returns table
return (
select top 1  
 pr.id Id 
,pr.[Name] [Description]
from dbo.Pat_Pcp p1 
inner join dbo.[Provider] pr on pr.Id=p1.Provider_Id  
and p1.exp_date between pr.eff_date and pr.exp_date 
left join dbo.COARequest coar on coar.CurrentProviderAssignmentId=p1.Provider_Id  
and coar.MemberId=p1.Pat_Id 
and p1.exp_date between coar.EffectiveDate and coar.ExpirationDate 
and coar.RequestDate<getdate() 
and coar.DecisionStatus='A' 
where p1.Pat_Id=@memberId 
and p1.Pcp_Type=@pcpType
)