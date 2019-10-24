
CREATE  FUNCTION [dbo].[barry_JustTheDate]
(@d datetime) --returns just the date with no time
RETURNS datetime AS 
BEGIN 
return cast(convert(varchar,@d,110) as datetime)
END