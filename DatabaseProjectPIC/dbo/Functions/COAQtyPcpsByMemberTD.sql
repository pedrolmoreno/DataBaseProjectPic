CREATE function [dbo].[COAQtyPcpsByMemberTD](@idMember int)    
returns table    
as    
return    
(    
select     
  m.CoaMonth [Month]  
 ,count(*) Qty    
from dbo.COAMonthToDate m    
inner join dbo.PAT_PCP  p on p.eff_date <= m.EndOfMonth     
 and p.exp_date >= m.StartOfMonth    
where p.pat_id=@idMember    
group by m.MonthText, m.CoaMonth, p.pat_id  
    
)