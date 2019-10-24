CREATE view [dbo].[COAMembers]
as



	 select distinct 
	 
		m.ID [Id], 
		m.LAST_NAME [LastName], 
		m.FIRST_NAME [FirstName],
		m.STREET1 [Street1],
		m.STREET2 [Street2],
		m.CITY [City],
		m.STATE [State],
		m.COUNTRY [Country],
		m.ZIP_CODE [ZipCode],
		m.PHONE [Phone],
		m.EMAIL [Email],
		m.SUBSCRIBER_ID [SubscriberId],
		m.DEPENDENT_SEQ [DependentSequence],
		m.DATE_OF_BIRTH [DateBirth],
		m.EFF_DATE [EffectiveDate],
		m.EXP_DATE [ExpirationDate]
	 
	 
	 from dbo.RPATACCT m
	 inner join RPATINS rptins on (m.ID = rptins.ACCT_ID)
	 inner join PAYORS_ID payid on (rptins.PAYOR_ID  =payid.PAYOR_ID)
	 inner join PAYORS pay on (payid.PAYOR_ID = pay.ID)
	 where (rptins.PAYOR_IND = 'P')