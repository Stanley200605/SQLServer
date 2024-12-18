-- Clase 1
select * from empleados
select emp.* from empleados emp

--efecto unico para esta consulta
-- "AS" es una palabra opcional para una posibilidad (igual de opcional) de poner un alias
select nombre, edad from empleados
--select emp.numemp as [N�mero del personal], emp.nombre, emp.edad from empleados as emp
select emp.numemp as 'N�mero del personal', emp.nombre, emp.edad from empleados as emp

--un * sirve para decir que quieres todas las columnas de la tabla

select nombre, oficina, contrato from empleados

select idfab, idproducto, descripcion, precio from productos

select idfab as fabricante, idproducto, descripcion from productos

--concatenaci�n
select nombre +' '+ titulo as [Nombre con el puesto] from empleados

-- ltrim quita espacios a la izquierda, str es para poner un numero como string, rtrim quita espacios a la derecha
--la funci�n trim es para eliminar espacios en blanco
select 'Gamaliel ' + ltrim(str(21)) + 'a�os'

select 'la suma de los dos numeros es ' + LTRIM(str(5+6))

select '         hola    ' as s
select ltrim('         hola    ') s
select rtrim('         hola    ') s
select trim('         hola    ') s

--lista la ciudad, region y el superavit de cada oficina
select ciudad, region, ventas, objetivo, ventas-objetivo as Superavit from oficinas
where (ventas-objetivo) >0

select nombre, MONTH(contrato), YEAR(contrato) from empleados

SELECT CAST(GETDATE() AS DATE);

select ('la oficina '+ LTRIM(str( oficina)) + ' tiene ventas de $ '+ ltrim(str(ventas)) + ' pesos') from oficinas

select nombre, oficina, contrato from empleados order by oficina
select nombre, oficina, contrato from empleados order by 2


select nombre, numemp, oficina from empleados order by nombre
select nombre, numemp, oficina from empleados order by contrato
select nombre, numemp, oficina from empleados order by ventas
select 'la oficina ' + ltrim(str(oficina)) + ' tiene ventas de $ ' + ltrim(str(ventas)) + ' pesos' from oficinas


-- Clase 2
select * from oficinas
order by region desc, ciudad asc, ventas desc

select ciudad from oficinas

--con esto se puede ver cuantos elementos hay (en este caso cuantas ciudades hay)
select distinct ciudad from oficinas

select distinct ciudad from oficinas order by ciudad

--La clausa top es para solicitar un top de algo
select top 3 * from oficinas order by ventas desc

select nombre from empleados where oficina = 12
select * from empleados where oficina = 12 and edad > 30

select numemp, nombre from empleados where ventas>cuota
select * from oficinas where ventas> 500000 order by ventas
select * from oficinas where ventas = 693000.00
select * from oficinas where ventas <> 693000.00

--para calcular las oficinas q tiene una venta menos al 80% del objetivo
select oficina from oficinas where ventas < objetivo*0.8

-- Clase 3
select * from empleados where edad between 30 and 40
select * from empleados where edad >=30 and edad <= 40
select * from empleados where edad < 30 or edad > 40
select * from empleados where edad not between 30 and 40

select numemp, nombre from empleados where ventas between 100000 and 500000
select numemp, nombre from empleados where (ventas >= 100000) and (ventas <= 500000)

-- Clase 4

select * from empleados

select * from empleados where oficina = 12 or oficina = 11 or oficina = 21
select * from empleados where not (oficina = 12 or oficina = 11 or oficina = 21)

select * from empleados where oficina in (12, 11, 21)
select * from empleados where oficina not in (12, 11, 21)

select * from empleados where oficina is null
select * from empleados where oficina is not null
--is se usa solo con valores nulos

select oficina, ciudad from oficinas where dir is null
select numemp, nombre from empleados where oficina is not null

select * from empleados where nombre = 'antonio viguer'
--todos los empleados que inicial con la letra a
select * from empleados where nombre like 'a%'
--todos los empleados que su nombre inicia con el nombre 'Juan'
select * from empleados where nombre like 'juan%'
--todos los empleados que su nombre termina con el nombre 'Juan'
select * from empleados where nombre like '%antonio'
--todos los empleados que su nombre inicia y/o termina con el nombre 'Juan'
select * from empleados where nombre like '%juan%'


-- Unidad 2
-- Clase 5
use pedidos

--subconsultas
select * from oficinas
select * from empleados
--la subconsulta es una consulta dentro de una consulta principal
select * from empleados where oficina in (
select oficina from oficinas where ciudad = 'valencia')

--mostrar todos los empleados cuyo jefe sea Ana Bustamante
select * from empleados where jefe in (
select numemp from empleados where nombre = 'Ana Bustamante')

--mostrar oficinas que no tienen empleados
select * from oficinas where oficina not in (
select distinct(oficina) from empleados where oficina is not null
)


-- Clase 6
use Pedidos

--Producto cartesiano--

select * from empleados
select * from oficinas

--ESTO ES INCORRECTO 
select * from oficinas, empleados

--ESTO S� ES CORRECTO
select * from oficinas, empleados
where oficinas.oficina = empleados.oficina and oficinas.ciudad = 'alicante'
order by oficinas.ciudad
--por buenas practicas, primero ponemos la primaria y luego la foranea

--Inner Join--
select * from oficinas inner join empleados
on oficinas.oficina = empleados.oficina
where oficinas.ciudad = 'alicante'
order by oficinas.ciudad

--el producto cartesiano genera una multiplicaci�n de filas. Inner Join no


-- Clase 7
use Pedidos

select * from oficinas
select * from empleados

select * from oficinas inner join empleados
on oficinas.oficina = empleados.oficina

select * from oficinas left join empleados
on oficinas.oficina = empleados.oficina
where empleados.numemp is null

select oficinas.* from oficinas left join empleados
on oficinas.oficina = empleados.oficina
where empleados.numemp is null

select empleados.* from oficinas right join empleados
on oficinas.oficina = empleados.oficina
where oficinas.oficina is null

--inner muestra todas las tuplas, left adem�s muestra todos los atributos de la tabla de la izquierda y el right muestra todos los
--atributos de la tabla de la derecha.


--consulta de resumen--
select sum(ventas) from oficinas

select sum(objetivo) from oficinas

select sum(objetivo) - sum(ventas) from oficinas

select sum(ventas) from oficinas where region = 'este'
select sum(ventas) from oficinas where region = 'oeste'

select distinct(region) regiones from oficinas
select count(distinct(region)) as 'No de oficinas' from oficinas

select * from empleados
select count(numemp) from empleados
select count(oficina) from empleados
select count(*) from empleados --cuenta todas las filas

--AVG no considera los valores nulos pero si los valores por defecto
--No se puede anidar funciones de resumenes

--consulta con group by es una consulta agrupada
--having funciona s�lo sobre el grupo ya agrupado por group by

--suma de las ventas por regiones
select region from oficinas
select distinct region from oficinas --consulta simple

select region from oficinas --agrupaci�n
group by region

select region, sum(ventas) from oficinas
group by region
having sum(ventas) >1000000 --es como el where de las agrupaciones

--todo lo que vaya en el select debe tener una funci�n de resumen, de los contrario debe ir en el group by para ser mostrada
select oficina, region, sum(ventas) from oficinas
group by region, oficina
having sum(ventas) >1000000

--rara vez el having se utiliza sin el group by
--S� SE PUEDE
select sum(ventas) from oficinas
--where region = 'este'
--group by region
having sum(ventas) > 2000000

-- Clase conexi�n con VS 2022
select * from oficinas

INSERT INTO oficinas(oficina, ciudad, region, dir) VALUES(30, 'Misantla', 'Centro', 108);

-- Clase 11-Nov-2024
-- Transacciones
BEGIN TRAN
SET NOCOUNT ON; -- Sirve para que no mande los mensajes de las filas afectadas
BEGIN TRY -- Funciona como el Try-Catch, si llega a fallar algo lo podemos cachar
UPDATE oficinas SET ventas = 1000001 WHERE oficina = 28
INSERT INTO oficinas VALUES (202, 'Misantla', 'Centro', null, 0, 0)
COMMIT TRAN -- El commit lo compromete

END TRY
BEGIN CATCH -- Si pasa algun error se pasa al Catch
	SELECT
		-- Voy a sacar el numero del error y se llamar� ErrorNumber y sacar� el mensaje del error como ErrorMessage y lo mostrar�
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage,
		@@ERROR
		ROLLBACK TRAN
END CATCH

-- Otro ejemplo
BEGIN TRANSACTION

delete from oficinas -- Al eliminar informaci�n

select * from oficinas
INSERT INTO OFICINAS VALUES(32, 'Misantla', 'Centro', null);

rollback transaction -- Lo podemos recuperar con este comando, sin embargo, tiene que estar en el Transaction

commit

-- Clase 13/11/2024
-- Creaci�n de usuario para la base de datos Pedidos
CREATE LOGIN ADHOC  WITH PASSWORD = '123'
USE PEDIDOS
CREATE USER ADHOC FOR LOGIN ADHOC

-- Asignar permisos
GRANT SELECT, INSERT, DELETE, UPDATE
ON Pedidos
TO USUARIOPP

-- Los usuarios de cuentas deben poder recuperar los datos de los clientes
-- Y a�adir cliente nuevos a la tabla clientes.
GRANT SELECT, INSERT
ON CLIENTES
TO USUARIOCU

-- ASIGNAR TODOS LOS PRIVILEGIOS
-- GRANT ALL PRIVILEGES o tambi�n puede ser GRANT SELECT, INSERT, UPDATE, DELETE 
-- ON REPRESENTANTES
-- TO SAMUEL

-- ASIGNAR PERMISOS A TODOS
GRANT SELECT
ON Oficinas
TO PUBLIC

-- ASGINAR PERMISOS EN ALGUNAS COLUMNAS
GRANT UPDATE(COLUMNA1, COLUMNA2)
ON CLIENTES
TO USUARIOPP

-- Estructura del GRANT ON TO
-- GRANT CONSULTA(COLUMNAS)
-- ON TABLA
-- TO USUARIO


-- Clase 14/11/2024
-- Revocar permisos
-- Se quita permisos con el REVOKE, y podemos quitar solo unos cuantos permisos de los ya asignados

-- Ejemplo se conceder permisos
GRANT SELECT, INSERT, UPDATE
ON REPRESENTANTES -- Solo se puede hacer un otorgamiento de permisos en una sola tabla, para hacer en m�s tablas ser� en otro GRANT ON TO
TO USUARIOCU, USUARIOPP

-- Revocar permisos
REVOKE INSERT, UPDATE
ON REPRESENTANTES
FROM USUARIOPP
-- Termina teniendo slo permisos en SELECT

-- REVOKE ALL PRILIVEGES(INSERT, UPDATE, SELECT, DELETE)
-- ON OFICINAS
-- FROM USUARIOCU

-- TRANSMISION DE PRIVILEGIOS (GRANT OPTION)
-- ESTRUCTURA
GRANT SELECT
ON REPOESTE
TO LEON
WITH GRANT OPTION
-- CON EL WITH GRANT SE LE DA EL PRIVILEGIO DE OTORGAR PRIVILEGIOS

-- Actividad, agregar permisos a ADHOC
GRANT SELECT
ON Oficinas
TO ADHOC

-- Quitar permisos
REVOKE SELECT
ON Oficinas
TO ADHOC, borrame

-- USANDO EL WITH GRANT
GRANT SELECT
ON Oficinas
TO ADHOC
WITH GRANT OPTION

-- QUITAR WITH GRANT
REVOKE SELECT
ON Oficinas
TO ADHOC
-- Manda error porque hay que agregar el CASCADE
CASCADE

REVOKE SELECT
ON oficinas
TO ADHOC, Borrame

-- DEFINIR VISTAS
-- Tabla virtual que contiene una consulta de SQL
CREATE VIEW vista_oficina
AS 
SELECT * FROM Oficinas
-- Se pueden poner alias a las columnas desde la primera linea
-- Pero es mas recomendado hacerlo en la instrucci�n que realizar�
-- Select * AS From Oficinas


-- Se manda a llamar la vista desde un select
-- Una vista igual puede hacer SELECT INSERT, UPDATE, DELETE
-- Se respeta la integridad
-- 
select * from vista_oficina

-- Clase 20/11/2024
--Procedimientos almacenados--
create procedure consultas_oficinas
as
begin 
select * from oficinas
end

--Para ejecutarlo es de la siguiente forma--
--es recomendable hacerlo desde otro Query
execute consultas_oficinas


create procedure suma 
@num1 int, 
@num2 int
as
begin 
select @num1+@num2 as Suma
end 

--la abreviacion de execute
exec suma 3,5

--inserta laas oficinas, pone las mismas variables que contiene la tabla y despues le pione un insert into para poder agregar 
--los datos que se necesitan en dicha tabla. 
create procedure insertar_oficinas 
@oficina int,  
@ciudad varchar(15), 
@region varchar(10), 
@director int, 
@objetivo money, 
@ventas money
as
begin 
insert into oficinas values 
(@oficina, @ciudad , @region , @director, @objetivo , @ventas)
end

--ahora se puede inserttar en dicho procedimiento--
execute insertar_oficinas 33, 'Santa Clara', 'Norte', 108, 0,0

delete from oficinas where oficina=33

--Imaginense una transaccion dentro de dicho comando--

--Procedimiento de eliminar y hay que hacer el de modificar 
create procedure eliminar_oficinas
@oficina int
as
begin 
delete from oficinas where oficina=@oficina
end 

execute eliminar_oficinas 33
--esto es mas sencillo de eliminar oficinas sin necesidad de where 

-- Clase 25/11/2024
-- Triggers
--DECLARACI�N DE VARIABLE
declare @nombre varchar(15)

--ASIGNAR UNA CONSULTA COMO VALOR A LA VARIABLE FORMA 1
set @nombre= (select ciudad from oficinas where oficina=11)
--ASIGNAR UNA CONSULTA COMO VALOR A LA VARIABLE FORMA 2
select @nombre = ciudad from oficinas where oficina = 11
print @nombre

--Se ejecuta todo

--crear trigger
create trigger nombre_triger
on tabla_ejemplo
after insert
as 
begin
--aca van las instrucciones
end


-- Clase 26/11/2024
CREATE TRIGGER decrementa_stock
ON Pedidos -- Tabla donde se genera el triggers
	AFTER INSERT, UPDATE -- Significa que el trigger se ejecutar� despu� de insertar o actualizar
	AS
BEGIN
	SET NOCOUNT ON; -- Controla los mensajes de error
	-- Declaramos variables para aguardar los valores ahi
	declare @prod varchar(10)
	declare @fab varchar(3)
	declare @cant int
	declare @precio money
	declare @cod int

	-- Seleccionamos informaci�n de la tabla inserted
	select @cod = codigo, @cant = i.cant, @prod = i.producto, @fab = i.fab 
	from inserted i

	select @precio = precio from productos
	where idfab = @fab and idproducto = @prod

	-- Actualizamos
	update productos
	set existencias = existencias - @cant
	where idfab = @fab and idproducto = @prod

	update pedidos set importe = @cant * @precio
	where codigo = @cod
END
GO

CREATE TRIGGER decrementa_stock2
ON Pedidos -- Tabla donde se genera el triggers
	AFTER INSERT, UPDATE -- Significa que el trigger se ejecutar� despu� de insertar o actualizar
	AS
BEGIN
	SET NOCOUNT ON; -- Controla los mensajes de error
	-- Actualizamos
	UPDATE productos SET existencias = existencias - inserted.cant
	FROM inserted INNER JOIN Productos ON
	idfab = inserted.fab and idproducto = inserted.

END
GO