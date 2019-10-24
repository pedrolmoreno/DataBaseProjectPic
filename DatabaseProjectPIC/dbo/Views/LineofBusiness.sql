
CREATE view [dbo].[LineofBusiness]
AS
SELECT code, case when Code = 1 then 'ICARE HEALTH SOLUTIONS' else description end as Description, MAINTENANCE_USER, MAINTENANCE_DATE, MAINTENANCE_ACTIVITY   
FROM  LOB