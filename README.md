### Consulta n°1

Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

```mysql
SELECT O.id AS 'Código oficina', C.nombre AS ciudad
	FROM oficina AS O
	INNER JOIN ciudad AS C ON O.id_ciudad = C.id;
```

<pre>+-----------------+-------------------+
| Código oficina  | ciudad            |
+-----------------+-------------------+
|               1 | Floridablanca     |
|              10 | Chicago           |
|              17 | Chicago           |
|               3 | Indianápolis      |
|              24 | Aix-en-Provence   |
|               4 | Neuchâtel         |
|              11 | Neuchâtel         |
|              18 | Neuchâtel         |
|               5 | Dubai             |
|              12 | Dubai             |
|              19 | Dubai             |
|               6 | Ciudad de México  |
|              20 | Ciudad de México  |
|              26 | Ciudad de México  |
|              27 | Recife            |
|              21 | Maceió            |
|              28 | Mendoza           |
|               8 | Iloilo City       |
|               9 | Edimburgo         |
|               7 | Almería           |
|              30 | Almería           |
|              14 | Córdoba           |
|              15 | Málaga            |
|              23 | Málaga            |
|               2 | Huesca            |
|              13 | Teruel            |
|              22 | Teruel            |
|              25 | Teruel            |
|              16 | Zaragoza          |
|              29 | Zaragoza          |
+-----------------+-------------------+</pre>



### Consulta n°2

Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

```mysql
SELECT P.abreviatura AS pais, C.nombre AS ciudad, CONCAT('+', P.prefijo, ' ', O.nro_telefono) AS telefono
    FROM oficina AS O
    INNER JOIN ciudad AS C ON O.id_ciudad = C.id
    INNER JOIN region AS R ON C.id_region = R.id
    INNER JOIN pais AS P ON R.id_pais = P.id
    WHERE P.abreviatura = 'ES';
```

<pre>+------+----------+--------------+
| pais | ciudad   | telefono     |
+------+----------+--------------+
| ES   | Almería  | +31 76543210 |
| ES   | Almería  | +31 55432100 |
| ES   | Córdoba  | +31 6543210  |
| ES   | Málaga   | +31 5432106  |
| ES   | Málaga   | +31 57423456 |
| ES   | Huesca   | +31 87654321 |
| ES   | Teruel   | +31 10654321 |
| ES   | Teruel   | +31 432106   |
| ES   | Teruel   | +31 54321987 |
| ES   | Zaragoza | +31 4321065  |
| ES   | Zaragoza | +31 57432456 |
+------+----------+--------------+
</pre>



### Consulta n°3

Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

```mysql
SELECT CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, '')) AS nombres, CONCAT(E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS apellidos, CONCAT(CE.nombre_usuario, '@', CE.organizacion_dominio, '.', CE.tipo_dominio) AS email
	FROM empleado AS E
	INNER JOIN contacto AS C ON E.id_contacto = C.id
	LEFT JOIN email AS CE ON C.id_email = CE.id
	WHERE E.codigo_jefe = 7;
```

<pre>+-------------------+---------------------+--------------------------------+
| nombres           | apellidos           | email                          |
+-------------------+---------------------+--------------------------------+
| Andrea Carolina   | Morales Castillo    | NULL                           |
| José Francisco    | Vargas Torres       | jose.vargas121@gmail.com       |
| Carolina Isabel   | Ramírez Chacón      | carolina.ramirez132@gmail.com  |
| Jennifer Stefania | Robles Gutiérrez    | NULL                           |
| Paola Valentina   | García Velasquez    | paolagarcia264@outlook.com     |
| William David     | Chacón García       | william.chacon187@zohomail.com |
| Sofía Camila      | Gutiérrez Castillo  | sofiagutierrez220@ymail.com    |
+-------------------+---------------------+--------------------------------+</pre>



### Consulta n°4

Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

```mysql
SELECT P.nombre AS puesto, CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, '')) AS nombres, CONCAT(E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS apellidos, CONCAT(CE.nombre_usuario, '@', CE.organizacion_dominio, '.', CE.tipo_dominio) AS email
	FROM empleado AS E
	INNER JOIN puesto AS P ON E.id_puesto = P.id
	INNER JOIN contacto AS C ON E.id_contacto = C.id
	INNER JOIN email AS CE ON C.id_email = CE.id
	WHERE codigo_jefe IS NULL;
```

<pre>+---------------------+--------------+---------------+-----------------------------+
| puesto              | nombres      | apellidos     | email                       |
+---------------------+--------------+---------------+-----------------------------+
| Jefe de Jardinería  | Laura Teresa | Gómez Pérez   | lauragomez66@protonmail.com |
+---------------------+--------------+---------------+-----------------------------+
</pre>



### Consulta n°5

Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

```mysql
SELECT CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, '')) AS nombres, CONCAT(E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS apellidos, P.nombre AS puesto
	FROM empleado AS E
	INNER JOIN puesto AS P ON E.id_puesto = P.id
	WHERE E.id_puesto <> 6;
```

<pre>+--------------------+-------------------+---------------------------------------+
| nombres            | apellidos         | puesto                                |
+--------------------+-------------------+---------------------------------------+
| Laura Teresa       | Gómez Pérez       | Jefe de Jardinería                    |
| Juan Carlos        | Rojas López       | Jardinero                             |
| Pedro Antonio      | López Martínez    | Arbolista                             |
| Diego              | Álvarez           | Especialista en Césped                |
| Monica             | Flores González   | Especialista en Control de Plagas     |
| Carlos Steven      | Hernández Navas   | Técnico de Mantenimiento de Equipos   |
| Mónica Patricia    | Flores Gutiérrez  | Hortícola                             |
| Carolina Lizeth    | Torres Ramírez    | Constructor de Estructuras de Jardín  |
| Andrea Carolina    | Morales Castillo  | Contratista de Jardinería             |
| Carolina Isabel    | Ramírez Chacón    | Jefe de Jardinería                    |
| Juan Andrés        | Rojas Aguirre     | Arbolista                             |
| Andrés Sebastián   | Castillo Castro   | Especialista en Control de Plagas     |
| William David      | Chacón García     | Técnico de Mantenimiento de Equipos   |
| Miguel Alejandro   | Castro González   | Constructor de Estructuras de Jardín  |
| Juan Sebastián     | Rojas Torres      | Jardinero                             |
| Marcela Valentina  | González Chacón   | Arbolista                             |
| Ricardo David      | Velasquez Aguirre | Especialista en Césped                |
+--------------------+-------------------+---------------------------------------+
</pre>



### Consulta n°6

Devuelve un listado con el nombre de los todos los clientes españoles.

~~~mysql
SELECT CONCAT(Cli.primer_nombre, ' ', IF(Cli.segundo_nombre IS NOT NULL, Cli.segundo_nombre, '')) AS nombres, CONCAT(Cli.primer_apellido, ' ', IF(Cli.segundo_apellido IS NOT NULL, Cli.segundo_apellido, '')) AS apellidos
	FROM cliente AS Cli
	INNER JOIN ciudad AS C ON Cli.id_ciudad = C.id
	INNER JOIN region AS R ON C.id_region = R.id
	INNER JOIN pais AS P ON R.id_pais = P.id
	WHERE P.abreviatura = 'ES';
~~~

<pre>+------------------+------------------+
| nombres          | apellidos        |
+------------------+------------------+
| Ánderson Steven  | Álvarado Correa  |
| Ana              | Álvarez          |
| Yannis Milet     | Jimenez Martinez |
| Alexander        | Rodriguez        |
+------------------+------------------+
</pre>



### Consulta n°7

Devuelve un listado con los distintos estados por los que puede pasar un pedido.

~~~mysql
SELECT nombre AS estado
	FROM estado;
~~~

<pre>+--------------+
| estado       |
+--------------+
| Pendiente    |
| Enviado      |
| Entregado    |
| No entregado |
+--------------+
</pre>



### Consulta n°8

Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos.

### Consulta n°8.1

Resuelva la consulta utilizando la función YEAR de MySQL:

~~~mysql
SELECT id_cliente, MAX(fecha_pago) AS fechaPago
	FROM pago
	WHERE YEAR(fecha_pago) = 2008
	GROUP BY id_cliente;
~~~

<pre>+------------+------------+
| id_cliente | fechaPago  |
+------------+------------+
|          1 | 2008-05-12 |
|          3 | 2008-03-04 |
|          5 | 2008-11-26 |
|          9 | 2008-01-10 |
|         12 | 2008-05-02 |
|         16 | 2008-02-17 |
|         20 | 2008-12-21 |
+------------+------------+
</pre>



### Consulta n°8.2

Resuelva la consulta utilizando la función DATE_FORMAT de MySQL:

~~~mysql
SELECT id_cliente, MAX(fecha_pago) AS fechaPago
	FROM pago
	WHERE DATE_FORMAT(fecha_pago, "%Y") = 2008
	GROUP BY id_cliente;
~~~

<pre>+------------+------------+
| id_cliente | fechaPago  |
+------------+------------+
|          1 | 2008-05-12 |
|          3 | 2008-03-04 |
|          5 | 2008-11-26 |
|          9 | 2008-01-10 |
|         12 | 2008-05-02 |
|         16 | 2008-02-17 |
|         20 | 2008-12-21 |
+------------+------------+</pre>



### Consulta n°8.3

Resuelva la consulta sin utilizar ninguna de las funciones anteriores:

~~~mysql
SELECT id_cliente, MAX(fecha_pago) AS fechaPago
	FROM pago
	WHERE fecha_pago LIKE "2008%"
	GROUP BY id_cliente;
~~~

<pre>+------------+------------+
| id_cliente | fechaPago  |
+------------+------------+
|          1 | 2008-05-12 |
|          3 | 2008-03-04 |
|          5 | 2008-11-26 |
|          9 | 2008-01-10 |
|         12 | 2008-05-02 |
|         16 | 2008-02-17 |
|         20 | 2008-12-21 |
+------------+------------+
</pre>



### Consulta n°9

Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.

~~~mysql
SELECT id AS 'Código pedido', id_cliente, fecha_entrega_esperada, fecha_entrega
	FROM pedido
	WHERE DATEDIFF(fecha_entrega_esperada, fecha_entrega) < 0;
~~~

<pre>+----------------+------------+------------------------+---------------+
| Código pedido  | id_cliente | fecha_entrega_esperada | fecha_entrega |
+----------------+------------+------------------------+---------------+
|              1 |          1 | 1999-02-03             | 1999-03-24    |
|              8 |          8 | 2006-09-10             | 2006-10-01    |
|             13 |         13 | 2011-02-24             | 2011-03-06    |
|             18 |         18 | 2016-08-09             | 2016-08-11    |
|             23 |          5 | 2022-01-05             | 2022-01-16    |
|             27 |         13 | 1998-05-19             | 1998-05-20    |
|             28 |         15 | 2005-05-30             | 2005-06-21    |
|             36 |         20 | 2004-02-20             | 2004-02-28    |
|             44 |         16 | 2008-09-25             | 2008-10-24    |
|             49 |          6 | 1999-03-18             | 1999-03-29    |
|             55 |          7 | 2012-08-05             | 2012-09-04    |
|             57 |         11 | 2012-10-07             | 2012-11-06    |
|             59 |         15 | 2010-01-05             | 2010-01-08    |
|             60 |         17 | 2020-01-10             | 2020-02-09    |
|             64 |          5 | 2007-05-14             | 2007-06-13    |
|             67 |          1 | 2007-09-07             | 2007-09-16    |
|             71 |          9 | 2018-01-14             | 2018-01-20    |
|             72 |         11 | 2018-01-27             | 2018-02-21    |
|             78 |          3 | 2014-08-17             | 2014-08-27    |
|             84 |          5 | 2019-01-31             | 2019-02-02    |
|             90 |         17 | 1998-08-01             | 1998-08-08    |
|            100 |         15 | 2006-12-04             | 2006-12-23    |
+----------------+------------+------------------------+---------------+
</pre>



### Consulta n°10

Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

### Consulta n°10.1

Resuelve la consulta utilizando la función ADDDATE de MySQL:

~~~mysql
SELECT id AS 'Código pedido', id_cliente AS 'Código cliente', fecha_entrega_esperada, fecha_entrega
	FROM pedido
	WHERE ADDDATE(fecha_entrega, INTERVAL 2 DAY) <= fecha_entrega_esperada
	LIMIT 15;  -- Total filas: 70
~~~

<pre>+----------------+-----------------+------------------------+---------------+
| Código pedido  | Código cliente  | fecha_entrega_esperada | fecha_entrega |
+----------------+-----------------+------------------------+---------------+
|              2 |               2 | 2000-05-04             | 2000-04-25    |
|              3 |               3 | 2001-06-05             | 2001-05-26    |
|              4 |               4 | 2002-07-06             | 2002-06-27    |
|              5 |               5 | 2003-08-07             | 2003-07-28    |
|              6 |               6 | 2004-09-08             | 2004-08-29    |
|              7 |               7 | 2005-10-09             | 2005-09-30    |
|              9 |               9 | 2007-12-11             | 2007-11-02    |
|             10 |              10 | 2009-01-12             | 2008-12-03    |
|             11 |              11 | 2009-02-13             | 2009-01-04    |
|             12 |              12 | 2010-03-14             | 2010-02-05    |
|             14 |              14 | 2012-05-16             | 2012-04-07    |
|             15 |              15 | 2013-06-17             | 2013-05-08    |
|             16 |              16 | 2014-07-18             | 2014-06-09    |
|             17 |              17 | 2015-08-19             | 2015-07-10    |
|             19 |               9 | 2017-10-21             | 2017-09-12    |
+----------------+-----------------+------------------------+---------------+
</pre>



### Consulta n°10.2

Resuelve la consulta utilizando la función DATEDIFF de MySQL:

~~~mysql
SELECT id AS 'Código pedido', id_cliente AS 'código cliente', fecha_entrega_esperada, fecha_entrega
	FROM pedido
	WHERE DATEDIFF(fecha_entrega, fecha_entrega_esperada) <= -2
	LIMIT 15;  -- Total filas: 70
~~~

<pre>+----------------+-----------------+------------------------+---------------+
| Código pedido  | código cliente  | fecha_entrega_esperada | fecha_entrega |
+----------------+-----------------+------------------------+---------------+
|              2 |               2 | 2000-05-04             | 2000-04-25    |
|              3 |               3 | 2001-06-05             | 2001-05-26    |
|              4 |               4 | 2002-07-06             | 2002-06-27    |
|              5 |               5 | 2003-08-07             | 2003-07-28    |
|              6 |               6 | 2004-09-08             | 2004-08-29    |
|              7 |               7 | 2005-10-09             | 2005-09-30    |
|              9 |               9 | 2007-12-11             | 2007-11-02    |
|             10 |              10 | 2009-01-12             | 2008-12-03    |
|             11 |              11 | 2009-02-13             | 2009-01-04    |
|             12 |              12 | 2010-03-14             | 2010-02-05    |
|             14 |              14 | 2012-05-16             | 2012-04-07    |
|             15 |              15 | 2013-06-17             | 2013-05-08    |
|             16 |              16 | 2014-07-18             | 2014-06-09    |
|             17 |              17 | 2015-08-19             | 2015-07-10    |
|             19 |               9 | 2017-10-21             | 2017-09-12    |
+----------------+-----------------+------------------------+---------------+
</pre>



### Consulta n°10.3

¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?

~~~mysql
SELECT id AS 'Código pedido', id_cliente AS 'código cliente', fecha_entrega_esperada, fecha_entrega
	FROM pedido
	WHERE fecha_entrega - fecha_entrega_esperada < -2
	LIMIT 15; -- Total filas: 72
~~~

<pre>+----------------+-----------------+------------------------+---------------+
| Código pedido  | código cliente  | fecha_entrega_esperada | fecha_entrega |
+----------------+-----------------+------------------------+---------------+
|              2 |               2 | 2000-05-04             | 2000-04-25    |
|              3 |               3 | 2001-06-05             | 2001-05-26    |
|              4 |               4 | 2002-07-06             | 2002-06-27    |
|              5 |               5 | 2003-08-07             | 2003-07-28    |
|              6 |               6 | 2004-09-08             | 2004-08-29    |
|              7 |               7 | 2005-10-09             | 2005-09-30    |
|              9 |               9 | 2007-12-11             | 2007-11-02    |
|             10 |              10 | 2009-01-12             | 2008-12-03    |
|             11 |              11 | 2009-02-13             | 2009-01-04    |
|             12 |              12 | 2010-03-14             | 2010-02-05    |
|             14 |              14 | 2012-05-16             | 2012-04-07    |
|             15 |              15 | 2013-06-17             | 2013-05-08    |
|             16 |              16 | 2014-07-18             | 2014-06-09    |
|             17 |              17 | 2015-08-19             | 2015-07-10    |
|             19 |               9 | 2017-10-21             | 2017-09-12    |
+----------------+-----------------+------------------------+---------------+
</pre>



### Consulta n°11

Devuelve un listado de todos los pedidos que fueron rechazados en 2012.

~~~mysql
SELECT P.id, P.id_cliente, P.fecha_pedido, PE.fecha_estado
	FROM pedido_estado AS PE
	INNER JOIN pedido AS P ON PE.id_pedido = P.id
	WHERE PE.id_estado = 4 and YEAR(fecha_estado) = 2012;
~~~

<pre>+----+------------+--------------+---------------------+
| id | id_cliente | fecha_pedido | fecha_estado        |
+----+------------+--------------+---------------------+
| 51 |         10 | 2012-03-29   | 2012-05-31 00:00:00 |
| 53 |          3 | 2012-05-31   | 2012-07-02 00:00:00 |
| 56 |          9 | 2012-08-03   | 2012-09-04 00:00:00 |
| 59 |         15 | 2009-11-06   | 2012-09-04 00:00:00 |
| 60 |         17 | 2009-12-07   | 2012-10-05 00:00:00 |
| 61 |         19 | 2009-01-08   | 2012-11-06 00:00:00 |
+----+------------+--------------+---------------------+
</pre>



### Consulta n°12

Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.

~~~mysql
SELECT P.id, P.id_cliente, P.fecha_pedido, PE.fecha_estado
	FROM pedido_estado AS PE
	INNER JOIN pedido AS P ON PE.id_pedido = P.id
	WHERE PE.id_estado = 3 AND DATE_FORMAT(fecha_estado, "%m") = 01;
~~~

<pre>+----+------------+--------------+---------------------+
| id | id_cliente | fecha_pedido | fecha_estado        |
+----+------------+--------------+---------------------+
| 23 |          5 | 2021-11-24   | 2021-01-16 00:00:00 |
| 47 |          2 | 2008-11-25   | 2009-01-27 00:00:00 |
| 63 |          3 | 2007-03-10   | 2010-01-08 00:00:00 |
+----+------------+--------------+---------------------+
</pre>


### Consulta n°13

Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

~~~mysql
SELECT P.id_transaccion AS "Código pago", P.fecha_pago, FP.nombre AS "Forma pago"
	FROM pago AS P
	INNER JOIN forma_pago AS FP ON P.id_forma_pago = FP.id
	WHERE YEAR(P.fecha_pago) = 2008 and FP.nombre = 'Paypal'
	ORDER BY P.fecha_pago DESC;
~~~

<pre>+------------------------------------+------------+------------+
| Código pago                        | fecha_pago | Forma pago |
+------------------------------------+------------+------------+
| V3W4-X5Y6-Z7A8-B9C0-D1E2-F3G4-H5I6 | 2008-04-15 | Paypal     |
| A1B2-C3D4-E5F6-G7H8-I9J0-K1L2-M3N4 | 2008-03-04 | Paypal     |
| S1T2-U3V4-W5X6-Y7Z8-Z9A0-B1C2-D3E4 | 2008-01-10 | Paypal     |
+------------------------------------+------------+------------+
</pre>



### Consulta n°14

Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.

~~~mysql
SELECT DISTINCT(P.id_forma_pago), FP.nombre AS "Forma pago"
	FROM pago AS P
	INNER JOIN forma_pago AS FP ON P.id_forma_pago = FP.id;
~~~

<pre>+---------------+-------------------------------+
| id_forma_pago | Forma pago                    |
+---------------+-------------------------------+
|             1 | Efectivo                      |
|             2 | Tarjeta de débito / crédito   |
|             3 | Paypal                        |
+---------------+-------------------------------+
</pre>



### Consulta n°15

Devuelve un listado con todos los productos que pertenecen a la gama Decoración y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.

~~~mysql
SELECT P.nombre AS 'Producto', G.nombre_gama AS 'Gama', P.cantidad_en_stock, P.precio_venta
	FROM producto AS P
	INNER JOIN gama AS G ON P.id_gama = G.id
	WHERE G.nombre_gama = 'Decoración' AND P.cantidad_en_stock > 100;
~~~

<pre>+----------------------------------+-------------+-------------------+--------------+
| Producto                         | Gama        | cantidad_en_stock | precio_venta |
+----------------------------------+-------------+-------------------+--------------+
| Césped artificial                | Decoración  |               150 |        39.99 |
| Cabaña de jardín                 | Decoración  |               102 |       249.99 |
| Casa de pájaros decorativa       | Decoración  |               127 |        19.99 |
| Piedras decorativas para jardín  | Decoración  |               101 |        15.99 |
+----------------------------------+-------------+-------------------+--------------+
</pre>



### Consulta n°16

Devuelve un listado con todos los clientes que sean de la ciudad de Almería y cuyo representante de ventas tenga el código de empleado 11 o 16.

~~~mysql
SELECT CONCAT(Cli.primer_nombre, ' ', IF(Cli.segundo_nombre IS NOT NULL, Cli.segundo_nombre, '')) AS 'Nombre cliente', CONCAT(Cli.primer_apellido, ' ', IF(Cli.segundo_apellido IS NOT NULL, Cli.segundo_apellido, '')) AS 'Apellido cliente', CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, '')) AS 'Nombre empleado', CONCAT(E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS 'Apellido empleado', C.nombre AS 'Ciudad'
	FROM cliente AS Cli
	INNER JOIN ciudad AS C ON Cli.id_ciudad = C.id
	INNER JOIN empleado AS E ON Cli.id_empleado_rep_ventas = E.id
	WHERE C.nombre = 'Almería' AND E.id IN(11, 16);
~~~

<pre>+------------------+------------------+-----------------+-------------------+----------+
| Nombre cliente   | Apellido cliente | Nombre empleado | Apellido empleado | Ciudad   |
+------------------+------------------+-----------------+-------------------+----------+
| Miguel Alejandro | Rojas Torres     | José Francisco  | Vargas Torres     | Almería  |
| Ana              | Álvarez          | Paola Valentina | García Velasquez  | Almería  |
| Ánderson Steven  | Álvarado Correa  | Paola Valentina | García Velasquez  | Almería  |
+------------------+------------------+-----------------+-------------------+----------+
</pre>



## Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

### Consulta n°17

Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

~~~mysql
SELECT CONCAT(C.primer_nombre, ' ', IF(C.segundo_nombre IS NOT NULL, C.segundo_nombre, '')) AS "Nombre cliente", CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, ''), ' ', E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS "Nombre representante"
	FROM cliente AS C
	INNER JOIN empleado AS E ON C.id_empleado_rep_ventas = E.id;
~~~

<pre>+--------------------+-------------------------------------+
| Nombre cliente     | Nombre representante                |
+--------------------+-------------------------------------+
| Maria Jose         | Laura Marcela Rodríguez             |
| Pedro Luis         | José Francisco Vargas Torres        |
| Ana Maria          | Jennifer Stefania Robles Gutiérrez  |
| David Alejandro    | Natalia Mariana Aguirre Rojas       |
| Laura Beatriz      | Sofía Camila Gutiérrez Castillo     |
| Carlos Eduardo     | Ricardo David Velasquez Aguirre     |
| Mónica Patricia    | Ricardo David Velasquez Aguirre     |
| Diego Alberto      | Laura Marcela Rodríguez             |
| Andrea Carolina    | José Francisco Vargas Torres        |
| José Francisco     | Jennifer Stefania Robles Gutiérrez  |
| Carolina Isabel    | Natalia Mariana Aguirre Rojas       |
| Steven Andrés      | Sofía Camila Gutiérrez Castillo     |
| Jennifer Stefania  | Sofía Camila Gutiérrez Castillo     |
| Andrés Sebastián   | Laura Marcela Rodríguez             |
| Valentina Mariana  | Laura Marcela Rodríguez             |
| Isabella Sofia     | José Francisco Vargas Torres        |
| Mariana Camila     | Jennifer Stefania Robles Gutiérrez  |
| Alejandro Miguel   | Natalia Mariana Aguirre Rojas       |
| Camila Sofía       | Sofía Camila Gutiérrez Castillo     |
| Miguel Alejandro   | José Francisco Vargas Torres        |
| Ana                | Paola Valentina García Velasquez    |
| Yannis Milet       | José Francisco Vargas Torres        |
| Alexander          | Natalia Mariana Aguirre Rojas       |
| Ánderson Steven    | Paola Valentina García Velasquez    |
+--------------------+-------------------------------------+
</pre>



### Consulta n°18

Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

~~~mysql
SELECT MAX(codigo_pago) AS "Código pago", nombre_cliente, nombre_empleado, MAX(pago) AS "Pago"
	FROM (
        SELECT 	P.id_transaccion AS "codigo_pago", 
        		CONCAT(C.primer_nombre, ' ', C.primer_apellido) AS "nombre_cliente", 
        		CONCAT(E.primer_nombre, ' ', E.primer_apellido) AS "nombre_empleado",
        		FP.nombre AS "Pago"
        FROM pago AS P
        INNER JOIN cliente AS C ON P.id_cliente = C.id
        INNER JOIN empleado AS E ON C.id_empleado_rep_ventas = E.id
        INNER JOIN forma_pago AS FP ON P.id_forma_pago = FP.id
    ) AS FPCE  # FPCE = Filtrado por Pago, Cliente y Empleado
    GROUP BY nombre_cliente, nombre_empleado;
~~~

<pre>+------------------------------------+------------------+-------------------+-------------------------------+
| Código pago                        | nombre_cliente   | nombre_empleado   | Pago                          |
+------------------------------------+------------------+-------------------+-------------------------------+
| N3O4-P5Q6-R7S8-T9U0-V1W2-X3Y4-Z5A6 | Valentina Torres | Laura Rodríguez   | Tarjeta de débito / crédito   |
| Z1A2-B3C4-D5E6-F7G8-H9I0-J1K2-L3M4 | Andrés Castillo  | Laura Rodríguez   | Tarjeta de débito / crédito   |
| P9Q0-R1S2-T3U4-V5W6-X7Y8-Z9A0-B1C2 | Diego Alvarez    | Laura Rodríguez   | Tarjeta de débito / crédito   |
| Z5A6-B7C8-D9E0-F1G2-H3I4-J5K6-L7M8 | Maria Rodriguez  | Laura Rodríguez   | Paypal                        |
| X3Y4-Z5A6-B7C8-D9E0-F1G2-H3I4-J5K6 | Miguel Rojas     | José Vargas       | Tarjeta de débito / crédito   |
| P5Q6-R7S8-T9U0-V1W2-X3Y4-Z5A6-B7C8 | Isabella Chacon  | José Vargas       | Paypal                        |
| S1T2-U3V4-W5X6-Y7Z8-Z9A0-B1C2-D3E4 | Andrea Morales   | José Vargas       | Tarjeta de débito / crédito   |
| N4M5-O6P7-Q8R9-S1T2-U3V4-W5X6-Y7Z8 | Pedro Lopez      | José Vargas       | Tarjeta de débito / crédito   |
| R7S8-T9U0-V1W2-X3Y4-Z5A6-B7C8-D9E0 | Mariana Aguirre  | Jennifer Robles   | Tarjeta de débito / crédito   |
| U3V4-W5X6-Y7Z8-Z9A0-B1C2-D3E4-F5G6 | José Vargas      | Jennifer Robles   | Paypal                        |
| D9E0-F1G2-H3I4-J5K6-L7M8-N9O0-P1Q2 | Ana Garcia       | Jennifer Robles   | Tarjeta de débito / crédito   |
| T9U0-V1W2-X3Y4-Z5A6-B7C8-D9E0-F1G2 | Alejandro Castro | Natalia Aguirre   | Paypal                        |
| W5X6-Y7Z8-Z9A0-B1C2-D3E4-F5G6-H7I8 | Carolina Ramirez | Natalia Aguirre   | Tarjeta de débito / crédito   |
| F1G2-H3I4-J5K6-L7M8-N9O0-P1Q2-R3S4 | David Sanchez    | Natalia Aguirre   | Paypal                        |
| V1W2-X3Y4-Z5A6-B7C8-D9E0-F1G2-H3I4 | Camila Gutierrez | Sofía Gutiérrez   | Tarjeta de débito / crédito   |
| Z9A0-B1C2-D3E4-F5G6-H7I8-J9K0-L1M2 | Jennifer Robles  | Sofía Gutiérrez   | Paypal                        |
| Y7Z8-Z9A0-B1C2-D3E4-F5G6-H7I8-J9K0 | Steven Hernandez | Sofía Gutiérrez   | Tarjeta de débito / crédito   |
| H3I4-J5K6-L7M8-N9O0-P1Q2-R3S4-T5U6 | Laura Gomez      | Sofía Gutiérrez   | Tarjeta de débito / crédito   |
| M5N6-O7P8-Q9R0-S1T2-U3V4-W5X6-Y7Z8 | Mónica Flores    | Ricardo Velasquez | Paypal                        |
| J5K6-L7M8-N9O0-P1Q2-R3S4-T5U6-V7W8 | Carlos Rojas     | Ricardo Velasquez | Tarjeta de débito / crédito   |
+------------------------------------+------------------+-------------------+-------------------------------+
</pre>



### Consulta n°19

Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

~~~mysql
SELECT FCP.codigo_pago, FCP.nombre_cliente, CONCAT(E.primer_nombre, ' ', E.primer_apellido) AS "nombre_representante"
	FROM(
    	SELECT 	P.id_transaccion AS "codigo_pago",
        		CONCAT(C.primer_nombre, ' ', C.primer_apellido) AS "nombre_cliente",
        		C.id_empleado_rep_ventas
        FROM pago AS P
        RIGHT JOIN cliente AS C ON P.id_cliente = C.id
    ) AS FCP  # FCP = Filtrado por Código del Pago
    INNER JOIN empleado AS E ON FCP.id_empleado_rep_ventas = E.id
    WHERE FCP.codigo_pago IS NULL;
~~~

<pre>+-------------+---------------------+----------------------+
| codigo_pago | nombre_cliente      | nombre_representante |
+-------------+---------------------+----------------------+
| NULL        | Yannis Jimenez      | José Vargas          |
| NULL        | Ánderson Álvarado   | Paola García         |
| NULL        | Ana Álvarez         | Paola García         |
| NULL        | Alexander Rodriguez | Natalia Aguirre      |
+-------------+---------------------+----------------------+
</pre>



### Consulta n°20

Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

~~~mysql
SELECT FCRAP.codigoPago AS "Código pago", FCRAP.nombre_cliente AS "Nombre cliente", FCRAP.nombre_empleado AS "Nombre empleado", FCRAP.forma_pago AS "Forma pago", FCRAP.id_oficina AS "Código oficina", C.nombre AS "Ciudad"
	FROM (
    	SELECT 	MAX(codigo_pago) AS "codigoPago", 
        		nombre_cliente, nombre_empleado, MAX(pago) AS "forma_pago", id_oficina
        FROM (
            SELECT 	P.id_transaccion AS "codigo_pago", 
                    CONCAT(C.primer_nombre, ' ', C.primer_apellido) AS "nombre_cliente", 
                    CONCAT(E.primer_nombre, ' ', E.primer_apellido) AS "nombre_empleado",
                    FP.nombre AS "Pago",
            		E.id_oficina
            FROM pago AS P
            INNER JOIN cliente AS C ON P.id_cliente = C.id
            INNER JOIN empleado AS E ON C.id_empleado_rep_ventas = E.id
            INNER JOIN forma_pago AS FP ON P.id_forma_pago = FP.id
        ) AS FPCE  # FPCE = Filtrado por Pago, Cliente y Empleado
        GROUP BY nombre_cliente, nombre_empleado, id_oficina
    ) AS FCRAP  # FCRAP = Filtrado por Cliente y Representante Asociados a un Pago
    INNER JOIN oficina AS O ON FCRAP.id_oficina = O.id
    INNER JOIN ciudad AS C ON O.id_ciudad = C.id;
~~~

<pre>+------------------------------------+------------------+-------------------+-------------------------------+-----------------+-------------------+
| Código pago                        | Nombre cliente   | Nombre empleado   | Forma pago                    | Código oficina  | Ciudad            |
+------------------------------------+------------------+-------------------+-------------------------------+-----------------+-------------------+
| X3Y4-Z5A6-B7C8-D9E0-F1G2-H3I4-J5K6 | Miguel Rojas     | José Vargas       | Tarjeta de débito / crédito   |              11 | Neuchâtel         |
| P5Q6-R7S8-T9U0-V1W2-X3Y4-Z5A6-B7C8 | Isabella Chacon  | José Vargas       | Paypal                        |              11 | Neuchâtel         |
| S1T2-U3V4-W5X6-Y7Z8-Z9A0-B1C2-D3E4 | Andrea Morales   | José Vargas       | Tarjeta de débito / crédito   |              11 | Neuchâtel         |
| N4M5-O6P7-Q8R9-S1T2-U3V4-W5X6-Y7Z8 | Pedro Lopez      | José Vargas       | Tarjeta de débito / crédito   |              11 | Neuchâtel         |
| T9U0-V1W2-X3Y4-Z5A6-B7C8-D9E0-F1G2 | Alejandro Castro | Natalia Aguirre   | Paypal                        |              18 | Neuchâtel         |
| W5X6-Y7Z8-Z9A0-B1C2-D3E4-F5G6-H7I8 | Carolina Ramirez | Natalia Aguirre   | Tarjeta de débito / crédito   |              18 | Neuchâtel         |
| F1G2-H3I4-J5K6-L7M8-N9O0-P1Q2-R3S4 | David Sanchez    | Natalia Aguirre   | Paypal                        |              18 | Neuchâtel         |
| N3O4-P5Q6-R7S8-T9U0-V1W2-X3Y4-Z5A6 | Valentina Torres | Laura Rodríguez   | Tarjeta de débito / crédito   |               6 | Ciudad de México  |
| Z1A2-B3C4-D5E6-F7G8-H9I0-J1K2-L3M4 | Andrés Castillo  | Laura Rodríguez   | Tarjeta de débito / crédito   |               6 | Ciudad de México  |
| P9Q0-R1S2-T3U4-V5W6-X7Y8-Z9A0-B1C2 | Diego Alvarez    | Laura Rodríguez   | Tarjeta de débito / crédito   |               6 | Ciudad de México  |
| Z5A6-B7C8-D9E0-F1G2-H3I4-J5K6-L7M8 | Maria Rodriguez  | Laura Rodríguez   | Paypal                        |               6 | Ciudad de México  |
| V1W2-X3Y4-Z5A6-B7C8-D9E0-F1G2-H3I4 | Camila Gutierrez | Sofía Gutiérrez   | Tarjeta de débito / crédito   |              20 | Ciudad de México  |
| Z9A0-B1C2-D3E4-F5G6-H7I8-J9K0-L1M2 | Jennifer Robles  | Sofía Gutiérrez   | Paypal                        |              20 | Ciudad de México  |
| Y7Z8-Z9A0-B1C2-D3E4-F5G6-H7I8-J9K0 | Steven Hernandez | Sofía Gutiérrez   | Tarjeta de débito / crédito   |              20 | Ciudad de México  |
| H3I4-J5K6-L7M8-N9O0-P1Q2-R3S4-T5U6 | Laura Gomez      | Sofía Gutiérrez   | Tarjeta de débito / crédito   |              20 | Ciudad de México  |
| R7S8-T9U0-V1W2-X3Y4-Z5A6-B7C8-D9E0 | Mariana Aguirre  | Jennifer Robles   | Tarjeta de débito / crédito   |              14 | Córdoba           |
| U3V4-W5X6-Y7Z8-Z9A0-B1C2-D3E4-F5G6 | José Vargas      | Jennifer Robles   | Paypal                        |              14 | Córdoba           |
| D9E0-F1G2-H3I4-J5K6-L7M8-N9O0-P1Q2 | Ana Garcia       | Jennifer Robles   | Tarjeta de débito / crédito   |              14 | Córdoba           |
| M5N6-O7P8-Q9R0-S1T2-U3V4-W5X6-Y7Z8 | Mónica Flores    | Ricardo Velasquez | Paypal                        |              23 | Málaga            |
| J5K6-L7M8-N9O0-P1Q2-R3S4-T5U6-V7W8 | Carlos Rojas     | Ricardo Velasquez | Tarjeta de débito / crédito   |              23 | Málaga            |
+------------------------------------+------------------+-------------------+-------------------------------+-----------------+-------------------+
</pre>



### Consulta n°21

Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

~~~mysql
SELECT FCP.codigo_pago AS "Código pago", FCP.nombre_cliente AS "Nombre cliente", CONCAT(E.primer_nombre, ' ', E.primer_apellido) AS "Nombre representante", C.nombre AS "Ciudad"
	FROM(
    	SELECT 	P.id_transaccion AS "codigo_pago",
        		CONCAT(C.primer_nombre, ' ', C.primer_apellido) AS "nombre_cliente",
        		C.id_empleado_rep_ventas
        FROM pago AS P
        RIGHT JOIN cliente AS C ON P.id_cliente = C.id
    ) AS FCP  # FCP = Filtrado por Código del Pago
    INNER JOIN empleado AS E ON FCP.id_empleado_rep_ventas = E.id
    INNER JOIN oficina AS O ON E.id_oficina = O.id
    INNER JOIN ciudad AS C ON O.id_ciudad = C.id
    WHERE FCP.codigo_pago IS NULL;
~~~

<pre>+--------------+---------------------+----------------------+------------+
| Código pago  | Nombre cliente      | Nombre representante | Ciudad     |
+--------------+---------------------+----------------------+------------+
| NULL         | Ana Álvarez         | Paola García         | Zaragoza   |
| NULL         | Yannis Jimenez      | José Vargas          | Neuchâtel  |
| NULL         | Alexander Rodriguez | Natalia Aguirre      | Neuchâtel  |
| NULL         | Ánderson Álvarado   | Paola García         | Zaragoza   |
+--------------+---------------------+----------------------+------------+
</pre>



### Consulta n°22

Lista la dirección de las oficinas que tengan clientes en Almería.

~~~mysql
SELECT O.id, CONCAT(O.linea_direccion1, ' ', IF(O.linea_direccion2 IS NOT NULL, O.linea_direccion2, '')) AS "direccion"
	FROM cliente AS Cli
	JOIN empleado AS E ON Cli.id_empleado_rep_ventas = E.id
	JOIN oficina AS O ON E.id_oficina = O.id
	JOIN ciudad AS C ON Cli.id_ciudad = C.id
	WHERE C.nombre = 'Almería';
~~~

<pre>+----+---------------------------------------------+
| id | direccion                                   |
+----+---------------------------------------------+
| 11 | Carrera 30 # 210 - 220 Barrio Los Mártires  |
| 16 | Calle 40 # 310 - 320 Barrio Antonio Nariño  |
| 16 | Calle 40 # 310 - 320 Barrio Antonio Nariño  |
+----+---------------------------------------------+
</pre>



### Consulta n°23

Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

~~~mysql
SELECT CONCAT(Cli.primer_nombre, ' ', Cli.primer_apellido) AS "Nombre cliente", 
       CONCAT(E.primer_nombre, ' ', E.primer_apellido) AS "Nombre empleado",
       O.id AS "Código oficina", C.nombre AS "Ciudad"
	FROM cliente AS Cli
	LEFT JOIN empleado AS E ON Cli.id_empleado_rep_ventas = E.id
	LEFT JOIN oficina AS O ON E.id_oficina = O.id
	INNER JOIN ciudad AS C ON O.id_ciudad = C.id;
~~~

<pre>+---------------------+-------------------+-----------------+-------------------+
| Nombre cliente      | Nombre empleado   | Código oficina  | Ciudad            |
+---------------------+-------------------+-----------------+-------------------+
| Maria Rodriguez     | Laura Rodríguez   |               6 | Ciudad de México  |
| Pedro Lopez         | José Vargas       |              11 | Neuchâtel         |
| Ana Garcia          | Jennifer Robles   |              14 | Córdoba           |
| David Sanchez       | Natalia Aguirre   |              18 | Neuchâtel         |
| Laura Gomez         | Sofía Gutiérrez   |              20 | Ciudad de México  |
| Carlos Rojas        | Ricardo Velasquez |              23 | Málaga            |
| Mónica Flores       | Ricardo Velasquez |              23 | Málaga            |
| Diego Alvarez       | Laura Rodríguez   |               6 | Ciudad de México  |
| Andrea Morales      | José Vargas       |              11 | Neuchâtel         |
| José Vargas         | Jennifer Robles   |              14 | Córdoba           |
| Carolina Ramirez    | Natalia Aguirre   |              18 | Neuchâtel         |
| Steven Hernandez    | Sofía Gutiérrez   |              20 | Ciudad de México  |
| Jennifer Robles     | Sofía Gutiérrez   |              20 | Ciudad de México  |
| Andrés Castillo     | Laura Rodríguez   |               6 | Ciudad de México  |
| Valentina Torres    | Laura Rodríguez   |               6 | Ciudad de México  |
| Isabella Chacon     | José Vargas       |              11 | Neuchâtel         |
| Mariana Aguirre     | Jennifer Robles   |              14 | Córdoba           |
| Alejandro Castro    | Natalia Aguirre   |              18 | Neuchâtel         |
| Camila Gutierrez    | Sofía Gutiérrez   |              20 | Ciudad de México  |
| Miguel Rojas        | José Vargas       |              11 | Neuchâtel         |
| Ana Álvarez         | Paola García      |              16 | Zaragoza          |
| Yannis Jimenez      | José Vargas       |              11 | Neuchâtel         |
| Alexander Rodriguez | Natalia Aguirre   |              18 | Neuchâtel         |
| Ánderson Álvarado   | Paola García      |              16 | Zaragoza          |
+---------------------+-------------------+-----------------+-------------------+
</pre>



### Consulta n°24

Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

~~~mysql
SELECT 	E.nombre_empleado AS "Nombre empleado",
		CONCAT(J.primer_nombre, ' ', J.primer_apellido) AS "Nombre jefe"
	FROM (
    	SELECT CONCAT(primer_nombre, ' ', primer_apellido) AS "nombre_empleado", codigo_jefe
        FROM empleado
    ) AS E
    LEFT JOIN empleado AS J ON E.codigo_jefe = J.id;
~~~

<pre>+-------------------+-------------------+
| Nombre empleado   | Nombre jefe       |
+-------------------+-------------------+
| Laura Gómez       | NULL              |
| Juan Rojas        | Laura Gómez       |
| Pedro López       | Juan Rojas        |
| Diego Álvarez     | Juan Rojas        |
| Monica Flores     | Juan Rojas        |
| Laura Rodríguez   | Diego Álvarez     |
| Carlos Hernández  | Juan Rojas        |
| Mónica Flores     | Diego Álvarez     |
| Carolina Torres   | Juan Rojas        |
| Andrea Morales    | Carlos Hernández  |
| José Vargas       | Carlos Hernández  |
| Carolina Ramírez  | Carlos Hernández  |
| Juan Rojas        | Diego Álvarez     |
| Jennifer Robles   | Carlos Hernández  |
| Andrés Castillo   | Juan Rojas        |
| Paola García      | Carlos Hernández  |
| William Chacón    | Carlos Hernández  |
| Natalia Aguirre   | William Chacón    |
| Miguel Castro     | William Chacón    |
| Sofía Gutiérrez   | Carlos Hernández  |
| Juan Rojas        | Diego Álvarez     |
| Marcela González  | Juan Rojas        |
| Ricardo Velasquez | William Chacón    |
+-------------------+-------------------+
</pre>



### Consulta n°25

Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

~~~mysql
SELECT 	EJ.nombre_empleado AS "Nombre empleado", EJ.nombre_jefe AS "Nombre jefe",
		CONCAT(JJ.primer_nombre, ' ', JJ.primer_apellido) AS "Mombre jefe del jefe"
	FROM (
    	SELECT 	E.nombre_empleado, J.codigo_jefe,
				CONCAT(J.primer_nombre, ' ', J.primer_apellido) AS "nombre_jefe"
        FROM (
            SELECT CONCAT(primer_nombre, ' ', primer_apellido) AS "nombre_empleado", 
            codigo_jefe
            FROM empleado
        ) AS E
        LEFT JOIN empleado AS J ON E.codigo_jefe = J.id
    ) AS EJ  # EJ = Empleado y Jefe
    LEFT JOIN empleado AS JJ ON EJ.codigo_jefe = JJ.id;
~~~

<pre>+-------------------+-------------------+----------------------+
| Nombre empleado   | Nombre jefe       | Mombre jefe del jefe |
+-------------------+-------------------+----------------------+
| Laura Gómez       | NULL              | NULL                 |
| Juan Rojas        | Laura Gómez       | NULL                 |
| Pedro López       | Juan Rojas        | Laura Gómez          |
| Diego Álvarez     | Juan Rojas        | Laura Gómez          |
| Monica Flores     | Juan Rojas        | Laura Gómez          |
| Laura Rodríguez   | Diego Álvarez     | Juan Rojas           |
| Carlos Hernández  | Juan Rojas        | Laura Gómez          |
| Mónica Flores     | Diego Álvarez     | Juan Rojas           |
| Carolina Torres   | Juan Rojas        | Laura Gómez          |
| Andrea Morales    | Carlos Hernández  | Juan Rojas           |
| José Vargas       | Carlos Hernández  | Juan Rojas           |
| Carolina Ramírez  | Carlos Hernández  | Juan Rojas           |
| Juan Rojas        | Diego Álvarez     | Juan Rojas           |
| Jennifer Robles   | Carlos Hernández  | Juan Rojas           |
| Andrés Castillo   | Juan Rojas        | Laura Gómez          |
| Paola García      | Carlos Hernández  | Juan Rojas           |
| William Chacón    | Carlos Hernández  | Juan Rojas           |
| Natalia Aguirre   | William Chacón    | Carlos Hernández     |
| Miguel Castro     | William Chacón    | Carlos Hernández     |
| Sofía Gutiérrez   | Carlos Hernández  | Juan Rojas           |
| Juan Rojas        | Diego Álvarez     | Juan Rojas           |
| Marcela González  | Juan Rojas        | Laura Gómez          |
| Ricardo Velasquez | William Chacón    | Carlos Hernández     |
+-------------------+-------------------+----------------------+
</pre>



### Consulta n°26

Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

~~~mysql
SELECT CONCAT(C.primer_nombre, ' ', IF(C.segundo_nombre IS NOT NULL, C.segundo_nombre, ''), ' ', C.primer_apellido, ' ', IF(C.segundo_apellido IS NOT NULL, C.segundo_apellido, '')) AS "Nombre cliente", DATEDIFF(FFPA.fecha_entrega, FFPA.fecha_entrega_esperada) AS "Días diferencia"
	FROM (
    	SELECT *
        FROM pedido
        WHERE fecha_entrega > fecha_entrega_esperada
    ) AS FFPA  # FFPA = Filtrado por Fecha de Pedido Atrasado
   	INNER JOIN cliente AS C ON FFPA.id_cliente = C.id;
~~~

<pre>+------------------------------------+------------------+
| Nombre cliente                     | Días diferencia  |
+------------------------------------+------------------+
| Maria Jose Rodriguez Perez         |               49 |
| Maria Jose Rodriguez Perez         |                9 |
| Ana Maria Garcia Fernandez         |               10 |
| Laura Beatriz Gomez Rodriquez      |               11 |
| Laura Beatriz Gomez Rodriquez      |               30 |
| Laura Beatriz Gomez Rodriquez      |                2 |
| Carlos Eduardo Rojas Navas         |               11 |
| Mónica Patricia Flores Gutierrez   |               30 |
| Diego Alberto Alvarez Ramirez      |               21 |
| Andrea Carolina Morales Castillo   |                6 |
| Carolina Isabel Ramirez Chacon     |               30 |
| Carolina Isabel Ramirez Chacon     |               25 |
| Jennifer Stefania Robles Gutierrez |               10 |
| Jennifer Stefania Robles Gutierrez |                1 |
| Valentina Mariana Torres Chacon    |               22 |
| Valentina Mariana Torres Chacon    |                3 |
| Valentina Mariana Torres Chacon    |               19 |
| Isabella Sofia Chacon Aguirre      |               29 |
| Mariana Camila Aguirre Gutierrez   |               30 |
| Mariana Camila Aguirre Gutierrez   |                7 |
| Alejandro Miguel Castro Ramirez    |                2 |
| Miguel Alejandro Rojas Torres      |                8 |
+------------------------------------+------------------+
</pre>



### Consulta n°27

Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

~~~mysql
SELECT Pr.id AS "codigo_producto", P.id AS "codigo_pedido"
	FROM detalle_pedido AS DP
	RIGHT JOIN pedido AS P ON DP.id_pedido = P.id
	LEFT JOIN producto AS Pr ON DP.id_producto = Pr.id;

SELECT G.nombre_gama, COUNT(FCPC.codigo_pedido) AS "Cant pedidos clientes"
	FROM (
    	SELECT Pr.id AS "codigo_producto", P.id AS "codigo_pedido"
        FROM detalle_pedido AS DP
        RIGHT JOIN pedido AS P ON DP.id_pedido = P.id
        LEFT JOIN producto AS Pr ON DP.id_producto = Pr.id
    ) AS FCPC  # FCPC = Filtrado por la Cantidad de Pedidos por Cliente
    INNER JOIN gama AS G ON FCPC.codigo_producto = G.id
    GROUP BY G.nombre_gama;
    
~~~

<pre>+---------------------+-----------------------+
| nombre_gama         | Cant pedidos clientes |
+---------------------+-----------------------+
| Hortalizas          |                    12 |
| Frutales            |                    11 |
| Flores              |                    11 |
| Hierbas aromáticas  |                    10 |
| Semillas            |                    10 |
| Plantas             |                    10 |
+---------------------+-----------------------+
</pre>



## Consultas multitablas (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.

### Consulta n°28

Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

~~~mysql
SELECT CONCAT(C.primer_nombre, ' ', IF(C.segundo_nombre IS NOT NULL, C.segundo_nombre, ''), C.primer_apellido, ' ', IF(C.segundo_apellido IS NOT NULL, C.segundo_apellido, '')) AS "Nombre cliente"
	FROM pago AS P
	RIGHT JOIN cliente AS C ON P.id_cliente = C.id
	WHERE P.id_cliente IS NULL;
~~~

<pre>+---------------------------------+
| Nombre cliente                  |
+---------------------------------+
| David Diaz                      |
| Alexander CamiloRodríguez Mesa  |
| Karen Ortega                    |
+---------------------------------+</pre>



### Consulta n°29

Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

~~~mysql
SELECT C.id, CONCAT(C.primer_nombre, ' ', IF(C.segundo_nombre IS NOT NULL, C.segundo_nombre, ''), ' ', C.primer_apellido, ' ', IF(C.segundo_apellido IS NOT NULL, C.segundo_apellido, '')) AS "Nombre cliente"
	FROM pedido AS P
	RIGHT JOIN cliente AS C ON P.id_cliente = C.id
	WHERE P.id_cliente IS NULL;
~~~

<pre>+----+-----------------------------------+
| id | Nombre cliente                    |
+----+-----------------------------------+
| 21 | Ana  Álvarez                      |
| 22 | Yannis Milet Jimenez Martinez     |
| 23 | Alexander  Rodriguez              |
| 24 | Ánderson Steven Álvarado Correa   |
+----+-----------------------------------+
</pre>



### Consulta n°30

Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

~~~mysql
SELECT C.id, CONCAT(C.primer_nombre, ' ', IF(C.segundo_nombre IS NOT NULL, C.segundo_nombre, ''), C.primer_apellido, ' ', IF(C.segundo_apellido IS NOT NULL, C.segundo_apellido, '')) AS "Nombre cliente"
	FROM pago AS P
	RIGHT JOIN cliente AS C ON P.id_cliente = C.id
	WHERE P.id_cliente IS NULL

UNION
	
SELECT C.id, CONCAT(C.primer_nombre, ' ', IF(C.segundo_nombre IS NOT NULL, C.segundo_nombre, ''), ' ', C.primer_apellido, ' ', IF(C.segundo_apellido IS NOT NULL, C.segundo_apellido, '')) AS "Nombre cliente"
	FROM pedido AS P
	RIGHT JOIN cliente AS C ON P.id_cliente = C.id
	WHERE P.id_cliente IS NULL
	ORDER BY id;
    
~~~

<pre>+----+-----------------------------------+
| id | Nombre cliente                    |
+----+-----------------------------------+
| 21 | Ana  Álvarez                      |
| 22 | Yannis Milet Jimenez Martinez     |
| 23 | Alexander  Rodriguez              |
| 24 | Ánderson Steven Álvarado Correa   |
| 25 | David Diaz                        |
| 26 | Alexander CamiloRodríguez Mesa    |
| 27 | Karen Ortega                      |
+----+-----------------------------------+
</pre>



### Consulta n°31

Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

~~~mysql
SELECT CONCAT(primer_nombre, ' ', IF(segundo_nombre IS NOT NULL, segundo_nombre, ''), ' ', primer_apellido, ' ', IF(segundo_apellido IS NOT NULL, segundo_apellido, '')) AS "Nombre empleado"
	FROM empleado
	WHERE id_oficina IS NULL;
~~~

<pre>+------------------------------------+
| Nombre empleado                    |
+------------------------------------+
| Pedro Antonio López Martínez       |
| Monica  Flores González            |
| Mónica Patricia Flores Gutiérrez   |
+------------------------------------+
</pre>



### Consulta n°32

Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

~~~mysql
SELECT DISTINCT CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, ''), ' ', E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS "Nombre empleado"
	FROM cliente AS C
	RIGHT JOIN empleado AS E ON C.id_empleado_rep_ventas = E.id
	WHERE C.id IS NULL;
~~~

<pre>+-------------------------------------+
| Nombre empleado                     |
+-------------------------------------+
| Laura Teresa Gómez Pérez            |
| Juan Carlos Rojas López             |
| Pedro Antonio López Martínez        |
| Diego  Álvarez                      |
| Carlos Steven Hernández Navas       |
| Mónica Patricia Flores Gutiérrez    |
| Carolina Lizeth Torres Ramírez      |
| Andrea Carolina Morales Castillo    |
| Carolina Isabel Ramírez Chacón      |
| Juan Andrés Rojas Aguirre           |
| Andrés Sebastián Castillo Castro    |
| William David Chacón García         |
| Miguel Alejandro Castro González    |
| Juan Sebastián Rojas Torres         |
| Marcela Valentina González Chacón   |
+-------------------------------------+
</pre>



### Consulta n°33

Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

~~~mysql
SELECT DISTINCT CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, ''), ' ', E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS "Nombre empleado", C.nombre AS "Ciudad", CONCAT(O.nro_telefono, ' EXT.', O.extension) AS "Tel oficina", CONCAT(O.linea_direccion1, ' ', IF(O.linea_direccion2 IS NOT NULL, O.linea_direccion2, '')) AS "Dirección oficina"
	FROM cliente AS Cli
	RIGHT JOIN empleado AS E ON Cli.id_empleado_rep_ventas = E.id
	LEFT JOIN oficina AS O ON E.id_oficina = O.id
	INNER JOIN ciudad AS C ON O.id_ciudad = C.id
	WHERE Cli.id IS NULL;
~~~

<pre>+-------------------------------------+---------------+------------------+--------------------------------------------------------+
| Nombre empleado                     | Ciudad        | Tel oficina      | Dirección oficina                                      |
+-------------------------------------+---------------+------------------+--------------------------------------------------------+
| Laura Teresa Gómez Pérez            | Floridablanca | 12345678 EXT.123 | Calle 10 # 15 - 20 Barrio Centro                       |
| Juan Carlos Rojas López             | Huesca        | 87654321 EXT.456 | Carrera 7 # 30 - 40 Barrio La Candelaria               |
| Diego  Álvarez                      | Neuchâtel     | 45678901 EXT.012 | Calle 80 # 70 - 80 Barrio Usaquén                      |
| Carlos Steven Hernández Navas       | Almería       | 76543210 EXT.901 | Calle 13 # 130 - 140 Barrio Fontibón                   |
| Carolina Lizeth Torres Ramírez      | Edimburgo     | 54321065 EXT.567 | Avenida Cali # 170 - 180 Barrio Puente Aranda          |
| Andrea Carolina Morales Castillo    | Chicago       | 43210654 EXT.890 | Calle 26 # 190 - 200 Barrio Teusaquillo                |
| Carolina Isabel Ramírez Chacón      | Dubai         | 21065432 EXT.456 | Avenida Caracas # 230 - 240 Barrio Santa Inés          |
| Juan Andrés Rojas Aguirre           | Teruel        | 10654321 EXT.789 | Calle 100 # 250 - 260 Barrio Chapinero Alto            |
| Andrés Sebastián Castillo Castro    | Málaga        | 5432106 EXT.345  | Avenida Ciudad de Cali # 290 - 300 Barrio Tunjuelito   |
| William David Chacón García         | Chicago       | 3210654 EXT.901  | Carrera 19 # 330 - 340 Barrio Kennedy Central          |
| Miguel Alejandro Castro González    | Dubai         | 1065432 EXT.567  | Calle 72 # 370 - 380 Barrio Bosa Occidental            |
| Juan Sebastián Rojas Torres         | Maceió        | 543210 EXT.123   | Avenida Villavicencio # 410 - 420 Barrio Bosa Oriental |
| Marcela Valentina González Chacón   | Teruel        | 432106 EXT.456   | Calle 60 # 430 - 440 Barrio Rafael Uribe Uribe         |
+-------------------------------------+---------------+------------------+--------------------------------------------------------+
</pre>



### Consulta n°34

Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

~~~mysql
SELECT DISTINCT CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, ''), ' ', E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS "Nombre empleado"
	FROM cliente AS C
	RIGHT JOIN empleado AS E ON C.id_empleado_rep_ventas = E.id
	WHERE E.id_oficina IS NULL AND C.id IS NULL;
~~~

<pre>+------------------------------------+
| Nombre empleado                    |
+------------------------------------+
| Pedro Antonio López Martínez       |
| Mónica Patricia Flores Gutiérrez   |
+------------------------------------+
</pre>



### Consulta n°35

Devuelve un listado de los productos que nunca han aparecido en un pedido.

~~~mysql
SELECT Pr.id, Pr.nombre AS "Producto"
	FROM detalle_pedido AS PD
	JOIN pedido AS P ON PD.id_pedido = P.id
	RIGHT JOIN producto AS Pr ON PD.id_producto = Pr.id
	WHERE PD.id_producto IS NULL;
~~~

<pre>+----+----------------------------------+
| id | Producto                         |
+----+----------------------------------+
|  7 | Césped artificial                |
|  8 | Manguera de jardín               |
|  9 | Tijeras de podar                 |
| 10 | Rastrillo de jardín              |
| 11 | Manguera de riego                |
| 12 | Pala de jardín                   |
| 13 | Azadón                           |
| 14 | Cortacésped eléctrico            |
| 15 | Motosierra a gasolina            |
| 16 | Aspiradora de hojas              |
| 17 | Cabaña de jardín                 |
| 18 | Barbacoa de jardín               |
| 19 | Conjunto de jardín               |
| 20 | Hamaca de jardín                 |
| 21 | Semillas de tomate               |
| 22 | Sombrilla para jardín            |
| 23 | Casa de pájaros decorativa       |
| 24 | Piedras decorativas para jardín  |
| 25 | Iluminación solar para jardín    |
+----+----------------------------------+
</pre>



### Consulta n°36

Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen de la gama del producto.

~~~mysql
SELECT Pr.nombre AS "Producto", Pr.descripcion, G.imagen
	FROM detalle_pedido AS PD
	JOIN pedido AS P ON PD.id_pedido = P.id
	RIGHT JOIN producto AS Pr ON PD.id_producto = Pr.id
	INNER JOIN gama AS G ON Pr.id_gama = G.id
	WHERE PD.id_producto IS NULL;
~~~

<pre>+----------------------------------+-------------------------------------------------------------------------------+------------------+
| Producto                         | descripcion                                                                   | imagen           |
+----------------------------------+-------------------------------------------------------------------------------+------------------+
| Césped artificial                | Césped artificial para un jardín siempre verde.                               | decoracion.jpg   |
| Manguera de jardín               | Manguera de jardín resistente y flexible.                                     | herramientas.jpg |
| Tijeras de podar                 |                                                                               | herramientas.jpg |
| Rastrillo de jardín              | Rastrillo de jardín para recoger hojas y ramas.                               | herramientas.jpg |
| Manguera de riego                | Manguera de riego para regar tus plantas de forma eficiente.                  | herramientas.jpg |
| Pala de jardín                   |                                                                               | herramientas.jpg |
| Azadón                           | Azadón para remover la tierra y eliminar malas hierbas.                       | herramientas.jpg |
| Cortacésped eléctrico            | Cortacésped eléctrico ligero y fácil de usar.                                 | herramientas.jpg |
| Motosierra a gasolina            |                                                                               | herramientas.jpg |
| Aspiradora de hojas              | Aspiradora de hojas para mantener tu jardín limpio.                           | herramientas.jpg |
| Cabaña de jardín                 | Cabaña de jardín de madera para almacenar herramientas o descansar.           | decoracion.jpg   |
| Barbacoa de jardín               | Barbacoa de jardín para disfrutar de comidas al aire libre.                   | mobiliario.jpg   |
| Conjunto de jardín               |                                                                               | decoracion.jpg   |
| Hamaca de jardín                 | Hamaca de jardín para relajarse y disfrutar del aire libre.                   | mobiliario.jpg   |
| Semillas de tomate               | Semillas de tomate de alta calidad para cultivar tus propios tomates frescos. | hortalizas.jpg   |
| Sombrilla para jardín            | Sombrilla para jardín que te protege del sol en los días calurosos.           | mobiliario.jpg   |
| Casa de pájaros decorativa       | Casa de pájaros decorativa para atraer a las aves a tu jardín.                | decoracion.jpg   |
| Piedras decorativas para jardín  |                                                                               | decoracion.jpg   |
| Iluminación solar para jardín    | Iluminación solar para jardín que funciona con energía solar.                 | mobiliario.jpg   |
+----------------------------------+-------------------------------------------------------------------------------+------------------+</pre>



### Consulta n°37

Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Hortalizas.

~~~mysql
SELECT DISTINCT E.id_oficina, C.nombre AS "Ciudad"
	FROM (
    	SELECT DISTINCT E.id
        FROM detalle_pedido AS DP
        INNER JOIN producto AS Pr ON DP.id_producto = Pr.id
        INNER JOIN gama AS G ON Pr.id_gama = G.id
        INNER JOIN pedido AS P ON DP.id_pedido = P.id
        INNER JOIN cliente AS Cli ON P.id_cliente = Cli.id
        INNER JOIN empleado AS E ON Cli.id_empleado_rep_ventas = E.id
        WHERE G.nombre_gama = "Hortalizas" AND E.id_puesto = 6 AND E.id_oficina IS NULL
    ) AS FEOPC  # FEOPC = Filtro por Empleado sin Oficina y Pedido por Cliente
   	RIGHT JOIN empleado AS E ON FEOPC.id = E.id
   	INNER JOIN oficina AS O ON E.id_oficina = O.id
   	INNER JOIN ciudad AS C ON O.id_ciudad = C.id
   	WHERE E.id_oficina IS NOT NULL;
~~~

<pre>+------------+-------------------+
| id_oficina | Ciudad            |
+------------+-------------------+
|          1 | Floridablanca     |
|          2 | Huesca            |
|          4 | Neuchâtel         |
|          7 | Almería           |
|          9 | Edimburgo         |
|         10 | Chicago           |
|         11 | Neuchâtel         |
|         12 | Dubai             |
|         13 | Teruel            |
|         14 | Córdoba           |
|         15 | Málaga            |
|         16 | Zaragoza          |
|         17 | Chicago           |
|         18 | Neuchâtel         |
|         19 | Dubai             |
|         20 | Ciudad de México  |
|         21 | Maceió            |
|         22 | Teruel            |
|         23 | Málaga            |
+------------+-------------------+
</pre>



### Consulta n°38

Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

~~~mysql
SELECT C.id, CONCAT(C.primer_nombre, ' ', C.primer_apellido) AS "Nombre cliente"
	FROM (
    	SELECT FCPR.id
        FROM (
            SELECT C.id
            FROM pago AS P
            RIGHT JOIN cliente AS C ON P.id_cliente = C.id
            WHERE P.id_transaccion IS NULL
        ) AS FCPR  # FCPR = Filtrado por Clientes sin Pagos Realizados
        INNER JOIN (
            SELECT C.id
            FROM pedido AS P
            RIGHT JOIN cliente AS C ON P.id_cliente = C.id
            WHERE P.id IS NOT NULL
        ) AS FCPDR  # FCPDR = Filtrado por Clientes con PeDidos Realizados
        ON FCPR.id = FCPDR.id
    ) AS RF  # RF = Resultado Final
    INNER JOIN cliente AS C ON RF.id = C.id;
~~~

<pre>+----+----------------------+
| id | Nombre cliente       |
+----+----------------------+
| 25 | David Diaz           |
| 26 | Alexander Rodríguez  |
| 27 | Karen Ortega         |
+----+----------------------+
</pre>



### Consulta n°39

Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

~~~mysql
SELECT E.nombre_empleado AS "Nombre empleado", E.id_oficina AS "E.oficina", E.id_puesto AS "E.puesto", CONCAT(J.primer_nombre, ' ', IF(J.segundo_nombre IS NOT NULL, J.segundo_nombre, ''), ' ', J.primer_apellido, ' ', IF(J.segundo_apellido IS NOT NULL, J.segundo_apellido, '')) AS "Nombre jefe", J.id_oficina, J.id_puesto
	FROM (
        SELECT DISTINCT CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, ''), ' ', E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS "nombre_empleado", E.codigo_jefe, E.id_oficina, E.id_puesto
        FROM cliente AS C
        RIGHT JOIN empleado AS E ON C.id_empleado_rep_ventas = E.id
        WHERE C.id IS NULL
    ) AS E
    INNER JOIN empleado AS J ON E.codigo_jefe = J.id;
~~~

<pre>+-------------------------------------+-----------+----------+--------------------------------+------------+-----------+
| Nombre empleado                     | E.oficina | E.puesto | Nombre jefe                    | id_oficina | id_puesto |
+-------------------------------------+-----------+----------+--------------------------------+------------+-----------+
| Juan Carlos Rojas López             |         2 |        2 | Laura Teresa Gómez Pérez       |          1 |         1 |
| Pedro Antonio López Martínez        |      NULL |        3 | Juan Carlos Rojas López        |          2 |         2 |
| Diego  Álvarez                      |         4 |        4 | Juan Carlos Rojas López        |          2 |         2 |
| Carlos Steven Hernández Navas       |         7 |        7 | Juan Carlos Rojas López        |          2 |         2 |
| Mónica Patricia Flores Gutiérrez    |      NULL |        8 | Diego  Álvarez                 |          4 |         4 |
| Carolina Lizeth Torres Ramírez      |         9 |        9 | Juan Carlos Rojas López        |          2 |         2 |
| Andrea Carolina Morales Castillo    |        10 |       10 | Carlos Steven Hernández Navas  |          7 |         7 |
| Carolina Isabel Ramírez Chacón      |        12 |        1 | Carlos Steven Hernández Navas  |          7 |         7 |
| Juan Andrés Rojas Aguirre           |        13 |        3 | Diego  Álvarez                 |          4 |         4 |
| Andrés Sebastián Castillo Castro    |        15 |        5 | Juan Carlos Rojas López        |          2 |         2 |
| William David Chacón García         |        17 |        7 | Carlos Steven Hernández Navas  |          7 |         7 |
| Miguel Alejandro Castro González    |        19 |        9 | William David Chacón García    |         17 |         7 |
| Juan Sebastián Rojas Torres         |        21 |        2 | Diego  Álvarez                 |          4 |         4 |
| Marcela Valentina González Chacón   |        22 |        3 | Juan Carlos Rojas López        |          2 |         2 |
+-------------------------------------+-----------+----------+--------------------------------+------------+-----------+
</pre>



## Consultas resumen

### Consulta n°40

¿Cuántos empleados hay en la compañía?

~~~mysql
SELECT COUNT(*) AS "Cant. Empleados"
	FROM empleado;
~~~

<pre>+-----------------+
| Cant. Empleados |
+-----------------+
|              23 |
+-----------------+
</pre>



### Consulta n°41

¿Cuántos clientes tiene cada país?

~~~mysql
SELECT P.nombre AS "País", COUNT(P.nombre)
	FROM cliente AS Cli
	INNER JOIN ciudad AS C ON Cli.id_ciudad = C.id
	INNER JOIN region AS R ON C.id_region = R.id
	INNER JOIN pais AS P ON R.id_pais = P.id
	GROUP BY P.nombre;
~~~

<pre>+----------------+-----------------+
| País           | COUNT(P.nombre) |
+----------------+-----------------+
| Colombia       |               6 |
| Estados Unidos |               6 |
| Francia        |               6 |
| España         |               8 |
| Suiza          |               1 |
+----------------+-----------------+
</pre>



### Consulta n°42

¿Cuál fue el pago medio en 2009?

~~~mysql
SELECT FORMAT(AVG(total), 2) AS "Pago medio"
	FROM pago
	WHERE YEAR(fecha_pago) = 2009;
~~~

<pre>+------------+
| Pago medio |
+------------+
| 678.63     |
+------------+</pre>



### Consulta n°43

¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.

~~~mysql
SELECT RF.id_estado, E.nombre AS "Estado", RF.cant_pedidos
	FROM (
    	SELECT id_estado, COUNT(id_estado) AS "cant_pedidos"
        FROM pedido_estado
        GROUP BY id_estado
    ) AS RF  # RF = Resultado Final
    INNER JOIN estado AS E ON RF.id_estado = E.id;
~~~

<pre>+-----------+--------------+--------------+
| id_estado | Estado       | cant_pedidos |
+-----------+--------------+--------------+
|         3 | Entregado    |           72 |
|         4 | No entregado |           28 |
+-----------+--------------+--------------+
</pre>



### Consulta n°44

Calcula el precio de venta del producto más caro y más barato en una misma consulta.

~~~mysql
SELECT MAX(precio_venta) AS "Producto caro", MIN(precio_venta) AS "Producto barato"
	FROM producto;
~~~

<pre>+---------------+-----------------+
| Producto caro | Producto barato |
+---------------+-----------------+
|        399.99 |            1.50 |
+---------------+-----------------+
</pre>



### Consulta n°45

Calcula el número de clientes que tiene la empresa.

~~~mysql
SELECT COUNT(id) AS "Cant. Clientes"
	FROM cliente;
~~~

<pre>+----------------+
| Cant. Clientes |
+----------------+
|             27 |
+----------------+
</pre>



### Consulta n°46

¿Cuántos clientes existen con domicilio en la ciudad de Zaragoza?

~~~mysql
SELECT COUNT(Cli.id) AS "Cant. Clientes Zaragoza"
	FROM cliente AS Cli
	INNER JOIN ciudad AS C ON Cli.id_ciudad = C.id
	WHERE C.nombre = "Zaragoza";
~~~

<pre>+-------------------------+
| Cant. Clientes Zaragoza |
+-------------------------+
|                       3 |
+-------------------------+
</pre>



### Consulta n°47

¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?

~~~mysql
SELECT CONCAT(Cli.primer_nombre, ' ', Cli.primer_apellido) AS "Nombre cliente", C.nombre AS "Ciudad"
	FROM cliente AS Cli
	INNER JOIN ciudad AS C ON Cli.id_ciudad = C.id
	WHERE C.nombre LIKE 'M%';

SELECT RF.ciudad, COUNT(RF.nombre_cliente)
	FROM (
    	SELECT CONCAT(Cli.primer_nombre, ' ', Cli.primer_apellido) AS "nombre_cliente", C.nombre AS "ciudad"
        FROM cliente AS Cli
        INNER JOIN ciudad AS C ON Cli.id_ciudad = C.id
        WHERE C.nombre LIKE 'M%'
    ) AS RF  # RF = Resultado Final
    GROUP BY RF.ciudad;
~~~

<pre>+-----------+--------------------------+
| ciudad    | COUNT(RF.nombre_cliente) |
+-----------+--------------------------+
| Medellín  |                        1 |
| Manizales |                        1 |
| Marsella  |                        1 |
| Málaga    |                        1 |
+-----------+--------------------------+
</pre>



### Consulta n°48

Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.

~~~mysql
SELECT RF.nombre_empleado, COUNT(RF.id) AS "Cant. Clientes x Empleado"
	FROM (
    	SELECT E.id, CONCAT(E.primer_nombre, ' ', IF(E.segundo_nombre IS NOT NULL, E.segundo_nombre, ''), ' ', E.primer_apellido, ' ', IF(E.segundo_apellido IS NOT NULL, E.segundo_apellido, '')) AS "nombre_empleado"
        FROM empleado AS E
        INNER JOIN puesto AS P ON E.id_puesto = P.id
        WHERE P.nombre = 'Representante de ventas'
    ) AS RF  # RF = Resultado Final
    INNER JOIN cliente AS C ON RF.id = C.id_empleado_rep_ventas
    GROUP BY RF.nombre_empleado;
~~~

<pre>+-------------------------------------+---------------------------+
| nombre_empleado                     | Cant. Clientes x Empleado |
+-------------------------------------+---------------------------+
| Laura Marcela Rodríguez             |                         5 |
| José Francisco Vargas Torres        |                         5 |
| Jennifer Stefania Robles Gutiérrez  |                         3 |
| Paola Valentina García Velasquez    |                         2 |
| Natalia Mariana Aguirre Rojas       |                         4 |
| Sofía Camila Gutiérrez Castillo     |                         5 |
+-------------------------------------+---------------------------+
</pre>



### Consulta n°49

Calcula el número de clientes que no tiene asignado representante de ventas.

~~~mysql
SELECT COUNT(*) AS "Cant. Clientes sin rep ventas"
	FROM cliente AS C
	WHERE C.id_empleado_rep_ventas NOT IN (
        SELECT E.id
        	FROM empleado AS E
        	INNER JOIN puesto AS P ON E.id_puesto = P.id
        	WHERE P.nombre = 'Representante de ventas'
    );
~~~

<pre>+-------------------------------+
| Cant. Clientes sin rep ventas |
+-------------------------------+
|                             3 |
+-------------------------------+
</pre>



### Consulta n°50

Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

~~~mysql
SELECT CONCAT(C.primer_nombre, ' ', IF(C.segundo_nombre IS NOT NULL, C.segundo_nombre, ''), ' ', C.primer_apellido, ' ', IF(C.segundo_apellido IS NOT NULL, C.segundo_apellido, '')) AS "Nombre cliente",  RF.primer_pago, RF.ultimo_pago
	FROM (
    	SELECT id_cliente, MIN(fecha_pago) AS "primer_pago", MAX(fecha_pago) AS "ultimo_pago"
        FROM pago
        GROUP BY id_cliente
    ) AS RF  # RF = Resultado Final
    INNER JOIN cliente AS C ON RF.id_cliente = C.id;
~~~

<pre>+------------------------------------+-------------+-------------+
| Nombre cliente                     | primer_pago | ultimo_pago |
+------------------------------------+-------------+-------------+
| Maria Jose Rodriguez Perez         | 2010-05-22  | 2010-05-22  |
| Pedro Luis Lopez Martinez          | 2016-11-23  | 2016-11-23  |
| Ana Maria Garcia Fernandez         | 2003-04-24  | 2003-04-24  |
| David Alejandro Sanchez Gonzalez   | 2009-09-25  | 2012-07-15  |
| Laura Beatriz Gomez Rodriquez      | 2008-11-26  | 2015-03-26  |
| Carlos Eduardo Rojas Navas         | 2002-08-27  | 2005-02-07  |
| Mónica Patricia Flores Gutierrez   | 2011-06-18  | 2018-02-28  |
| Diego Alberto Alvarez Ramirez      | 2004-12-29  | 2014-07-29  |
| Andrea Carolina Morales Castillo   | 2008-01-10  | 2011-01-30  |
| José Francisco Vargas Torres       | 2010-05-11  | 2017-06-30  |
| Carolina Isabel Ramirez Chacon     | 2013-12-01  | 2016-11-12  |
| Steven Andrés Hernandez Aguirre    | 2003-04-13  | 2008-05-02  |
| Jennifer Stefania Robles Gutierrez | 2009-09-14  | 2016-11-03  |
| Andrés Sebastián Castillo Castro   | 2003-04-04  | 2015-03-15  |
| Valentina Mariana Torres Chacon    | 2002-08-16  | 2009-09-05  |
| Isabella Sofia Chacon Aguirre      | 2008-02-17  | 2015-03-06  |
| Mariana Camila Aguirre Gutierrez   | 2002-08-07  | 2014-07-18  |
| Alejandro Miguel Castro Ramirez    | 2010-05-13  | 2011-01-19  |
| Camila Sofía Gutierrez Castillo    | 2016-11-14  | 2017-06-20  |
| Miguel Alejandro Rojas Torres      | 2008-04-15  | 2008-12-21  |
| Ana  Álvarez                       | 2008-05-12  | 2008-05-12  |
| Yannis Milet Jimenez Martinez      | 2015-10-23  | 2015-10-23  |
| Alexander  Rodriguez               | 2008-03-04  | 2008-03-04  |
+------------------------------------+-------------+-------------+
</pre>



### Consulta n°51

Calcula el número de productos diferentes que hay en cada uno de los pedidos.

~~~mysql
SELECT id_pedido, COUNT(DISTINCT(id_producto)) AS "cant_productos"
        FROM detalle_pedido
        GROUP BY id_pedido;
~~~

<pre>+-----------+----------------+
| id_pedido | cant_productos |
+-----------+----------------+
|         1 |              4 |
|         2 |              3 |
|         3 |              3 |
|         4 |              3 |
|         5 |              3 |
|         6 |              2 |
|         7 |              2 |
|         8 |              3 |
|         9 |              2 |
|        10 |              3 |
|        11 |              2 |
|        12 |              4 |
|        13 |              3 |
|        14 |              2 |
|        15 |              2 |
|        16 |              2 |
|        17 |              3 |
|        18 |              2 |
|        19 |              2 |
|        20 |              3 |
+-----------+----------------+
</pre>



### Consulta n°52

Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

~~~mysql
SELECT id_pedido, CONCAT('$', FORMAT(SUM(DISTINCT(precio_unidad)), 2)) AS "cant_productos"
        FROM detalle_pedido
        GROUP BY id_pedido;
~~~

<pre>+-----------+----------------+
| id_pedido | cant_productos |
+-----------+----------------+
|         1 | $79.46         |
|         2 | $54.48         |
|         3 | $43.97         |
|         4 | $79.46         |
|         5 | $62.47         |
|         6 | $36.97         |
|         7 | $40.49         |
|         8 | $45.96         |
|         9 | $60.48         |
|        10 | $49.48         |
|        11 | $38.98         |
|        12 | $53.47         |
|        13 | $63.47         |
|        14 | $23.98         |
|        15 | $32.98         |
|        16 | $36.97         |
|        17 | $63.47         |
|        18 | $44.49         |
|        19 | $41.97         |
|        20 | $37.97         |
+-----------+----------------+
</pre>



### Consulta n°53

### Consulta n°54

### Consulta n°55

### Consulta n°56

### Consulta n°57

### Consulta n°58

Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.

~~~mysql
SELECT MAX(id_transaccion) AS "id", YEAR(fecha_pago) AS "fecha_pago_anio", CONCAT('$', FORMAT(SUM(total), 2)) AS "cant_total"
        FROM pago
        GROUP BY fecha_pago_anio;
~~~

<pre>+------------------------------------+-----------------+------------+
| id                                 | fecha_pago_anio | cant_total |
+------------------------------------+-----------------+------------+
| Z3X4-A2B3-C4D5-E6F7-G8H9-I1J0-K2L3 |            2008 | $4,553.05  |
| N4M5-O6P7-Q8R9-S1T2-U3V4-W5X6-Y7Z8 |            2015 | $2,495.09  |
| Z9A0-B1C2-D3E4-F5G6-H7I8-J9K0-L1M2 |            2009 | $2,035.90  |
| X9Y0-Z1A2-B3C4-D5E6-F7G8-H9I0-J1K2 |            2016 | $2,827.20  |
| D5E6-F7G8-H9I0-J1K2-L3M4-N5O6-P7Q8 |            2012 | $234.56    |
| Z1A2-B3C4-D5E6-F7G8-H9I0-J1K2-L3M4 |            2003 | $1,037.01  |
| N3O4-P5Q6-R7S8-T9U0-V1W2-X3Y4-Z5A6 |            2002 | $1,370.34  |
| J3K4-L5M6-N7O8-P9Q0-R1S2-T3U4-V5W6 |            2005 | $891.20    |
| L7M8-N9O0-P1Q2-R3S4-T5U6-V7W8-X9Y0 |            2018 | $789.10    |
| T9U0-V1W2-X3Y4-Z5A6-B7C8-D9E0-F1G2 |            2011 | $1,370.34  |
| R7S8-T9U0-V1W2-X3Y4-Z5A6-B7C8-D9E0 |            2014 | $1,146.90  |
| P9Q0-R1S2-T3U4-V5W6-X7Y8-Z9A0-B1C2 |            2004 | $678.91    |
| V1W2-X3Y4-Z5A6-B7C8-D9E0-F1G2-H3I4 |            2017 | $1,680.30  |
| Z5A6-B7C8-D9E0-F1G2-H3I4-J5K6-L7M8 |            2010 | $1,813.77  |
| T5U6-V7W8-X9Y0-Z1A2-B3C4-D5E6-F7G8 |            2013 | $345.67    |
+------------------------------------+-----------------+------------+
</pre>

