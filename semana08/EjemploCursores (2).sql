--Cursores en SQL Server 2014
use master
go
if (exists (select NAME from sys.databases where name = 'labCursores'))
drop database labCursores
go
create database labCursores
go
use labCursores
go
create table categoria (
idCategoria int primary key not null, 
nombreCategoria varchar(50) not null, 
)
go
insert into categoria values (1, 'Computadoras')
insert into categoria values (2, 'Accesorios')
go
create table productos (
codigo int primary key not null,
producto varchar(50) not null,
precio Money not null,
idCategoria int not null
foreign key (idCategoria) references categoria,
)
go
insert into productos values (1, 'Laptop', 2500.00, 1)
insert into productos values (2, 'Mouse', 50.00, 2)
insert into productos values (3, 'Parlantes', 80.00, 2)
insert into productos values (4, 'Audifonos', 20.00, 2)
go

select * from productos  
go
/*Crear un cursor que permita listar los productos*/
declare cursorP cursor
for select codigo, producto, precio from productos
open cursorP
declare @cod int, @pro varchar(50), @pre money
fetch next from cursorP into @cod, @pro, @pre
while @@fetch_status=0
begin
print 'Codigo :' + cast(@cod as varchar(10))
print 'producto :' + @pro
print 'Precio :' + cast(@pre as varchar(10))
print '-----------------------------------'
fetch next from cursorP into @cod,@pro,@pre
end
close cursorP
deallocate cursorP
 
/*Crear un cursor que permita mostrar los productos de cada categoría.*/

/*Primera Opción*/
declare cursorCP cursor
for select idCategoria,nombreCategoria from categoria
open cursorCP
declare @cat int, @nom varchar(50)
fetch next from cursorCP into @cat,@nom
while @@fetch_status=0
begin
print 'Categoria : ' + @nom
print '=================================='
declare cursorCP1 cursor
for select codigo, producto, precio from productos where idCategoria=@cat
open cursorCP1
declare @codpro int,@prod varchar(50) ,@prec money
fetch next from cursorCP1 into @codpro, @prod, @prec
while @@fetch_status=0
begin
print 'Codigo : ' + cast(@codpro as varchar(10))
print 'Producto : ' + @prod
print 'Precio : ' + cast(@prec as varchar(10))
fetch next from cursorCP1 into @codpro, @prod, @prec
end
close cursorCP1
deallocate cursorCP1
fetch next from cursorCP into @cat,@nom
end
close cursorCP
deallocate cursorCP
go
 
/*Segunda Opción*/
declare cursorCate cursor for select nombreCategoria, idCategoria from categoria
declare cursorProd cursor for select codigo, producto, precio, idCategoria from productos
declare @codcat int, @categoria varchar(50)
declare @codprod int, @producto varchar(50), @precio decimal, @cate int
open cursorCate
fetch next from cursorCate into @categoria, @codcat
while @@FETCH_STATUS = 0
begin
print '=================================='
print 'Categoria=' + upper(@categoria)
print '=================================='
open cursorProd
fetch next from cursorProd into @codprod, @producto, @precio, @cate
while @@FETCH_STATUS = 0
begin
if @cate = @codcat
begin
print 'Codigo=' + cast(@codprod as varchar(5))
print 'Producto=' + @producto
print 'Precio=' + cast(@precio as varchar(10))
end
else
set @cate = 0
fetch next from cursorProd into @codprod, @producto, @precio, @cate
end
close cursorProd
fetch next from cursorCate into @categoria, @codcat
end
close cursorCate
deallocate cursorCate
deallocate cursorProd
go
 
/*Crear un cursor que permita mostrar los libros publicados por autores peruanos*/
use labCursores
go
create table titulos (
codigoTitulo int primary key not null,
Titulo varchar(20) not null
)
create table autores (
codigoAutor int primary key not null, 
nombres varchar(20) not null, 
apellidos varchar(40) not null, 
origen varchar(10) not null
)
create table titulos_autores (
codigoTitulo int foreign key (codigoTitulo) references titulos not null, 
codigoAutor int foreign key (codigoAutor) references autores not null
)
go
--Registros de prueba
insert into titulos values (1, 'Prog. PHP')
insert into titulos values (2, 'Prog. Visual Studio')
insert into titulos values (3, 'Prog. Java')
insert into titulos values (4, 'BD My SQL')
insert into titulos values (5, 'BD SQL Server')
insert into titulos values (6, 'BD Oracle')
go
insert into autores values (1, 'Riachard', 'Ortiz', 'Perú')
insert into autores values (2, 'Darwin', 'Durand', 'Perú')
insert into autores values (3, 'Nilton', 'Tataje', 'Perú')
go
insert into titulos_autores values (1, 1)
insert into titulos_autores values (2, 2)
insert into titulos_autores values (3, 3)
insert into titulos_autores values (4, 1)
insert into titulos_autores values (5, 2)
insert into titulos_autores values (6, 3)
go
 
--Ahora creamos el cursor y ejecumatos
SET NOCOUNT ON
DECLARE
@codigo varchar(11), 
@nombres varchar(20), 
@apellidos varchar(40), 
@mensaje varchar(80), 
@titulo varchar(80) 
PRINT '*** Reporte de Libros y Autores ***'
DECLARE authors_cursor CURSOR FOR
SELECT codigoAutor, nombres, apellidos 
FROM autores 
WHERE origen = 'Perú'
ORDER BY codigoAutor 
OPEN authors_cursor 
FETCH NEXT FROM authors_cursor 
INTO @codigo, @nombres, @apellidos 
WHILE @@FETCH_STATUS = 0 
BEGIN
PRINT ''
SELECT
@mensaje = '* Libros del Autor: ' + 
@nombres + ' ' + @apellidos
PRINT @mensaje
DECLARE titles_cursor CURSOR FOR
SELECT  ti.Titulo
FROM autores  as au INNER JOIN
titulos_autores as ta ON au.codigoAutor = ta.codigoAutor INNER JOIN
titulos AS ti ON ta.codigoTitulo = ti.codigoTitulo
WHERE au.codigoAutor = @codigo
OPEN titles_cursor
FETCH NEXT FROM titles_cursor INTO @titulo
IF @@FETCH_STATUS <> 0 
PRINT 'No hay Libros'
WHILE @@FETCH_STATUS = 0
BEGIN
SELECT @mensaje = ' ' + @titulo
PRINT @mensaje
FETCH NEXT FROM titles_cursor INTO @titulo
END
CLOSE titles_cursor
DEALLOCATE titles_cursor
FETCH NEXT FROM authors_cursor 
INTO @codigo, @nombres, @apellidos
END
CLOSE authors_cursor 
DEALLOCATE authors_cursor