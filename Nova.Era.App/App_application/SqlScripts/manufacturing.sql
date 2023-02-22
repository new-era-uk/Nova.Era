﻿/*
version: 10.1.1040
generated: 22.02.2023 16:12:07
*/


/* SqlScripts/manufacturing.sql */

/*
MANUFACTURING user interface
11000, 110
*/
------------------------------------------------
begin
	set nocount on;
	set transaction isolation level read uncommitted;

	declare @menu ui.[MenuModule.TableType];

	insert into @menu(Id, Parent, [Order], [Name], [Url], Icon, ClassName) 
	values

		(11000,     1, 110,  N'@[Manufacturing]', N'$manufacturing',  N'wrench', null),
		-- Manufacturing
		(11001, 11000,  10, N'@[Dashboard]',      N'dashboard', N'dashboard-outline', N'border-bottom'),
		(11002, 11000,  11, N'@[Documents]',      null,  null, null),
		(11003, 11000,  12, N'@[Catalogs]',       null,  null, null),
		(11004, 11000,  40, N'@[Reports]',        N'report',    N'report', N'border-top'),
		-- documents
		(11203, 11002,  10, N'@[Specification]',  N'spec',      N'file', null),
		-- catalogs
		(11303, 11003,  10, N'@[Items]',          N'item',      N'package-outline', null);

	exec ui.[MenuModule.Merge] @menu, 11000, 11999;
end
go

