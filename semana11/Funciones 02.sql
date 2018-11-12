Use northwind
go
 
/*1. Creación de Funciones Escalares*/
CREATE FUNCTION Igv  (@DATE money)
RETURNS money
AS
BEGIN
Declare @igv money
Set  @Igv=@date*.18
Return(@igv)
END
 
/*2 .Revisar la funcion debe de escribirse el nombre con dos partes*/
Select unitprice, dbo.igv(unitprice) as igv from [order details]
 
/*3.borrar la funcion*/
drop function igv
 
/*4.Otro ejemplo de funcion*/
CREATE Function Comision(@valor money)
ReturnS money
as
Begin
Declare @Resultado money
if @valor>=15
    BEGIN
         SET @RESULTADO= @VALOR * 1.10
    END
ELSE
    BEGIN
         SET @RESULTADO=@VALOR
    END
RETURN @RESULTADO
END
 
/*ejecutar la funcion*/
SELECT UNITPRICE, DBO.Comision(UNITPRICE) FROM [ORDER DETAILS]
 
/* en una funcion no se pueden usar estas funciones no determiniestas
@@ERROR FORMATMESSAGE    IDENTITY     USER_NAME
@@IDENTITY   GETANSINULL NEWID    @@ERROR
@@ROWCOUNT   GETDATE PERMISSIONS @@IDENTITY
@@TRANCOUNT GetUTCDate   SESSION_USER     @@ROWCOUNT
APP_NAME     HOST_ID STATS_DATE   @@TRANCOUNT
CURRENT_TIMESTAMP         HOST_NAME     SYSTEM_USER
CURRENT_USER     IDENT_INCR   TEXTPTR
DATENAME     IDENT_SEED   TEXTVALID
*/
 
/*5.Una función con valores de tabla de varias instrucciones es una combinación
de una vista y un procedimiento almacenado.*/
 
CREATE FUNCTION LISTAPORPAIS(@PAIS  VARCHAR(50))
RETURNS @CLIENTES TABLE
(
CUSTOMERID VARCHAR(10), 
COMPANYNAME VARCHAR(50),
CONTACTNAME VARCHAR(50) ,
COUNTRY VARCHAR(50)
)
AS
BEGIN
INSERT @CLIENTES SELECT CUSTOMERID,COMPANYNAME,
			  CONTACTNAME,COUNTRY FROM CUSTOMERS
WHERE COUNTRY=@PAIS
RETURN
END
 
/*7.EJECUCION DE FUNCION*/
SELECT * FROM LISTAPORPAIS('GERMANY')
 
/*8.Ejemplo de una función con valores de tabla en línea*/
 CREATE FUNCTION DETALLEPEDIDO_FECHA
 (@INICIO DATETIME, 
 @FIN DATETIME)
RETURNS TABLE
AS
RETURN
(
SELECT O.ORDERID,O.ORDERDATE,P.PRODUCTID, P.PRODUCTNAME,(OD.UNITPRICE * OD.QUANTITY) AS TOTAL
FROM ORDERS AS O INNER JOIN [ORDER DETAILS] AS OD
ON O.ORDERID=OD.ORDERID INNER JOIN PRODUCTS AS P
ON OD.PRODUCTID=P.PRODUCTID
WHERE O.ORDERDATE BETWEEN @INICIO AND @FIN
)
 
/*Ejecutar la funcion*/
SELECT * FROM DBO.DETALLEPEDIDO_FECHA('1998-01-01','1998-31-12')