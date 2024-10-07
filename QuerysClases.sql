-- Clase 1
select * from empleados
select emp.* from empleados emp

--efecto unico para esta consulta
-- "AS" es una palabra opcional para una posibilidad (igual de opcional) de poner un alias
select nombre, edad from empleados
--select emp.numemp as [Número del personal], emp.nombre, emp.edad from empleados as emp
select emp.numemp as 'Número del personal', emp.nombre, emp.edad from empleados as emp

--un * sirve para decir que quieres todas las columnas de la tabla

select nombre, oficina, contrato from empleados

select idfab, idproducto, descripcion, precio from productos

select idfab as fabricante, idproducto, descripcion from productos

--concatenación
select nombre +' '+ titulo as [Nombre con el puesto] from empleados

-- ltrim quita espacios a la izquierda, str es para poner un numero como string, rtrim quita espacios a la derecha
--la función trim es para eliminar espacios en blanco
select 'Gamaliel ' + ltrim(str(21)) + 'años'

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

--ESTO SÍ ES CORRECTO
select * from oficinas, empleados
where oficinas.oficina = empleados.oficina and oficinas.ciudad = 'alicante'
order by oficinas.ciudad
--por buenas practicas, primero ponemos la primaria y luego la foranea

--Inner Join--
select * from oficinas inner join empleados
on oficinas.oficina = empleados.oficina
where oficinas.ciudad = 'alicante'
order by oficinas.ciudad

--el producto cartesiano genera una multiplicación de filas. Inner Join no


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

--inner muestra todas las tuplas, left además muestra todos los atributos de la tabla de la izquierda y el right muestra todos los
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
--having funciona sólo sobre el grupo ya agrupado por group by

--suma de las ventas por regiones
select region from oficinas
select distinct region from oficinas --consulta simple

select region from oficinas --agrupación
group by region

select region, sum(ventas) from oficinas
group by region
having sum(ventas) >1000000 --es como el where de las agrupaciones

--todo lo que vaya en el select debe tener una función de resumen, de los contrario debe ir en el group by para ser mostrada
select oficina, region, sum(ventas) from oficinas
group by region, oficina
having sum(ventas) >1000000

--rara vez el having se utiliza sin el group by
--SÍ SE PUEDE
select sum(ventas) from oficinas
--where region = 'este'
--group by region
having sum(ventas) > 2000000

-- Kimberly esta viendo