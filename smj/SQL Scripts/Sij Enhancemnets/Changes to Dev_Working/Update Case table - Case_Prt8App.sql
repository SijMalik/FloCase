--Change Case_Prt8Apptmp in Case table from Bit to nVarchar

ALTER TABLE [Case] add Case_Prt8Apptmp bit
go

update [Case] 
set Case_Prt8Apptmp = Case_Prt8App 
go

alter table [case] drop column Case_Prt8App
go

alter table [case] add Case_Prt8App nvarchar(255)
go

update [Case] 
set Case_Prt8App = Case when Case_Prt8Apptmp = 1 then 'Yes' else 'No' end
go

alter table [case] drop column Case_Prt8Apptmp 
go