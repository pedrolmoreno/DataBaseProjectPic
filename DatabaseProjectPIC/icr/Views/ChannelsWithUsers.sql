


CREATE  VIEW [icr].[ChannelsWithUsers] AS

with Lob as (
SELECT DISTINCT 
LOB.VALUE LobId, min(LOB.SUB_CODE) LobName
FROM 
LOCSVC_ID LOB 
INNER JOIN LOCSVC VN ON VN.ID= LOB.LOCSVC_ID
where
LOB.CODE='LOB'  AND getdate() BETWEEN LOB.EFF_DATE AND LOB.EXP_DATE
Group by LOB.VALUE
),

LobVendor as (
SELECT DISTINCT 
V.ID VendorId, LOB.VALUE LobId, VN.Name VendorName
FROM 
VENDOR V 
INNER JOIN LOCSVC_ID LS ON LS.CODE='LTID' AND V.TAX_ID=LS.VALUE AND Getdate() BETWEEN LS.EFF_DATE AND LS.EXP_DATE
INNER JOIN LOCSVC_ID LOB ON LOB.CODE='LOB' AND LS.LOCSVC_ID=LOB.LOCSVC_ID AND getdate() BETWEEN LOB.EFF_DATE AND LOB.EXP_DATE
INNER JOIN LOCSVC VN ON VN.ID=V.ID
and GETDATE() between V.EFF_DATE and V.EXP_DATE
),


--- Relation between location and LOB
LobLocation as (
select l.LOCSVC_ID LocationId, l.Value LOB, VN.Name LocationName 
from locsvc_ID l
INNER JOIN LOCSVC VN ON VN.ID=l.LOCSVC_ID
where code = 'lob'
and  Getdate() BETWEEN L.EFF_DATE AND L.EXP_DATE
),

--- Relation between vendor and location
VendorLocation as (
select distinct l.locsvc_id LocationId,v.Id VendorId
from locsvc_ID l 
inner join vendor v on l.value = v.tax_id
where code = 'ltid'
and  Getdate() BETWEEN L.EFF_DATE AND L.EXP_DATE
and  Getdate() BETWEEN v.EFF_DATE AND v.EXP_DATE
),

LobVendorLocation as (
-- Final Vendor-Location Relation
select  lb.LobId LobId,lv.VendorId,ll.LocationId,lb.LobName,lv.VendorName,ll.LocationName
from Lob lb
inner join LobVendor lv on lb.LobId = lv.LobId
inner join LobLocation ll on lb.LobId = ll.LOB
inner join VendorLocation vl on lv.VendorId = vl.VendorId and ll.LocationId = vl.LocationId
),

LobChannel as (
select
'B' + LobId as Id,
null ChannelParentId,
10 ChannelType,
LobName Name,
'' [Description],
1 [ReadOnly],
0 Deleted,
('B' + LEFT(ISNULL(LobId,'') + '     ',5)) as LVL   
from LobVendorLocation),

VendorChannel as (
select
'B' + LobId + 'V' + CAST(VendorId AS VARCHAR(32)) as Id,
'B' + LobId ChannelParentId,
30 ChannelType,
VendorName Name,
'' [Description],
1 [ReadOnly],
0 Deleted,      
('B' + LEFT(ISNULL(LobId,'') + '     ',5) + 'V' + LEFT(ISNULL(CAST(VendorId AS VARCHAR(32)),'') + '     ',5)) as LVL
from LobVendorLocation ),

LocationsChannel as (
select
'B' + LobId + 'V' + CAST(VendorId AS VARCHAR(32)) + 'L' + CAST(LocationId AS VARCHAR(32)) as Id,
'B' + LobId + 'V' + CAST(VendorId AS VARCHAR(32)) ChannelParentId,
50 ChannelType,
LocationName Name,
'' [Description],
1 [ReadOnly],
0 Deleted,    
('B' + LEFT(ISNULL(LobId,'') + '     ',5) + 'V' + LEFT(ISNULL(CAST(VendorId AS VARCHAR(32)),'') + '     ',5) + 'L' + LEFT(ISNULL(CAST(LocationId AS VARCHAR(32)),'') + '     ',5)) as LVL
from LobVendorLocation )
/*
CAST(
			  STUFF(
					STUFF(
						   STUFF(
								  STUFF(
										 STUFF(CONVERT(CHAR(34),CONVERT(BINARY(16),LEFT(ISNULL(a.ChannelParentId,'') + 'xxxxxxxxxxxxxxx',16),0),1),1,2,'')
			,9,0,'-'),14,0,'-'),19,0,'-'),24,0,'-') 
		AS uniqueidentifier) 
*/
SELECT	CAST(
			  STUFF(
					STUFF(
						   STUFF(
								  STUFF(
										 STUFF(CONVERT(CHAR(34),CONVERT(BINARY(16),LEFT(ISNULL(a.Id,'') + 'xxxxxxxxxxxxxxx',16),0),1),1,2,'')
			,9,0,'-'),14,0,'-'),19,0,'-'),24,0,'-') 
		AS uniqueidentifier)  AS Id,
		CAST(
			  STUFF(
					STUFF(
						   STUFF(
								  STUFF(
										 STUFF(CONVERT(CHAR(34),CONVERT(BINARY(16),LEFT(ISNULL(a.ChannelParentId,'') + 'xxxxxxxxxxxxxxx',16),0),1)
										 ,1,2,'')
								 ,9,0,'-')
						  ,14,0,'-')
					,19,0,'-')
			 ,24,0,'-') 
		AS uniqueidentifier) AS ChannelParentId, 
		a.ChannelType, 
		a.Name, 
		a.Description, 
		a.ReadOnly, 
		a.Deleted, 
		a.LVL,
		b.UserAccountId
FROM (
SELECT	LobChannel.Id, 
		LobChannel.ChannelParentId, 
		LobChannel.ChannelType, 
		LobChannel.Name, 
		LobChannel.Description, 
		LobChannel.ReadOnly, 
		LobChannel.Deleted, 
		LobChannel.LVL 
from LobChannel 
UNION
SELECT	VendorChannel.Id, 
		VendorChannel.ChannelParentId, 
		VendorChannel.ChannelType, 
		VendorChannel.Name, 
		VendorChannel.Description, 
		VendorChannel.ReadOnly, 
		VendorChannel.Deleted, 
		VendorChannel.LVL 
from VendorChannel 
UNION
SELECT	LocationsChannel.Id, 
		LocationsChannel.ChannelParentId, 
		LocationsChannel.ChannelType, 
		LocationsChannel.Name, 
		LocationsChannel.Description, 
		LocationsChannel.ReadOnly, 
		LocationsChannel.Deleted, 
		LocationsChannel.LVL 
from LocationsChannel
) a 
INNER JOIN dbo.ChannelUsers b ON a.Id=b.ChannelId