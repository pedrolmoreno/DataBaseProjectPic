CREATE function [dbo].[COAQtyPcpsByProviderTD](@idProvider int)  
returns table  
as  
return  
(  
select   
  m.CoaMonth [Month]
 ,count(*) Qty  
from dbo.COAMonthToDate m  
inner join dbo.PAT_PCP p on p.eff_date <= m.EndOfMonth   
 and p.exp_date >= m.StartOfMonth  
where provider_id=@idProvider  
group by m.MonthText, m.CoaMonth, p.Provider_Id  
  
)