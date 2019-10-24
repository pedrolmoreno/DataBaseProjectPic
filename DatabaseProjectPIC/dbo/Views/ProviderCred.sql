CREATE view [dbo].[ProviderCred]
AS
SELECT PROVIDERS.*     
FROM PROVIDERS
LEFT join PROV_CRED on PROVIDERS.ID = prov_cred.PROVIDER_ID
Where prov_Cred.status not in ('O','T')