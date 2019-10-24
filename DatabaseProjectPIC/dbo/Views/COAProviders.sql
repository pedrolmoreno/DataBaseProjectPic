CREATE view [dbo].[COAProviders]    
as    



select      
  pr.id [Id]  ,
  0 [NetworkId],   
 pr.[Name] [Description],   
 pr.STREET1 [Street1],    
 pr.STREET2 [Street2],    
 pr.City [City],    
 pr.[STATE] [State],    
 pr.ZIP_CODE [ZipCode],    
 pr.County [County],    
 pr.PHONE [Phone],    
 pr.EMAIL [Email],    
 s.[Description] [Specialty]    
from [dbo].[PROVIDERS] pr   
inner join dbo.[Specialtys] s  on pr.SPECIALTY = s.Code