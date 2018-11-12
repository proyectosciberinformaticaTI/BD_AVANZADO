/*Ejemplos de funciones*/
CREATE FUNCTION EnMayusculas
(
@Nombre Varchar(50),
@Apellido Varchar(50)
)
RETURNS Varchar(100)
AS
--Declarar Variables
BEGIN
	RETURN (UPPER(@Apellido) + ', ' + UPPER(@Nombre))
END

--Ejecutar
Print dbo.EnMayusculas('Geynen','Montenegro') 
/*******************************************************************************************/
Create function NombreDia(@Dia int)
Returns Varchar(10)
AS
Begin
	Declare @Var Varchar(10)
	Select @Var= Case @Dia
		When 1 Then 'Lunes'
		When 2 Then 'Martes'
		When 3 Then 'Miercoles'
		When 4 Then 'Jueves'
		When 5 Then 'Viernes'
		When 6 Then 'Sabado'
		When 7 Then 'Domingo'
	End
Return @Var
End
 
--Ejecutar
Print dbo.NombreDia(2)


/**********************************************************************************/
/*SINTAXIS DE UNA FUNCION*/
create function NOMBRE
 (@PARAMETRO TIPO=VALORPORDEFECTO)
  returns TIPO
  begin
   INSTRUCCIONES
   return VALOR
  end;

/**********************************************************************************/
create Function Suma(@N1 int, @N2 int)
RETURNS Int
AS
BEGIN
 Return (@N1 + @N2)
END
 
--Ejecutar
Print dbo.Suma(5,8)

/*Creamos una simple función denominada "f_promedio" que recibe 
2 valores y retorna el promedio:*/
create function f_promedio
 (@valor1 decimal(4,2),
  @valor2 decimal(4,2)
 )
 returns decimal (6,2)
 as
 begin 
   declare @resultado decimal(6,2)
   set @resultado=(@valor1+@valor2)/2
   return @resultado
 end;

 PRINT dbo.f_promedio(5.5,8.5);

/**********************************************************************************/
/*crear un programa que me retorne la edad actual ingresando la fecha de nacimiento*/
CREATE Function Edad(@Fec_Nac DateTime, @Fec_Actual Datetime = '10/06/2016')
Returns int
AS
Begin
 Return Datediff(yy,@Fec_Nac,@Fec_Actual)
End
 
Print dbo.Edad('07/10/1987',default)

/********************************************************************************************/
/*Diseñe un programa que calcule la suma de las cifras de un número 
sin importar cuantas cifras tenga el número.*/
Create Function SumaDigitos(@N int)
Returns int
AS
 Begin 
  Declare @Size int,@Dig  varchar,@Suma int,@i int
  Set @Size=Len(Ltrim(Rtrim(Cast(@N as Varchar))))
  Set @Suma=0
  Set @Dig=0
  Set @i=1
  While(@i<=@Size)
  Begin
   Set @Dig=Substring(Cast(@N as Varchar),@i,@i+1)
   Set @Suma=@Suma + @Dig
   Set @i=@i + 1
  End
  Return @Suma
 End
Go
--Ejecutar
Print dbo.SumaDigitos(232350022)

/********************************************************************************************/
/*Diseñe un programa que reciba un número natural y retorne la suma de sus 
dígitos impares.*/
create Function SumaDigImpares
(@N int)
Returns int
AS
 Begin 
  Declare @Size int,@Dig  varchar,@Suma int,@i int
  Set @Size=Len(Ltrim(Rtrim(Cast(@N as Varchar))))
  Set @Suma=0
  Set @Dig=0
  Set @i=1
  While(@i<=@Size)
  Begin
   Set @Dig=Substring(Cast(@N as Varchar),@i,@i+1)
   If (@Dig%2=1)
   Begin 
    Set @Suma=@Suma + @Dig
   End
   Set @i=@i + 1
  End
  Return @Suma
 End
Go
--Ejecutar
Print dbo.SumaDigImpares(232357)
 
/********************************************************************************************/
/*Dado un número natural de cuatro cifras diseñe una funcion que permita obtener
el revés del número. Así, si se lee el número 2385 el programa deberá imprimir
5832.*/
 
Create Function InvertirNum
(@N int)
Returns int
AS
 Begin 
  Declare @Size int,@Dig  varchar,@Invertido int,@i int
  Set @Size=Len(Ltrim(Rtrim(Cast(@N as Varchar))))
  Set @Invertido=0
  Set @Dig=0
  Set @i=1
  While(@i<=@Size)   Begin    Set @Dig=Substring(Cast(@N as Varchar),@i,@i+1)    
  Set @Invertido= @Dig + Cast(Ltrim(Rtrim(@Invertido)) as Varchar)    Set @i=@i + 1   
  End   
  Return SubString(Cast(@Invertido as Varchar),1,@Size)  
  End
  
  Go 
  --Ejecutar--
   Print dbo.InvertirNum(2342357) 
  --******************************************************************************************** 
  Create Function Invertir ( @N1 int ) 
  Returns Int 
  AS  
  BEGIN  Declare @Inv int  
  Set @Inv=0  While (@N1>0)
  Begin
   Set @Inv=@Inv*10 + @N1%10 --Invierte residuos obtenidos
   Set @N1 = @N1/10
  End
 Return @Inv
 END
--Ejecutar
Print dbo.Invertir(122155)
 
/********************************************************************************************/
Create Function InvertirPalabra
(@N Varchar(20))
Returns Varchar(19)
AS
 Begin 
  Declare @Size int,@Dig Char(1),@Invertido Varchar(19),@i int
  Set @Size=Len(Ltrim(Rtrim(@N)))
  Set @Invertido=''
  Set @Dig=''
  Set @i=1
  While(@i<=@Size)
  Begin
   Set @Dig=Substring(@N,@i,@i+1)
   Set @Invertido= @Dig + Ltrim(Rtrim(@Invertido))
   Set @i=@i + 1
  End
  Return @Invertido
 End
Go
--Ejecutar
Print dbo.InvertirPalabra('Base')
 
/********************************************************************************************/
/*Mínimo Común Multiplo de 2 números por descomposición de factores*/
Create Function MCM
(@n1 int,
 @n2 int
)
returns int
as
 begin
 declare @c int
 declare @val int
 set @val = 1
 while (@n1 + @n2 <> 2)
  begin
  set @c = 2
  while (@c <=@n1 or @c<=@n2)
   begin
   If (@n1%@c=0 or @n2%@c=0)
    begin
        set @val = @val * @c
    if (@n1%@c=0)
     set @n1 = @n1/@c
           if (@n2%@c=0)
            set @n2 = @n2/@c
    end
       set @c = @c + 1 
    end
  end
 return @val
 end
--Ejecutar
print dbo.MCM(4,10)
 
/********************************************************************************************/
/*Máximo Común Divisor de 2 números por descomposición de factores*/
Create Function MCD
(@n1 int,
 @n2 int
)
returns int
as
 begin
 declare @c int
 declare @val int
 set @val = 1
 set @c = 2
 while (@c <=@n1 and @c<=@n2)
  begin
  If (@n1%@c=0 and @n2%@c=0)
   begin
       set @val = @val * @c
   If (@n1%@c=0)
    set @n1 = @n1/@c
          If (@n2%@c=0)
           set @n2 = @n2/@c
   end
      set @c = @c + 1 
   end
 return @val
 end
--Ejecutar
print dbo.MCD(6,10)
 
/********************************************************************************************
Máximo Común Divisor de 2 números por restas sucecivas*/
Create Function MCD
(@n1 int,
 @n2 int
)
Returns int
As
 Begin
 While (@n1<>@n2)
  Begin
  If @n1>@n2
   Set @n1=@n1-@n2
  Else
   Set @n2=@n2-@n1
  End
 Return @n1
 End
--Ejecutar
print dbo.MCD(25,10)

/********************************************************************************************/
/*Maximo Común Divisor de 2 números por el metodo de Euclides*/
Create Function MCD
(
@n1 int,
@n2 int
)
Returns int
As
 Begin
 Declare @Resto int
 If @n2=0 Set @n1=0
 While (@n2>0)
  Begin
  Set @Resto=@n1%@n2
  Set @n1=@n2
  Set @n2=@Resto
  End
 Return @n1
 End
--Ejecutar
print dbo.MCD(25,10)

/********************************************************************************************/
/*Leer un número entero en base 10, y conviertalo a una base menor que 10*/
Create Function Convertir
(
@N1 int,
@Base int
)
Returns Int
AS
 BEGIN
 Declare @R int,@C Varchar(11)
 Set @C=''
 While (@N1>0)
  Begin
   Set @R = @N1%@Base
   Set @N1 = @N1/@Base
   Set @C=Cast(@R as Char(1)) + Ltrim(Rtrim(@C))
  End
 Return Cast(@C as Int)
 END
 
--Ejecutar
Print dbo.Convertir(10,2)
 
/********************************************************************************************/
/*Leer un número entero en base 10, y conviertalo a una base menor que 10*/
Create Function Convertir
(
@N1 int,
@Base int
)
Returns Int
AS
 BEGIN
 Declare @Inv int,@Convert int
 Set @Inv=0
 Set @Convert=0
 While (@N1>0)
  Begin
   Set @Inv=@Inv*10 + @N1%@Base
   Set @N1 = @N1/@Base
  End
 While (@Inv>0)
  Begin
   Set @Convert=@Convert*10 + @Inv%10 --Invierte residuos obtenidos
   Set @Inv = @Inv/10
  End
 Return @Convert
 END
 
--Ejecutar
Print dbo.Convertir(194,5)
 
--********************************************************************************************
/*Leer un número entero en una base menor que 10, y conviertalo a base 10*/
 
Create Function Abase10
(
@N1 int,
@Base int
)
Returns Int
AS
 BEGIN
 Declare @i int,@Inv int
 Set @Inv=0
 Set @i=0
 While (@N1>0)
  Begin
   Set @Inv=@Inv + (@N1%10)*Power(@Base,@i)
   Set @N1 = @N1/10
   Set @i=@i+1
  End
 Return @Inv
 END
--Ejecutar
Print dbo.Abase10(1234,5)

/********************************************************************************************/
/*Factorizar un número ingresado por teclado.Por ejemplo: 18=2x3x3, 8=2x2x2.*/
 Create function Factorizar
(
@N int
)
Returns Varchar(50)
AS
 BEGIN
 Declare @i int,@F Varchar(50)
 Set @i=2
 Set @F=''
 While (@i<=@N)
  Begin
  If (@N%@i=0) 
   Begin
    Set @F=@F + ' x ' + Cast(@i as Varchar(10))
    Set @N=@N/@i
   End
  Else
   Begin
   Set @i=@i+1
   End
  End
 Return Substring(@F,3,Len(@F))
 END
 
--Ejecutar
Print 'La factorización de 18 es: ' + dbo.Factorizar(18)
 
--*******************************************************************************************************
/*Escribir una función que permita reducir una fracción a su minima expresión. Por ejemplo: 28/64 = 7/16 */
Alter function Fraccion
(
@N int,--Numerador
@D int --Denominador
)
Returns Varchar(50)
AS
 BEGIN
 Declare @i int,@F Varchar(50)
 Set @i=2
 Set @F=''
 While (@i<=@N and @i<=@D)   Begin   If (@N%@i=0 and @D%@i=0)     Begin     Set @N=@N/@i     Set @D=@D/@i    End   Else    Begin    Set @i=@i+1    End   End  Set @F=Cast(@N as Varchar(10)) + '/' + Cast(@D as Varchar(10))  Return @F  END --Ejecutar Print 'La nueva fracción es: ' + dbo.Fraccion(28,64) --******************************************************************************************************* Hallar la raiz cuadrada de un número por el metodo de Newton. Alter Function Raiz ( @N Float ) Returns Float AS  BEGIN  Declare @Lado1 Float, @Lado0 Float  Set @Lado0=@N/2  Hacer:  Begin   Set @Lado1=@N/@Lado0   Set @Lado0=(@Lado0+@Lado1)/2  End  If (Abs(@Lado1-@Lado0)>0.00001) Goto Hacer
 Return @Lado0
 END
 
--Ejecutar
Print 'La Raiz cuadrada es: ' + cast(dbo.Raiz(28) as Varchar(10))
 
--*******************************************************************************************************
Create Function ConvertHexadecimal
(
@N1 Varchar(30),
@Base int
)
Returns Varchar(30)
AS
 BEGIN
 Declare @N Varchar(30) 
 Declare @Inv int,@Convert int,@H varChar(2),@Size int,@i int,@D Char(1),@C Varchar(30)
 Set @Inv=0
 Set @Convert=0
 Set @Size=Len(Ltrim(Rtrim(@N1)))
 Set @H=''
 Set @D=''
 Set @N=''
 Set @i=1
 While (@i<=@Size)   Begin   Set @D=Substring(Ltrim(Rtrim(@N1)),@i,@Size)   Select @H=   Case @D    When 'A' then '10'    When 'B' then '11'    When 'C' then '12'    When 'D' then '13'    When 'E' then '14'    When 'F' then '15'    Else @D   End   Set @N=Ltrim(Rtrim(@N))+@H   Set @i=@i+1   End  While (Cast(@N as int)>0)
  Begin
   Set @Inv=@Inv*10 + Cast(@N as int)%@Base
   Set @N = Cast(@N as int)/@Base
  End
 While (@Inv>0)
  Begin
   Set @Convert=@Convert*10 + @Inv%10 --Invierte residuos obtenidos
   Set @Inv = @Inv/10
  End
 Set @C=@Convert
 If (Substring(Ltrim(Rtrim(@N1)),@Size,@Size)='A')
  Begin
  Set @C= Cast(Ltrim(Rtrim(@convert)) as Varchar(30)) + '0'
  End
 Return @C
 END
 
--Ejecutar
Print dbo.ConvertHexadecimal('12A',2)