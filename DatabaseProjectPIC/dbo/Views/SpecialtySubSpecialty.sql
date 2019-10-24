

create view [dbo].[SpecialtySubSpecialty]
AS
select PROVIDER_ID,  SUB_SPECIALTY, SP.Description as SubDescription1, SUB_SPECIALTY_2, SP2.Description as SubDescription2, 
SUB_SPECIALTY_3, SP3.Description as SubDescription3, SUB_SPECIALTY_4, SP4.Description as SubDescription4, SUB_SPECIALTY_5, SP5.Description as SubDescription5
FROM PROV_CRED PC
LEFT JOIN Specialty SP ON PC.SUB_SPECIALTY = SP.CODE
LEFT JOIN Specialty SP2 ON PC.SUB_SPECIALTY_2 = SP2.CODE
LEFT JOIN Specialty SP3 ON PC.SUB_SPECIALTY_3 = SP3.CODE
LEFT JOIN Specialty SP4 ON PC.SUB_SPECIALTY_4 = SP4.CODE
LEFT JOIN Specialty SP5 ON PC.SUB_SPECIALTY_5 = SP5.CODE