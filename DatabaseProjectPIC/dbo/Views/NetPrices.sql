﻿
CREATE VIEW [dbo].[NetPrices]
AS
SELECT     CPT_CODE, REGION, PAYOR_ID, SPECIALTY, PROVIDER_ID, FS_TYPE, IN_NETWORK, FACILITY_IND, CPT_MODIFIER, EFF_DATE, EXP_DATE, RATE_TYPE, PRICE, 
                      PRICE_2, PRICE_3, PRICE_4
FROM         dbo.NETPRICE