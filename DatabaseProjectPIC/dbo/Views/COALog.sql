

CREATE view [dbo].[COALog]  
as  

select   
  -- This will force the oldest ones to display first  
  distinct   
    
  --1000000000 -
   coar.Id Sequencer  
 ,r.First_Name+' '+r.Last_Name MemberName  
 ,coar.MemberId  
 ,coar.RequestDate  
  
 ,case isnull(nc.Id,0)  
  when 0 then 'N/A'  
  else '['+cast(nc.Id as varchar(10))+'] '+nc.[Description]  
  end FromNetwork  
 ,'['+cast(nn.Id as varchar(10))+'] '+nn.[Description] ToNetwork  
  
 ,case isnull(cpa.id,0)  
  when 0 then 'N/A'  
  else '['+cast(cpa.Id as varchar(10))+'] '+cpa.[Name]  
  end FromProvider  
 ,cpa.Id  FromProviderId
 ,npa.Id  ToProviderId

 ,'['+cast(npa.Id as varchar(10))+'] '+npa.[Name] ToProvider  
 ,coar.DecisionStatus  
 ,'['+cast(coar.ChangeReasonId as varchar(10))+'] '+mrp.[Description] ChangeReason  
 ,coar.Notes  
 ,coar.DecisionDate,
 coar.RequestingProviderId   
from dbo.COARequest coar  
inner join .dbo.Maint_Reason_Pat mrp on mrp.Code=coar.ChangeReasonId  
inner join  [dbo].[RPATACCT] r on r.id=coar.MemberId  
and coar.RequestDate between r.eff_date and r.exp_date  
inner join  dbo.[PROVIDERS] p on p.id=coar.RequestingProviderId  
inner join  dbo.[PROVIDERS] npa on npa.id=coar.NewProviderAssignmentId  
left join  dbo.[PROVIDERS] cpa on cpa.id=coar.CurrentProviderAssignmentId  
inner join  dbo.Product nn on (nn.id = coar.NewNetworkId)  
left join  dbo.Product nc on (nc.id = coar.CurrentNetworkId)  
where coar.DecisionStatus ='P'  
union  

select  TOP 100 PERCENT * from (
	select    
	 distinct   
	  -- This will force the most recent ones to display first  
	  coar.Id Sequencer  
	 ,r.First_Name+' '+r.Last_Name MemberName  
	 ,coar.MemberId  
	 ,coar.RequestDate  
  
	 ,case isnull(nc.Id,0)  
	  when 0 then 'N/A'  
	  else '['+cast(nc.Id as varchar(10))+'] '+nc.[Description]  
	  end FromNetwork  
	 ,'['+cast(nn.Id as varchar(10))+'] '+nn.[Description] ToNetwork  
  
	 ,case isnull(cpa.id,0)  
	  when 0 then 'N/A'  
	  else '['+cast(cpa.Id as varchar(10))+'] '+cpa.[Name]  
	  end FromProvider  
	  ,cpa.Id  FromProviderId
	 ,npa.Id  ToProviderId
	 ,'['+cast(npa.Id as varchar(10))+'] '+npa.[Name] ToProvider  
	 ,coar.DecisionStatus  
	 ,'['+cast(coar.ChangeReasonId as varchar(10))+'] '+mrp.[Description] ChangeReason  
	 ,coar.Notes  
	 ,coar.DecisionDate  
	 , coar.RequestingProviderId 
	from dbo.COARequest coar  

	inner join dbo.Maint_Reason_Pat mrp on mrp.Code=coar.ChangeReasonId  
	inner join [dbo].[RPATACCT] r on r.id=coar.MemberId  
	 and coar.RequestDate between r.eff_date and r.exp_date  
	inner join dbo.[PROVIDERS] p on p.id=coar.RequestingProviderId  
	
	inner join dbo.[PROVIDERS] npa on npa.id=coar.NewProviderAssignmentId  
	left join dbo.[PROVIDERS] cpa on cpa.id=coar.CurrentProviderAssignmentId  
	inner join  dbo.Product nn on (nn.id = coar.NewNetworkId)  
	left join  dbo.Product nc on (nc.id = coar.CurrentNetworkId)  
	-- get the last 18 months  
	where coar.RequestDate>=getdate()-540  
	 and coar.DecisionStatus in ('A','D')  
	 ) t
	order by t.Sequencer desc