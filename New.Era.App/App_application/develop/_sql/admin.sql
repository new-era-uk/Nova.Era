﻿/*
admin
*/
------------------------------------------------
if not exists(select * from a2security.Users where Id <> 0)
begin
	set nocount on;
	set transaction isolation level read committed;

	insert into a2security.Users(Id, UserName, SecurityStamp, PasswordHash, PersonName, EmailConfirmed)
	values (99, N'admin@admin.com', N'c9bb451a-9d2b-4b26-9499-2d7d408ce54e', N'AJcfzvC7DCiRrfPmbVoigR7J8fHoK/xdtcWwahHDYJfKSKSWwX5pu9ChtxmE7Rs4Vg==',
		N'System administrator', 1);
	insert into a2security.UserGroups(UserId, GroupId) values (99, 77), (99, 1); /*predefined values*/
end
go
------------------------------------------------
if not exists(select * from a2security.Companies)
begin
	set nocount on;
	set transaction isolation level read committed;

	declare @rtable table(id bigint);
	begin tran;
	insert into a2security.Companies ([Name]) 
	output inserted.Id into @rtable(id)
	values (N'Моє підприємство');
	
	declare @comp bigint;
	select @comp = id from @rtable;

	insert into a2security.UserCompanies([User], Company, [Enabled])
	values (99, @comp, 1);

	update a2security.Users set Company = @comp where Id=99;
	commit tran;
end
go