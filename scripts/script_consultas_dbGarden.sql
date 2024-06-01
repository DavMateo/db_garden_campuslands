/* USANDO LA BASE DE DATOS "garden" */
USE garden;



/* REALIZANDO LAS CONSULTAS PROPUESTAS PARA LA BASE DE DATOS */

/* CONSULTA N°1
Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
*/
SELECT O.id AS 'Código Oficina', C.nombre AS ciudad
  FROM oficina AS O
  INNER JOIN ciudad AS C ON O.id_ciudad = C.id;
