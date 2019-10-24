  
      
        
CREATE function [dbo].[COAProvidersToAssignment](@networkId int)        
returns table        
return (        
            
select              
distinct         
  pr.id [Id]            
 ,'['+ convert( varchar, pr.id  ) +'] '+pr.[Name] as [Description],            
 p.ID [NetworkId],            
 pr.STREET1 [Street1],            
 pr.STREET2 [Street2],            
 pr.City [City],            
 pr.[STATE] [State],            
 pr.ZIP_CODE [ZipCode],            
 pr.County [County],            
 pr.PHONE [Phone],            
 pr.EMAIL [Email],            
 s.[Description] [Specialty]            
from dbo.Product p            
inner join dbo.Grp_Product gp on gp.product_id=p.id            
 and getdate() between gp.eff_date and gp.exp_date            
 and gp.NetworkAssignmentIndicator=1            
inner join dbo.Prov_Status ps on ps.Provider_Product=p.Id             
and getdate() between ps.eff_date and ps.exp_date            
inner join dbo.[PROVIDERS] pr on pr.Id=ps.Provider_Id            
and getdate() between pr.eff_date and pr.exp_date            
inner join dbo.[Specialty] s  on pr.SPECIALTY = s.Code         
where p.ID = @networkId        
)