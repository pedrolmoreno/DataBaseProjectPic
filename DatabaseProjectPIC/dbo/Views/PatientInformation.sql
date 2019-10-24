CREATE VIEW [dbo].[PatientInformation]
AS
SELECT     rpa.PAT_ACCT_NO, rpa.COUNTY, rpa.EFF_DATE, rpa.EXP_DATE, C.DESCRIPTION, rpa.SUBSCRIBER_ID
FROM         dbo.RPATACCT AS rpa WITH (NOLOCK) LEFT OUTER JOIN
                      dbo.COUNTY AS C ON rpa.COUNTY = C.CODE