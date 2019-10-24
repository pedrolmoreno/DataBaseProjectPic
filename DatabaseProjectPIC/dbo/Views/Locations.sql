

CREATE VIEW [dbo].[Locations]
AS
SELECT DISTINCT TOP (100) PERCENT L.LOCSVC_ID, '[' + CAST(LN.ID AS VARCHAR(12)) + '] ' + LN.Name + ' - ' + LN.Street1 AS NAME
FROM            dbo.LOCSVC_ID AS L INNER JOIN
                         dbo.LOCSVC AS LN ON L.LOCSVC_ID = LN.ID
WHERE        (L.LOCSVC_ID IN
                             (SELECT DISTINCT LS.LOCSVC_ID
                               FROM            dbo.VENDORSS AS V INNER JOIN
                                                         dbo.LOCSVC_ID AS LS ON V.TAX_ID = LS.VALUE AND LS.CODE = 'LTID' AND GETDATE() BETWEEN LS.EFF_DATE AND LS.EXP_DATE INNER JOIN
                                                         dbo.LOCSVC_ID AS LOB ON LOB.CODE = 'LOB' AND LS.LOCSVC_ID = LOB.LOCSVC_ID AND GETDATE() BETWEEN LOB.EFF_DATE AND LOB.EXP_DATE))
ORDER BY NAME