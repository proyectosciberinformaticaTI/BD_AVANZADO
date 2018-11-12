/*ver o visualizar las bases de datos del servidor*/
use master
go
select* from sys.sysdatabases
go
/* eliminar base de datos*/
drop database BDNEGOCIOS
go
drop database BDNEGOCIOS1
go
select *from sys.sysdatabases
go
/*crear una base de datos con opciones automaticas*/

create database BDNEGOCIOS
go				
/*ver la estructura de la base de datos*/
exec sp_helpdb BDNEGOCIO
/*crear base de datos con opciones personalizadas*/
create database BDNEGOCIO1
ON(
name=Negocio1_Data,
filename='c:\Data\Negocio1_Data.MDF',
size=5MB,
maxsize=25MB,
filegrowth=3MB
)
Log on
(
name=Negocio1_Log,
filename='c:\Data\Negocio1_Log.LDF',
size=10MB,
maxsize=50MB,
filegrowth=5MB
)
go

/* ver la estructura*/
exec sp_helpdb 'BDNEGOCIO1'
go

/*Modificar el tamaño y el crecimiento de datafile de la BD
a 10MB y 5MB respectivamente*/
alter database BDNEGOCIO1
modify file
(
name=Negocio1_Data,
size=10MB,
filegrowth=5MB
)
go
--ver la estructura
exec sp_helpdb 'BDNEGOCIO1'
go
/*modificar el tamaño máximo de logfile de la BD a 200MB*/
alter database BDNEGOCIO1
modify file
(
name=Negocio1_Log,
maxsize=200MB
)
go
--separar base de datos

exec sp_detach_db @dbname='BDNEGOCIO1'
go
--En el explorador de archivos, movemos los archivos datafile
--y logfile a una nueva carpeta
--Crear la base de datos, adjuntando los archivos
create database BDNEGOCIO1
On
(filename='C:\Folder\Negocio1_Data.MDF'),
(filename='C:\Folder\Negocio1_Log.LDF')
for attach
go