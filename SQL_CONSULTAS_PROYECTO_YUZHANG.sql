--a). 5 Consultas simples de una sola tabla:
-- Obtener todos los productos de la categoría 'Electrónicos'
SELECT nombre FROM PRODUCTOS WHERE LOWER(categoria) = 'electrónica';
-- Obtener la información de todos almacen cuyo su tamaño es mayor que 600 metreos cuadrados.
SELECT * FROM ALMACEN WHERE tamanio > 600;
-- Obtener la lista de todos los pedidos realizados
SELECT * FROM PEDIDOS;
-- Obtener los comentarios y valoraciones de los pedidos
SELECT n_comentarios, valoracion FROM COMENTARIOS;
-- Obtener el nombre y emal de todos los proveedores
SELECT nombre, email FROM PROVEEDOR;

--b). 2 Actualizaciones y 2 Borrados en cualquier tabla:
-- Actualizar la dirección del cliente con ID 'C001'
UPDATE CLIENTES SET direccion = 'Nueva Dirección' WHERE id = 'C001';
-- Aumentar el precio de todos los productos en un 10%
UPDATE PRODUCTOS SET precio = precio * 1.10;
-- Borrar el pedido con número 'PED003'
DELETE FROM PEDIDOS WHERE n_pedidos = 'PED003';
-- Borrar el comentario con número 'COM002'
DELETE FROM COMENTARIOS WHERE n_comentarios = 'COM002';

--c). 3 Consultas con más de 1 tabla:
-- 1.Obtener información de pedidos y productos relacionados                                                           *****
SELECT * FROM 
PEDIDOS P, CONTENIDO C, PRODUCTOS PR 
WHERE P.n_pedidos = C.n_pedidos
AND C.n_productos = PR.n_de_referencia;
-- 2. Mostrar las tiendas y los clientes que las visitaron                                                             *****
SELECT * FROM 
Visitar V, TIENDAS T
WHERE V.nif_tiendas = T.nif;
-- 3.Obtener detalles de los paquetes y los estados actuales                                                           *****
SELECT * FROM 
PAQUETES PA, TENER D, ESTADO E 
WHERE PA.codigo_de_paquetes = D.codigo_de_paquetes
AND D.id_estado = E.id_estado;

--d). 3 Consultas usando funciones:
-- 1.Calcular el total de ventas de todas las tiendas                                                                  *****
SELECT SUM(ventas) AS total_ventas FROM TIENDAS;             
-- 2.Calcular el promedio de valoraciones de los comentarios                                                           *****
SELECT ROUND(AVG(valoracion),2) AS promedio_valoracion FROM COMENTARIOS;
-- 3.Obtener la diferencia de horas entre la fecha de inicio y fin de sustitución de repartidores
SELECT repartidor1, repartidor2, EXTRACT(HOUR FROM (fecha_end - fecha_start)) AS dias_sustitucion
FROM Sustituir;

--e). 2 Consultas usando GROUP BY:
-- 1. Calcular la cantidad total de productos por categoría en la tabla PRODUCTOS
SELECT categoria, SUM(inventarios) AS total_productos 
FROM PRODUCTOS 
GROUP BY categoria;
-- 2. Contar la cantidad de visitas por tienda en la tabla Visitar
SELECT nif_tiendas, COUNT(*) AS cantidad_visitas 
FROM Visitar 
GROUP BY nif_tiendas;

--f). 2 Consultas utilizando subconsultas:
-- 1. Obtener los pedidos realizados por clientes nombres mayor de 3 digitos
SELECT * FROM PEDIDOS 
WHERE id_cliente IN (
	SELECT id FROM CLIENTES WHERE LENGTH(nombre) > 3
);
-- 2. Mostrar los repartidores con salario superior al promedio
SELECT * FROM REPARTIDOR 
WHERE salario > (
	SELECT AVG(salario) FROM REPARTIDOR
);

--g). 2 Consultas usando GROUP BY con HAVING:
-- 1. Filtrar las tiendas con menos de 100 visitas en la tabla Visitar
SELECT nif_tiendas, COUNT(*) AS cantidad_visitas 
FROM Visitar GROUP BY nif_tiendas 
HAVING COUNT(*) < 100;
-- 2. Obtener las categorías de productos con inventario total superior a 100
SELECT categoria, SUM(inventarios) AS inventario_total 
FROM PRODUCTOS 
GROUP BY categoria 
HAVING SUM(inventarios) > 100;

--h). 3 actualizaciones usando subconsultas en WHERE y SET:
-- 1. Actualizar la cuenta bancaria de las tiendas con ventas superiores a 700
UPDATE TIENDAS 
SET cuenta_bancaria = 'NuevaCuenta' 
WHERE nif IN (
	SELECT nif FROM TIENDAS 
	WHERE ventas > 700
);

-- 2. Actualizar el precio de los productos con un 20% de descuento
UPDATE PRODUCTOS
SET precio = precio * 0.80 
WHERE n_de_referencia IN (
	SELECT n_de_referencia 
	FROM PRODUCTOS 
	WHERE LOWER(categoria) = 'electrónica');

-- 3. Actualizar la cantidad de fondos después de un pedido (restando el importe total del pedido)
UPDATE FONDOS
SET cantidad = cantidad - (
    SELECT SUM(importe_total) 
    FROM PEDIDOS 
    WHERE id_cliente IN (SELECT nif FROM TIENDAS)
);
