




CREATE VIEW [dbo].[ProcedureHistory]
AS
SELECT        HC.CLAIM_ID, HC.PAT_ID, HC.PROVIDER_ID, HC.VENDOR_ID,  
Case 
when hl.DIAGNOSIS_REF_01 = 1 then DIAG_CODE1
when hl.DIAGNOSIS_REF_01 = 2 then DIAG_CODE2
when hl.DIAGNOSIS_REF_01 = 3 then DIAG_CODE3
when hl.DIAGNOSIS_REF_01 = 4 then DIAG_CODE4
when hl.DIAGNOSIS_REF_01 = 5 then DIAG_CODE5
when hl.DIAGNOSIS_REF_01 = 6 then DIAG_CODE6
when hl.DIAGNOSIS_REF_01 = 7 then DIAG_CODE7
when hl.DIAGNOSIS_REF_01 = 8 then DIAG_CODE8
when hl.DIAGNOSIS_REF_01 = 9 then DIAG_CODE9
when hl.DIAGNOSIS_REF_01 = 10 then DIAG_CODE10
when hl.DIAGNOSIS_REF_01 = 11 then DIAG_CODE11
when hl.DIAGNOSIS_REF_01 = 12 then DIAG_CODE12
else ''
End as DIAG_CODE1,
HC.DOS, HL.PROCEDURE_CODE, PR.NAME AS ProviderName, IC.Description as Diagnosis, CP.Description AS [Procedure],
isnull(MODIFIER_CODE_01,'') ModifierCode01, isnull(MODIFIER_CODE_02,'') ModifierCode02
FROM            dbo.HCFA_CLAIM AS HC INNER JOIN
                         dbo.HCFA_LINE AS HL ON HC.CLAIM_ID = HL.CLAIM_ID INNER JOIN
                         dbo.PROVIDERS AS PR ON HC.PROVIDER_ID = PR.ID INNER JOIN
                         dbo.ICDDIAG AS IC ON HC.DIAG_CODE1 = IC.Code AND HC.DOS between IC.EFF_DATE and IC.EXP_DATE INNER JOIN
                         dbo.CPT AS CP ON HL.PROCEDURE_CODE = CP.Code
Where isnull(EXCEPTION_CODE_01,'') <> 'D033' and isnull(EXCEPTION_CODE_02,'') <> 'D033' and isnull(EXCEPTION_CODE_03,'') <> 'D033' and isnull(EXCEPTION_CODE_04,'') <> 'D033' 
and isnull(EXCEPTION_CODE_05,'') <> 'D033'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ProcedureHistory';


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
         Begin Table = "HC"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 287
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "HL"
            Begin Extent = 
               Top = 6
               Left = 325
               Bottom = 136
               Right = 594
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PR"
            Begin Extent = 
               Top = 6
               Left = 632
               Bottom = 136
               Right = 860
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IC"
            Begin Extent = 
               Top = 6
               Left = 898
               Bottom = 136
               Right = 1068
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CP"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ProcedureHistory';

