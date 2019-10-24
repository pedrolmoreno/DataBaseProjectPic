

CREATE VIEW [dbo].[UMCriteriaRelated]
AS
SELECT        dbo.UMCriterias.procedure_code, dbo.UMCriterias.notes, dbo.UMCriterias.created, dbo.CPT.Description AS ProcedureDescription, 
                         dbo.GRP_TYPE.DESCRIPTION AS GroupDescription, dbo.LOB.DESCRIPTION AS LOBName, dbo.Specialtys.Description AS SpecialtysDescription, dbo.PAYORS.NAME AS PayorName, dbo.UMCriterias.id, dbo.UMCriterias.lob, 
                         dbo.UMCriterias.payor, dbo.UMCriterias.insurance_group, dbo.UMCriterias.specialty
FROM            dbo.UMCriterias LEFT OUTER JOIN
                         dbo.PAYORS ON dbo.UMCriterias.payor = dbo.PAYORS.ID LEFT OUTER JOIN
                         dbo.LOB ON dbo.UMCriterias.lob = dbo.LOB.CODE LEFT OUTER JOIN
                         dbo.Specialtys ON dbo.UMCriterias.specialty = dbo.Specialtys.Code LEFT OUTER JOIN
                         dbo.CPT ON dbo.UMCriterias.procedure_code = dbo.CPT.Code LEFT OUTER JOIN
                         dbo.GRP_TYPE ON dbo.UMCriterias.insurance_group = dbo.GRP_TYPE.CODE