Create view [dbo].[UMDocumenttype]
AS
select code, description from DOCUMENT_TYPE
where code like 'UM%'