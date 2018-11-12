use Northwind 
go

--Declarando el cursor
Declare Cursor1 Cursor 
	for select * from Customers
--Abrir el cursos 
open cursor1 
--Navegar 
fetch  from cursor1 
--cerrar el cursor
close cursor1
-- Liberar de la memoria ram
deallocate cursor1 --Recordset o dataset

************************************************

/*Ejemplo 02*/
--Declaro las variables a emplear
Declare @codigo varchar(5),
@compania varchar(200),
@contacto varchar(150),
@pais varchar(100)

--Declaro cursos
declare ccustomers cursor -- LOCAL / GLOBAL
	for select Customerid, companyname,
		contactname, country from Customers

--Abrir cursos
open ccustomers 

--Navegación del cursor
fetch ccustomers into @codigo, @compania,
@contacto, @pais 
while(@@FETCH_STATUS=0)
	begin
		print @codigo + ' '+ @compania+ ' ' + 
			  @contacto + ' ' +@pais
		fetch ccustomers into @codigo, @compania,
			  @contacto, @pais
	end
close ccustomers
deallocate ccustomers

**********************************************
/*Ejemplo 03 - Actualizar datos*/
--Declaro las variables a emplear
Declare @codigo varchar(5),
@compania varchar(200),
@contacto varchar(150),
@pais varchar(100)

--Declaro cursos
declare ccustomers cursor global -- LOCAL / GLOBAL
	for select Customerid, companyname,
		contactname, country from Customers FOR UPDATE

--Abrir cursos
open ccustomers 

--Navegación del cursor
fetch ccustomers into @codigo, @compania,
@contacto, @pais 
while(@@FETCH_STATUS=0)
	begin
		UPDATE CUSTOMERS 
		SET CompanyName =@compania + '-MODIFICADO '
		WHERE CURRENT OF  ccustomers
		
		fetch ccustomers into @codigo, @compania,
			  @contacto, @pais
	end
close ccustomers
deallocate ccustomers

select CompanyName from Customers 
