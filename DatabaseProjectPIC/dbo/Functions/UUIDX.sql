
CREATE FUNCTION [dbo].[UUIDX] (@ndata VARCHAR(16))
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
  DECLARE @vGuid AS UNIQUEIDENTIFIER
  DECLARE @nValue AS VARCHAR(33)
  
  SELECT @nValue = LEFT(ISNULL(@ndata,'') + 'xxxxxxxxxxxxxxx',16)

  Select
	 @vGuid = 
		CAST(
			STUFF(STUFF(STUFF(STUFF(
							STUFF(CONVERT(CHAR(34),CONVERT(BINARY(16),@nValue,0),1),1,2,'')
			,9,0,'-'),14,0,'-'),19,0,'-'),24,0,'-') 
		AS uniqueidentifier) 

  Return  @vGuid;
END