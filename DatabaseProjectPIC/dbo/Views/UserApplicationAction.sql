CREATE VIEW [dbo].[UserApplicationAction]
AS
SELECT        UA.Id AS UserId, AA.ApplicationId, AA.Name ActionName, AA.Deleted, AA.IsInternal
FROM            dbo.UserAccounts AS UA INNER JOIN
                         dbo.UserRoles AS UR ON UA.Id = UR.UserAccountId INNER JOIN
                         dbo.RoleActions AS RA ON UR.RoleId = RA.RoleId INNER JOIN
                         dbo.ApplicationActions AS AA ON RA.ActionId = AA.Id