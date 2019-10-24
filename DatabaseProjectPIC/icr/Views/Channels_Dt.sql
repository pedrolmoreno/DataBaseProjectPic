--DT 20180829	Changed Lob CTE to Lobx since there is a synonym of LOB and could be very confusing
--				Added schema dbo to all synonyms.  Slight perfomance improvement
--				Added CAST statements to override the implicit into to string conversions vendor id, locsvc id, LobName, etc
--				Removed unnecessary cast statements on columns that were already strings - VendorId, LocationId, LobId

Create VIEW [icr].[Channels_Dt] as

	--- Relation between Vendor and LOB
	with Lobx as (
		SELECT DISTINCT 
			  cast(LOB.[value] as varchar(10)) LobId
			, cast(min(LOB.SUB_CODE) as varchar(5)) LobName
		FROM dbo.LOCSVC_ID LOB 
		INNER JOIN dbo.LOCSVC VN ON VN.ID=LOB.LOCSVC_ID
		where LOB.CODE='LOB'  
			AND getdate() BETWEEN LOB.EFF_DATE AND LOB.EXP_DATE
		Group by LOB.[value]
	)

	,LobVendor as (
		SELECT DISTINCT 
			  cast(V.ID as varchar(10)) VendorId
			, LOB.[value] LobId
			, VN.[Name] VendorName
		FROM dbo.VENDORSS V 
		INNER JOIN dbo.LOCSVC_ID LS ON LS.CODE='LTID' 
			AND V.TAX_ID=LS.[value] 
			AND Getdate() BETWEEN LS.EFF_DATE AND LS.EXP_DATE
		INNER JOIN dbo.LOCSVC_ID LOB ON LOB.CODE='LOB' 
			AND LS.LOCSVC_ID=LOB.LOCSVC_ID 
			AND getdate() BETWEEN LOB.EFF_DATE AND LOB.EXP_DATE
		INNER JOIN dbo.LOCSVC VN ON VN.ID=V.ID
			and GETDATE() between V.EFF_DATE and V.EXP_DATE
	)

	--- Relation between location and LOB
	,LobLocation as (
		select 
			  cast(l.LOCSVC_ID as varchar(10)) LocationId
			, l.[value] LOB
			, VN.[Name] LocationName 
		from dbo.locsvc_ID l
		INNER JOIN dbo.LOCSVC VN ON VN.ID=l.LOCSVC_ID
		where code = 'lob'
			and  Getdate() BETWEEN L.EFF_DATE AND L.EXP_DATE
	)

	--- Relation between vendor and location
	,VendorLocation as (
		select distinct
			  cast(l.locsvc_id as varchar(10)) LocationId
			, cast(v.Id as varchar(10)) VendorId
		from dbo.locsvc_ID l 
		inner join dbo.vendorss v on l.[value] = v.tax_id
		where code = 'ltid'
			and  Getdate() BETWEEN L.EFF_DATE AND L.EXP_DATE
			and  Getdate() BETWEEN v.EFF_DATE AND v.EXP_DATE
	)

	-- Final Vendor-Location Relation
	,LobVendorLocation as (
		select  
			  lb.LobId LobId
			, lv.VendorId
			, ll.LocationId
			, lb.LobName
			, lv.VendorName
			, ll.LocationName
		from Lobx lb
		inner join LobVendor lv on lb.LobId = lv.LobId
		inner join LobLocation ll on lb.LobId = ll.LOB
		inner join VendorLocation vl on lv.VendorId = vl.VendorId 
			and ll.LocationId = vl.LocationId
	)

	,LobChannel as (
		select
			dbo.UUIDX('B' + LobId) as Id,
			null ChannelParentId,
			10 ChannelType,
			LobName [Name],
			'' [Description],
			1 [ReadOnly],
			0 Deleted,
			('B' + LEFT(ISNULL(LobId,'') + '     ',5)) as LVL   
		from LobVendorLocation
	)

	,VendorChannel as (
		select
			dbo.UUIDX('B' + LobId + 'V' + VendorId) as Id,
			dbo.UUIDX('B' + LobId) ChannelParentId,
			30 ChannelType,
			VendorName [Name],
			'' [Description],
			1 [ReadOnly],
			0 Deleted,      
			('B' + LEFT(ISNULL(LobId,'') + '     ',5) + 'V' + LEFT(ISNULL(VendorId,'') + '     ',5)) as LVL
		from LobVendorLocation 
	)

	,LocationsChannel as (
		select
			dbo.UUIDX('B' + LobId + 'V' + VendorId + 'L' + LocationId) as Id,
			dbo.UUIDX('B' + LobId + 'V' + VendorId) ChannelParentId,
			50 ChannelType,
			LocationName [Name],
			'' [Description],
			1 [ReadOnly],
			0 Deleted,    
			('B' + LEFT(ISNULL(LobId,'') + '     ',5) + 'V' + LEFT(ISNULL(VendorId,'') + '     ',5) + 'L' + LEFT(ISNULL(LocationId,'') + '     ',5)) as LVL
		from LobVendorLocation 
	)

	Select * from LobChannel 
	UNION
	Select * from VendorChannel 
	UNION
	Select * from LocationsChannel