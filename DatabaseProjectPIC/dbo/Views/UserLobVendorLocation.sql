CREATE VIEW [dbo].[UserLobVendorLocation]
AS
SELECT        SUBSTRING(icr.Channels.LVL, 2, 5) AS lob, SUBSTRING(icr.Channels.LVL, 8, 5) AS ven, SUBSTRING(icr.Channels.LVL, 14, 5) AS loc, dbo.ChannelUsers.UserAccountId
FROM            icr.Channels INNER JOIN
                         dbo.ChannelUsers ON icr.Channels.Id = dbo.ChannelUsers.ChannelId
GROUP BY icr.Channels.LVL, dbo.ChannelUsers.UserAccountId