CREATE view [dbo].[COAPcps]
as

	select 
	p.PAT_ID [MemberId],
	p.Provider_Id [ProviderId],
	p.EXP_DATE [ExpDate]
from dbo.PAT_PCP p
inner join dbo.[PROVIDERS] pr on pr.Id=p.Provider_Id 
and p.exp_date between pr.eff_date and pr.exp_date