/*
VISTAS:
VISTA 1. VISTA PEDIDOS DETALLE:
	Diseño: Esta vista muestra detalles completos de los pedidos, incluyendo la información del cliente, productos pedidos y el repartidor asignado.
	Justificación: Esta vista permite a los usuarios ver fácilmente todos los detalles de un pedido sin necesidad de realizar múltiples consultas de unión entre tablas. Esto es muy útil para el servicio al cliente y la gestión de pedidos.
*/
CREATE OR REPLACE VIEW PEDIDOS_DETALLE AS                                                                       
SELECT 
    P.n_pedidos AS Pedido_Numero,
    P.importe_total AS Importe_Total,
    P.fecha_hora AS Fecha_Hora,
    P.costo_envios AS Costo_Envios,
    P.notas AS Notas,
    C.id AS Cliente_ID,
    C.nombre AS Cliente_Nombre,
    C.direccion AS Cliente_Direccion,
    C.genero AS Cliente_Genero,
    C.telefono AS Cliente_Telefono,
    PR.n_de_referencia AS Producto_Referencia,
    PR.nombre AS Producto_Nombre,
    PR.categoria AS Producto_Categoria,
    PR.precio AS Producto_Precio,
    PR.inventarios AS Producto_Inventarios,
    R.dni AS Repartidor_DNI,
    R.nombre_completo AS Repartidor_Nombre,
    R.telefono AS Repartidor_Telefono,
    R.domicilio AS Repartidor_Domicilio
FROM 
    PEDIDOS P,
    CLIENTES C,
    Contenido CO,
    PRODUCTOS PR,
    PAQUETES PA,
    Designar D,
    REPARTIDOR R
WHERE 
    P.id_cliente = C.id AND
    P.n_pedidos = CO.n_pedidos AND
    CO.n_productos = PR.n_de_referencia AND
    P.n_pedidos = PA.n_pedidos AND
    PA.codigo_de_paquetes = D.codigo_de_paquetes AND
    D.dni_repartidor = R.dni;

SELECT * FROM PEDIDOS_DETALLE;
/*
VISTA 2. VISTA PRODUCTOS INVENTARIO:
	Diseño: Esta vista muestra todos los productos y su estado actual de inventario.
	Justificación: Esto ayuda en la gestión de inventarios, permitiendo a los administradores de inven-tario ver rápidamente el estado del inventario de los productos para reabastecer o ajustar el stock oportunamente.
*/
CREATE OR REPLACE VIEW PRODUCTOS_INVENTARIO AS
SELECT 
    n_de_referencia AS Producto_Referencia,
    nombre AS Producto_Nombre,
    categoria AS Producto_Categoria,
    precio AS Producto_Precio,
    inventarios AS Inventario_Actual
FROM PRODUCTOS;

SELECT * FROM PRODUCTOS_INVENTARIO;
/*
FUNCIONES Y CURSORES:
Realiza cuatro funciones útiles para el proyecto. En una de ellas mínimo debes utilizar un cursor.
FUNCIONES 1. OBTENER REPARTIDOR DISPONIBLE: 
	Funcionalidad: Obtener un repartidor disponible en el momento actual.
	Razón: Automatiza la asignación de repartidores para mejorar la eficiencia.
*/
CREATE OR REPLACE FUNCTION obtener_repartidores_disponible()
RETURNS TABLE(dni VARCHAR(9), nombre_completo VARCHAR(50), telefono VARCHAR(15), domicilio VARCHAR(50))
AS $$
BEGIN
    RETURN QUERY
    SELECT R.dni, R.nombre_completo, R.telefono, R.domicilio
    FROM REPARTIDOR R
    WHERE R.dni NOT IN (SELECT DISTINCT dni_repartidor FROM Designar);
END;
$$ LANGUAGE plpgsql;

SELECT obtener_repartidores_disponible();
/*
FUNCIONES 2. CALCULAR DESCUENTO:
	Funcionalidad: Calcular el monto de descuento para un pedido según un porcentaje dado.
	Razón: Automatiza el cálculo del monto de descuento, facilitando las actividades promocionales.
*/
CREATE OR REPLACE FUNCTION calcular_descuento(importe_total NUMERIC, porcentaje_descuento NUMERIC)
RETURNS NUMERIC
AS $$
BEGIN
    RETURN ROUND(importe_total * (porcentaje_descuento / 100), 2);
END;
$$ LANGUAGE plpgsql;

SELECT calcular_descuento(100, 12);
/*
FUNCIONES 3. ACTUALIZAR ESTADO PEDIDO:
	Funcionalidad: Actualizar el estado de un pedido.
	Razón: Unifica la actualización del estado del pedido a través de una función para asegurar la con-sistencia de la lógica del negocio.
*/
CREATE OR REPLACE FUNCTION actualizar_estado_pedido(n_pedido VARCHAR(20), nuevo_estado VARCHAR(20))
RETURNS VOID
AS $$
DECLARE
    pedido_existente BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM PEDIDOS WHERE n_pedidos = n_pedido) INTO pedido_existente;
    
    IF pedido_existente THEN
        IF EXISTS (SELECT 1 FROM ESTADO WHERE nombre = nuevo_estado) THEN
            UPDATE Tener
            SET id_estado = (SELECT id_estado FROM ESTADO WHERE nombre = nuevo_estado)
            WHERE n_pedidos = n_pedido;
        ELSE
            RAISE EXCEPTION 'El estado "%" no existe en la base de datos.', nuevo_estado;
        END IF;
    ELSE
        RAISE EXCEPTION 'El pedido "%" no existe en la base de datos.', n_pedido;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT actualizar_estado_pedido('124324234234', 'DEWFWEFWEF');
/*
FUNCIONES 4. LISTAR PRODUCTOS CATEGORÍA:                                                                      *****
	Funcionalidad: Usar un cursor para listar todos los productos de una categoría específica.
	Razón: Usar un cursor para procesar filas individualmente puede mejorar la eficiencia al manejar grandes conjuntos de datos.
*/
CREATE OR REPLACE FUNCTION listar_productos_categoria(categoria_busqueda VARCHAR)
RETURNS TABLE(n_de_referencia VARCHAR(10), nombre VARCHAR(50), categoria_producto VARCHAR(30), precio NUMERIC, inventarios NUMERIC)
AS $$
DECLARE
    producto RECORD;
    cur CURSOR FOR 
        SELECT P.n_de_referencia, P.nombre, P.categoria, P.precio, P.inventarios 
        FROM PRODUCTOS P 
        WHERE P.categoria = categoria_busqueda;
BEGIN
    OPEN cur;
    
    LOOP
        FETCH cur INTO producto;
        EXIT WHEN NOT FOUND;
		
       	RETURN QUERY
	   	SELECT producto.n_de_referencia, producto.nombre, producto.categoria, producto.precio, producto.inventarios;
    END LOOP;
    
    CLOSE cur;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontraron productos en la categoría especificada.';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM PRODUCTOS

SELECT listar_productos_categoria('Ropa');


/*
TRIGGERS:
Realiza cuatro ‘Triggers’ en el proyecto, deben haber ‘triggers’ de los dos tipos siguientes:
1)	‘Trigger’ global que afecte a la tabla que quieras y que haga algún tipo de validación global que no permita alguna operación de insertar, de borrado o de modificación.
TRIGGER 1. NO BORRAR CLIENTE CON PEDIDOS:
	Tabla Afectada: Clientes
	Operaciones: DELETE
	Funcionalidad: Impide eliminar un cliente que tiene pedidos asociados.
	Razón: Mantiene la integridad de los datos al evitar la eliminación de registros importantes para el negocio. Si un cliente tiene pedidos asociados, su eliminación podría llevar a inconsistencias y pér-dida de información crucial.
*/
CREATE OR REPLACE FUNCTION no_borrar_cliente_con_pedidos()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM PEDIDOS WHERE id_cliente = OLD.id) THEN
        RAISE EXCEPTION 'No se puede borrar un cliente con pedidos asociados';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER no_borrar_cliente_trigger
BEFORE DELETE ON CLIENTES
FOR EACH ROW
EXECUTE FUNCTION no_borrar_cliente_con_pedidos();

DELETE FROM CLIENTES WHERE id = 'C001';
/*
2)	‘Trigger’ que vaya por fila, y que haga una automatización que consideres en tu aplicación. Por ejemplo, cuando hagas una operación sobre una tabla debe automáticamente hacer algo sobre otra tabla.
TRIGGER 2. ACTUALIZAR STOCK:
	Tabla Afectada: Pedidos
	Operaciones: INSERT
	Funcionalidad: Actualiza automáticamente el inventario al insertar un pedido.
	Razón: Automatiza la gestión del inventario, reduciendo errores en la actualización manual del in-ventario. Esto garantiza que el inventario refleje con precisión la cantidad disponible después de cada nueva orden.
*/
CREATE OR REPLACE FUNCTION actualizar_stock_insert_update_delete()
RETURNS TRIGGER AS $$
DECLARE
    cantidad INTEGER;
BEGIN
    IF TG_OP = 'INSERT' THEN
        FOR cantidad IN SELECT n_productos FROM Contenido WHERE n_pedidos = NEW.n_pedidos LOOP
            UPDATE PRODUCTOS
            SET inventarios = inventarios - 1
            WHERE n_de_referencia = cantidad;
        END LOOP;
    ELSIF TG_OP = 'UPDATE' THEN
        FOR cantidad IN SELECT n_productos FROM Contenido WHERE n_pedidos = OLD.n_pedidos LOOP
            UPDATE PRODUCTOS
            SET inventarios = inventarios + 1
            WHERE n_de_referencia = cantidad;
        END LOOP;
        
        FOR cantidad IN SELECT n_productos FROM Contenido WHERE n_pedidos = NEW.n_pedidos LOOP
            UPDATE PRODUCTOS
            SET inventarios = inventarios - 1
            WHERE n_de_referencia = cantidad;
        END LOOP;
    ELSIF TG_OP = 'DELETE' THEN
        FOR cantidad IN SELECT n_productos FROM Contenido WHERE n_pedidos = OLD.n_pedidos LOOP
            UPDATE PRODUCTOS
            SET inventarios = inventarios + 1
            WHERE n_de_referencia = cantidad;
        END LOOP;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER actualizar_stock_insert_update_delete_trigger
AFTER INSERT OR UPDATE OR DELETE ON PEDIDOS
FOR EACH ROW
EXECUTE FUNCTION actualizar_stock_insert_update_delete();

/*
TRIGGER 3. RECALCULAR TOTAL PEDIDO
	Tabla Afectada: Pedidos
	Operaciones: UPDATE
	Funcionalidad: Recalcula el monto total del pedido al actualizar un pedido.
	Razón: Asegura que el monto total del pedido sea siempre exacto, reflejando cualquier cambio en las cantidades o precios de los productos en el pedido. Esto es crucial para mantener la precisión en la facturación y el análisis financiero.
*/

CREATE OR REPLACE FUNCTION recalcular_total_pedido()
RETURNS TRIGGER AS $$
DECLARE
    nuevo_importe_total NUMERIC(8,2);
BEGIN
    nuevo_importe_total := (
        SELECT SUM(precio)
        FROM PRODUCTOS
        WHERE n_de_referencia IN (
            SELECT n_productos
            FROM Contenido
            WHERE n_pedidos = NEW.n_pedidos
        )
    );

    nuevo_importe_total := nuevo_importe_total + NEW.costo_envios;

    UPDATE PEDIDOS
    SET importe_total = nuevo_importe_total
    WHERE n_pedidos = NEW.n_pedidos;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_recalcular_total_pedido
AFTER UPDATE ON PEDIDOS
FOR EACH ROW
EXECUTE FUNCTION recalcular_total_pedido();

/*
TRIGGER 4: VALIDAR FORMATO TELÉFONO: 
	Tabla Afectada: Clientes
	Operaciones: INSERT, UPDATE
	Funcionalidad: Valida el formato del número de teléfono al insertar o actualizar un cliente.
	Razón: Garantiza la correcta formatearían de los números de teléfono, manteniendo la consistencia de los datos. Esto es importante para la comunicación eficiente con los clientes y para evitar pro-blemas de formato que podrían dificultar la gestión de contactos.
*/
CREATE OR REPLACE FUNCTION validar_formato_telefono() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.telefono ~ '^\d{3}-\d{3}-\d{4}$' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'El formato del número de teléfono debe ser ###-###-####';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validar_formato_telefono_trigger
BEFORE INSERT OR UPDATE ON CLIENTES
FOR EACH ROW EXECUTE FUNCTION validar_formato_telefono();

INSERT INTO CLIENTES (id, nombre, direccion, genero, telefono) VALUES ('C009', 'Cliente 9', 'Dirección Cliente 9', 'Femenino', '999999999');

INSERT INTO CLIENTES (id, nombre, direccion, genero, telefono) VALUES ('C010', 'Cliente 10', 'Dirección Cliente 10', 'Masculino', '1234');

