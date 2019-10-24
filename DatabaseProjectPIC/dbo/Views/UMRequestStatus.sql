﻿CREATE VIEW [dbo].[UMRequestStatus]
AS
SELECT DISTINCT 
                         r.Id, p.REVIEW_STATUS AS thesysstatus, r.TheSysRequest, r.CreatedBy, r.DateCreated, p.AUTH_NO, dbo.precertp.CODE, ISNULL(dbo.UM_DENIAL_CD.DESCRIPTION, '') AS Denial, ISNULL(dbo.UM_PEND_CD.DESCRIPTION, '') 
                         AS Pending, r.LocationId, p.ID AS PrecertID, ISNULL(RSC.DecisionTreeRecommendedStatus, '') AS RecommendedStatus, p.PAYOR_ID AS PayerId
FROM            dbo.Requests AS r INNER JOIN
                         dbo.Precert AS p ON CAST(r.TheSysRequest AS nvarchar) + 'P' = p.AUTH_NO INNER JOIN
                         dbo.precertp ON p.ID = dbo.precertp.ID LEFT OUTER JOIN
                         dbo.UMDecisionTreeRecommendedStatusCriteria AS RSC ON p.ID = RSC.ThesysPrecertId OR r.Id = RSC.RequestId AND RSC.ProcedureCode = dbo.precertp.CODE LEFT OUTER JOIN
                         dbo.UM_DENIAL_CD ON dbo.UM_DENIAL_CD.CODE = p.Denial_Code LEFT OUTER JOIN
                         dbo.UM_PEND_CD ON dbo.UM_PEND_CD.CODE = p.Pend_Code
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UMRequestStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'h = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UMRequestStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "r"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 5
               Left = 558
               Bottom = 135
               Right = 777
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "precertp"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "RSC"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 324
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "UM_DENIAL_CD"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UM_PEND_CD"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Widt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UMRequestStatus';

