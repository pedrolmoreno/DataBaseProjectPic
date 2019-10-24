CREATE VIEW [dbo].[Diagnosis]
AS
SELECT     Code, Description, Eff_DATE, Exp_DATE, ICDVersion
FROM         dbo.ICDDIAG