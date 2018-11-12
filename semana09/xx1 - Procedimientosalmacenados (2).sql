use Northwind  
go

------- Procedimientos almacenados --------
Create procedure P_ClientesArgentina
as
select * from Customers where
Country='Argentina'
go

Execute P_ClientesArgentina
go

*********************************************
--parametros entrada 
Create proc insertar_cliente
--parametros
@customerid varchar(5),@companyname varchar(100),
@contactname varchar(100), @country varchar(100)
as
insert into customers (customerid, companyname,
contactname, country) values 
(@customerid,@companyname,@contactname, @country)

--ejecutar procedimiento --
execute insert_cliente 'AAA16','Dankas Peru','Jose Luis Rodriguez','Perú'

select * from Customers
go
--Visualizar el proicedimiento que lo origina
sp_helptext insertar_cliente

--Borrar un procedimiento
drop proc insertar_cliente

**********************************************
--parametros Salida
create proc NumeroClientes_Pais
@pais varchar(100),@numero int output
as
select * from customers where country=@pais
set @numero=@@rowcount 
---------------------------------Ejecutar
declare @totalclientes int
exec NumeroClientes_Pais 'France',
 @totalclientes output -- with recompile 

select @totalclientes 
