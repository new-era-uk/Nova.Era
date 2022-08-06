-- MIGRATIONS
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'doc' and TABLE_NAME=N'Operations' and COLUMN_NAME=N'DocumentUrl')
	alter table doc.Operations add DocumentUrl nvarchar(255) null;
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'doc' and TABLE_NAME=N'Forms' and COLUMN_NAME=N'Url')
	alter table doc.Forms add [Url] nvarchar(255);
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'doc' and TABLE_NAME=N'DocDetails' and COLUMN_NAME=N'FQty')
	alter table doc.DocDetails add FQty float not null
		constraint DF_DocDetails_FQty default(0) with values;
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'cat' and TABLE_NAME=N'Countries' and COLUMN_NAME=N'Alpha3')
	alter table cat.Countries add [Alpha3] nchar(3);
go
------------------------------------------------
if exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'cat' and TABLE_NAME=N'Countries' and COLUMN_NAME=N'Aplha3')
	alter table cat.Countries drop column [Aplha3];
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'cat' and TABLE_NAME=N'Items' and COLUMN_NAME=N'Country')
	alter table cat.Items add Country nchar(3); -- references cat.Countries
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE where TABLE_SCHEMA = N'cat' and TABLE_NAME = N'Items' and CONSTRAINT_NAME = N'FK_Items_Country_Countries')
	alter table cat.Items add 
		constraint FK_Items_Country_Countries foreign key (TenantId, Country) references cat.Countries(TenantId, Code);
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'cat' and TABLE_NAME=N'Companies' and COLUMN_NAME=N'AutonumPrefix')
	alter table cat.Companies add [AutonumPrefix] nvarchar(8);
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'doc' and TABLE_NAME=N'Operations' and COLUMN_NAME=N'Autonum')
	alter table doc.Operations add Autonum bigint; -- references doc.Autonums
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE where TABLE_SCHEMA = N'doc' and TABLE_NAME = N'Operations' and CONSTRAINT_NAME = N'FK_Operations_Autonum_Autonums')
	alter table doc.Operations add 
		constraint FK_Operations_Autonum_Autonums foreign key (TenantId, Autonum) references doc.Autonums(TenantId, Id);
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'doc' and TABLE_NAME=N'Documents' and COLUMN_NAME=N'No')
	alter table doc.Documents add [No] nvarchar(64);
go
------------------------------------------------
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=N'doc' and TABLE_NAME=N'Autonums' and COLUMN_NAME=N'Uid')
	alter table doc.Autonums add [Uid] uniqueidentifier not null
		constraint DF_Autonum_Uid default(newid()) with values;
go
