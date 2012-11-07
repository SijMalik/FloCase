select distinct username from AppUser 
where LEN(username)=(select max(LEN(username)) as maxchar from AppUser)