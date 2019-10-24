



CREATE VIEW [dbo].[ClaimOrderHistory]
AS
SELECT   DISTINCT  TOP (100) PERCENT WCR.ID, WCR.LOCID, WCR.PROVID, CONVERT(VARCHAR(12), WCR.DOS, 101) AS DOSDP, WCR.DOS,
                             (SELECT        VALUE
                               FROM            dbo.LOCSVC_ID
                               WHERE        (LOCSVC_ID = WCR.LOCID) AND (CODE = 'TPX')) + '-' + WCR.Web_ID AS JobOrder, WCR.Claimtype, CONVERT(VARCHAR(12), 
                         WCR.DateCreated, 101) AS DateCreatedDP, WCR.DateCreated, WCR.Web_ID AS ClaimID, WCR.PATID
FROM            dbo.WP_CLAIM_REPORT AS WCR INNER JOIN
                         dbo.WP_CENT_TKR AS WCT ON WCR.Web_ID = WCT.ClaimID
WHERE        (WCR.DOS >= DATEADD(YEAR, - 1, GETDATE())) AND (WCR.vision_type IS NOT NULL) AND (LTRIM(RTRIM(WCR.vision_type)) <> '') AND 
                         (WCR.Web_ID IS NOT NULL) AND (claimtype = 'Exam and Eyeglass Order' OR claimtype = 'Eyeglass Order')
ORDER BY WCR.DOS DESC, ClaimID DESC