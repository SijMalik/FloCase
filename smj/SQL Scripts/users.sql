  INSERT INTO [dbo].[AppUserProfile]
([UserName],[FullName],[AppUserRoleCode],[DepartmentCode],
[ExternalTableID],[InActive],[StartDate],[EndDate],[ContactEmail],[DirectDial],
[CreateUser],[CreateDate],[FetchAllTasks],[JobTitle],[Office])
VALUES
(
'PYH',
'Peter Holme',
'FEJ',
'PINJ',
0,
0,
GETDATE(),
Null,
'Peter.holme@blm-law.com',
'0161 236 2002',
'SMJ',
GETDATE(),
0,
'Paralegal',
'MAN'
)

