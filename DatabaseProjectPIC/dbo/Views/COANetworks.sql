CREATE view [dbo].[COANetworks]
as

	select distinct 
	 p.id Id,
	 p.[Description] [Description],
	 a.SUBSCRIBER_ID [SubscriberId],
	 NetworkAssignmentIndicator
	from dbo.Product p
	inner join dbo.Grp_Product gp on gp.product_id=p.id
		and getdate() between gp.eff_date and gp.exp_date
		and gp.NetworkAssignmentIndicator=1
	inner join dbo.PlnHist ph on ph.group_nbr=gp.group_id 
		and getdate() between ph.eff_date and ph.exp_date
	inner join dbo.RPatAcct a on a.Id=ph.Pat_Id
		and getdate() between ph.eff_date and ph.exp_date