
ALTER PROCEDURE [dbo].[AppTaskDocumentCommentHistory_Fetch]
	-- Add the parameters for the stored procedure here
	@CaseID int = 0,
	@AppTaskDocumentID int = 0,
	@UserName nvarchar(255) = null
AS
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select CONVERT(VARCHAR(20), AppTaskDocumentVersion.Created , 100) + ' : '+ AppTaskDocumentVersion_ReviewComments as AppTaskDocumentVersion_ReviewComments from dbo.AppTaskDocumentVersion with (nolock)
	where AppTaskDocumentVersion_Approved <> 'Yes'
	and AppTaskDocumentID = @AppTaskDocumentID
	and AppTaskDocumentVersion_ReviewComments <> ''
	order by AppTaskDocumentVersion.AppTaskDocumentVersionID
	desc
	
	
END
