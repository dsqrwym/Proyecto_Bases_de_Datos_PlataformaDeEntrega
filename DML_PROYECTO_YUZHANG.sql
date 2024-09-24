-- Insertar datos en FONDOS
INSERT INTO FONDOS (codigo, cantidad, fecha_horas)
VALUES 
  ('F001', 1000.00, '2023-03-10 10:00:00'),
  ('F002', 1500.00, '2023-03-11 11:30:00'),
  ('F003', 2000.00, '2023-03-12 14:45:00'),
  ('F004', 1200.00, '2023-03-13 16:20:00'),
  ('F005', 1800.00, '2023-03-14 18:10:00'),
  ('F006', 2200.00, '2023-03-15 20:40:00'),
  ('F007', 1600.00, '2023-03-16 22:15:00'),
  ('F008', 1900.00, '2023-03-17 23:50:00');

-- Insertar datos en TIENDAS
INSERT INTO TIENDAS (nif, nombre, categoria, direccion, cuenta_bancaria, ventas, codigo_fondos)
VALUES 
  ('T001', 'Tienda 1', 'Electrónica', 'Dirección Tienda 1', 'ES01234567890123456789', 500.00, 'F001'),
  ('T002', 'Tienda 2', 'Ropa', 'Dirección Tienda 2', 'ES12345678901234567890', 600.00, 'F002'),
  ('T003', 'Tienda 3', 'Juguetes', 'Dirección Tienda 3', 'ES23456789012345678901', 750.00, 'F003'),
  ('T004', 'Tienda 4', 'Libros', 'Dirección Tienda 4', 'ES34567890123456789012', 400.00, 'F004'),
  ('T005', 'Tienda 5', 'Deportes', 'Dirección Tienda 5', 'ES45678901234567890123', 450.00, 'F005'),
  ('T006', 'Tienda 6', 'Hogar', 'Dirección Tienda 6', 'ES56789012345678901234', 550.00, 'F006'),
  ('T007', 'Tienda 7', 'Alimentos', 'Dirección Tienda 7', 'ES67890123456789012345', 650.00, 'F007'),
  ('T008', 'Tienda 8', 'Moda', 'Dirección Tienda 8', 'ES78901234567890123456', 475.00, 'F008');

-- Insertar datos en ALMACEN
INSERT INTO ALMACEN (codigo_almacen, direccion, tamanio)
VALUES 
  ('A001', 'Dirección Almacén A', 500.00),
  ('A002', 'Dirección Almacén B', 700.00),
  ('A003', 'Dirección Almacén C', 900.00),
  ('A004', 'Dirección Almacén D', 600.00),
  ('A005', 'Dirección Almacén E', 800.00),
  ('A006', 'Dirección Almacén F', 1000.00),
  ('A007', 'Dirección Almacén G', 1200.00),
  ('A008', 'Dirección Almacén H', 950.00);

-- Insertar datos en PRODUCTOS
INSERT INTO PRODUCTOS (n_de_referencia, nombre, categoria, precio, inventarios, nif_tiendas, codigo_almacen)
VALUES 
  ('P001', 'Producto 1', 'Electrónica', 150.00, 100, 'T001', 'A001'),
  ('P002', 'Producto 2', 'Ropa', 45.00, 120, 'T002', 'A002'),
  ('P003', 'Producto 3', 'Juguetes', 20.00, 80, 'T003', 'A003'),
  ('P004', 'Producto 4', 'Libros', 30.00, 50, 'T004', 'A004'),
  ('P005', 'Producto 5', 'Deportes', 80.00, 60, 'T005', 'A005'),
  ('P006', 'Producto 6', 'Hogar', 60.00, 90, 'T006', 'A006'),
  ('P007', 'Producto 7', 'Alimentos', 25.00, 75, 'T007', 'A007'),
  ('P008', 'Producto 8', 'Moda', 70.00, 110, 'T008', 'A008');

-- Insertar datos en Modificar
INSERT INTO Modificar (codigo_almacen, n_productos, fecha_hora)
VALUES 
  ('A001', 'P001', '2023-03-10 12:00:00'),
  ('A002', 'P002', '2023-03-11 14:30:00'),
  ('A003', 'P003', '2023-03-12 16:45:00'),
  ('A004', 'P004', '2023-03-13 18:20:00'),
  ('A005', 'P005', '2023-03-14 20:15:00'),
  ('A006', 'P006', '2023-03-15 22:40:00'),
  ('A007', 'P007', '2023-03-16 24:00:00'),
  ('A008', 'P008', '2023-03-17 02:30:00');

-- Insertar datos en PROVEEDOR
INSERT INTO PROVEEDOR (nif, direccion, telefono, nombre, email)
VALUES 
  ('PR001', 'Dirección Proveedor 1', '111111111', 'Proveedor 1', 'proveedor1@example.com'),
  ('PR002', 'Dirección Proveedor 2', '222222222', 'Proveedor 2', 'proveedor2@example.com'),
  ('PR003', 'Dirección Proveedor 3', '333333333', 'Proveedor 3', 'proveedor3@example.com'),
  ('PR004', 'Dirección Proveedor 4', '444444444', 'Proveedor 4', 'proveedor4@example.com'),
  ('PR005', 'Dirección Proveedor 5', '555555555', 'Proveedor 5', 'proveedor5@example.com'),
  ('PR006', 'Dirección Proveedor 6', '666666666', 'Proveedor 6', 'proveedor6@example.com'),
  ('PR007', 'Dirección Proveedor 7', '777777777', 'Proveedor 7', 'proveedor7@example.com'),
  ('PR008', 'Dirección Proveedor 8', '888888888', 'Proveedor 8', 'proveedor8@example.com');

-- Insertar datos en Suministrar
INSERT INTO Suministrar (nif_proveedor, codigo_almacen, n_productos, fecha)
VALUES 
  ('PR001', 'A001', 'P001', '2023-03-10'),
  ('PR002', 'A002', 'P002', '2023-03-11'),
  ('PR003', 'A003', 'P003', '2023-03-12'),
  ('PR004', 'A004', 'P004', '2023-03-13'),
  ('PR005', 'A005', 'P005', '2023-03-14'),
  ('PR006', 'A006', 'P006', '2023-03-15'),
  ('PR007', 'A007', 'P007', '2023-03-16'),
  ('PR008', 'A008', 'P008', '2023-03-17');

-- Insertar datos en CLIENTES
INSERT INTO CLIENTES (id, nombre, direccion, genero, telefono)
VALUES 
  ('C001', 'Cliente 1', 'Dirección Cliente 1', 'Femenino', '111-111-1111'),
  ('C002', 'Cliente 2', 'Dirección Cliente 2', 'Masculino', '222-222-2222'),
  ('C003', 'Cliente 3', 'Dirección Cliente 3', 'Desconocido', '333-333-3333'),
  ('C004', 'Cliente 4', 'Dirección Cliente 4', 'Femenino', '444-444-4444'),
  ('C005', 'Cliente 5', 'Dirección Cliente 5', 'Masculino', '555-555-5555'),
  ('C006', 'Cliente 6', 'Dirección Cliente 6', 'Desconocido', '666-666-6666'),
  ('C007', 'Cliente 7', 'Dirección Cliente 7', 'Femenino', '777-777-7777'),
  ('C008', 'Cliente 8', 'Dirección Cliente 8', 'Masculino', '888-888-8888');

-- Insertar datos en Visitar
INSERT INTO Visitar (nif_tiendas, id_clientes, fechas, veces)
VALUES 
  ('T001', 'C001', '2023-03-10', 2),
  ('T002', 'C002', '2023-03-11', 3),
  ('T003', 'C003', '2023-03-12', 1),
  ('T004', 'C004', '2023-03-13', 4),
  ('T005', 'C005', '2023-03-14', 2),
  ('T006', 'C006', '2023-03-15', 3),
  ('T007', 'C007', '2023-03-16', 1),
  ('T008', 'C008', '2023-03-17', 4);

-- Insertar datos en PEDIDOS
INSERT INTO PEDIDOS (n_pedidos, importe_total, fecha_hora, costo_envios, notas, id_cliente)
VALUES 
  ('PED001', 200.00, '2023-03-10 12:30:00', 10.00, 'Notas Pedido 1', 'C001'),
  ('PED002', 180.00, '2023-03-11 14:45:00', 8.00, 'Notas Pedido 2', 'C002'),
  ('PED003', 220.00, '2023-03-12 16:20:00', 12.00, 'Notas Pedido 3', 'C003'),
  ('PED004', 150.00, '2023-03-13 18:10:00', 7.00, 'Notas Pedido 4', 'C004'),
  ('PED005', 190.00, '2023-03-14 20:40:00', 9.00, 'Notas Pedido 5', 'C005'),
  ('PED006', 210.00, '2023-03-15 22:15:00', 11.00, 'Notas Pedido 6', 'C006'),
  ('PED007', 175.00, '2023-03-16 23:50:00', 8.50, 'Notas Pedido 7', 'C007'),
  ('PED008', 200.00, '2023-03-17 02:25:00', 10.00, 'Notas Pedido 8', 'C008');

-- Insertar datos en Contenido
INSERT INTO Contenido (n_pedidos, n_productos)
VALUES 
  ('PED001', 'P001'),
  ('PED002', 'P002'),
  ('PED003', 'P003'),
  ('PED004', 'P004'),
  ('PED005', 'P005'),
  ('PED006', 'P006'),
  ('PED007', 'P007'),
  ('PED008', 'P008');

-- Insertar datos en COMENTARIOS
INSERT INTO COMENTARIOS (n_comentarios, fecha_hora, valoracion, n_pedidos, id_cliente)
VALUES 
  ('COM001', '2023-03-10 14:00:00', 4.5, 'PED001', 'C001'),
  ('COM002', '2023-03-11 15:30:00', 4.0, 'PED002', 'C002'),
  ('COM003', '2023-03-12 17:45:00', 3.5, 'PED003', 'C003'),
  ('COM004', '2023-03-13 19:20:00', 5.0, 'PED004', 'C004'),
  ('COM005', '2023-03-14 21:15:00', 4.0, 'PED005', 'C005'),
  ('COM006', '2023-03-15 23:40:00', 3.5, 'PED006', 'C006'),
  ('COM007', '2023-03-16 01:00:00', 4.5, 'PED007', 'C007'),
  ('COM008', '2023-03-17 03:30:00', 5.0, 'PED008', 'C008');

-- Insertar datos en METODO_DE_PAGO
INSERT INTO METODO_DE_PAGO (n_de_pago, fecha_hora, n_pedidos)
VALUES 
  ('MP001', '2023-03-10 14:30:00', 'PED001'),
  ('MP002', '2023-03-11 16:00:00', 'PED002'),
  ('MP003', '2023-03-12 17:30:00', 'PED003'),
  ('MP004', '2023-03-13 19:10:00', 'PED004'),
  ('MP005', '2023-03-14 21:45:00', 'PED005'),
  ('MP006', '2023-03-15 23:20:00', 'PED006'),
  ('MP007', '2023-03-17 00:45:00', 'PED007'),
  ('MP008', '2023-03-17 03:15:00', 'PED008');

-- Insertar datos en REPARTIDOR
INSERT INTO REPARTIDOR (dni, nombre_completo, telefono, domicilio, salario, codigo_fondo, cantidad_ingresar)
VALUES 
  ('R001', 'Repartidor 1', '111-111-1111', 'Dirección Repartidor 1', 1200.00, 'F001', 300.00),
  ('R002', 'Repartidor 2', '222-222-2222', 'Dirección Repartidor 2', 1100.00, 'F002', 280.00),
  ('R003', 'Repartidor 3', '333-333-3333', 'Dirección Repartidor 3', 1300.00, 'F003', 320.00),
  ('R004', 'Repartidor 4', '444-444-4444', 'Dirección Repartidor 4', 1250.00, 'F004', 310.00),
  ('R005', 'Repartidor 5', '555-555-5555', 'Dirección Repartidor 5', 1400.00, 'F005', 350.00),
  ('R006', 'Repartidor 6', '666-666-6666', 'Dirección Repartidor 6', 1350.00, 'F006', 340.00),
  ('R007', 'Repartidor 7', '777-777-7777', 'Dirección Repartidor 7', 1500.00, 'F007', 380.00),
  ('R008', 'Repartidor 8', '888-888-8888', 'Dirección Repartidor 8', 1450.00, 'F008', 370.00);

-- Insertar datos en Sustituir
INSERT INTO Sustituir (repartidor1, repartidor2, fecha_start, fecha_end)
VALUES 
  ('R001', 'R002', '2023-03-10 15:00:00', '2023-03-11 12:00:00'),
  ('R002', 'R003', '2023-03-11 16:30:00', '2023-03-12 14:30:00'),
  ('R003', 'R004', '2023-03-12 18:00:00', '2023-03-13 16:00:00'),
  ('R004', 'R005', '2023-03-13 20:30:00', '2023-03-14 18:30:00'),
  ('R005', 'R006', '2023-03-14 22:00:00', '2023-03-15 20:00:00'),
  ('R006', 'R007', '2023-03-15 23:30:00', '2023-03-16 21:30:00'),
  ('R007', 'R008', '2023-03-17 01:00:00', '2023-03-17 22:00:00'),
  ('R008', 'R001', '2023-03-17 03:30:00', '2023-03-18 01:30:00');

-- Insertar datos en EFECTIVO
INSERT INTO EFECTIVO (n_de_pago, dni_repartidor, cantidad, fecha)
VALUES 
  ('MP001', 'R001', 50.00, '2023-03-10'),
  ('MP002', 'R002', 45.00, '2023-03-11'),
  ('MP003', 'R003', 60.00, '2023-03-12'),
  ('MP004', 'R004', 55.00, '2023-03-13'),
  ('MP005', 'R005', 70.00, '2023-03-14'),
  ('MP006', 'R006', 65.00, '2023-03-15'),
  ('MP007', 'R007', 80.00, '2023-03-16'),
  ('MP008', 'R008', 75.00, '2023-03-17');

-- Insertar datos en TARJETA
INSERT INTO TARJETA (n_de_pago, n_tarjeta, fecha, codigo_fondo, cantidad)
VALUES 
  ('MP001', '1111222233334444', '2023-03-10', 'F001', 150.00),
  ('MP002', '2222333344445555', '2023-03-11', 'F002', 140.00),
  ('MP003', '3333444455556666', '2023-03-12', 'F003', 160.00),
  ('MP004', '4444555566667777', '2023-03-13', 'F004', 155.00),
  ('MP005', '5555666677778888', '2023-03-14', 'F005', 170.00),
  ('MP006', '6666777788889999', '2023-03-15', 'F006', 165.00),
  ('MP007', '7777888899990000', '2023-03-17', 'F007', 180.00),
  ('MP008', '8888999900001111', '2023-03-17', 'F008', 175.00);

-- Insertar datos en Seleccionar
INSERT INTO Seleccionar (n_pedidos, id_cliente, n_de_pago)
VALUES 
  ('PED001', 'C001', 'MP001'),
  ('PED002', 'C002', 'MP002'),
  ('PED003', 'C003', 'MP003'),
  ('PED004', 'C004', 'MP004'),
  ('PED005', 'C005', 'MP005'),
  ('PED006', 'C006', 'MP006'),
  ('PED007', 'C007', 'MP007'),
  ('PED008', 'C008', 'MP008');

-- Insertar datos en Quejar
INSERT INTO Quejar (nif_tiendas, dni_repartidor, fecha, causa)
VALUES 
  ('T001', 'R001', '2023-03-10', 'Causa 1'),
  ('T002', 'R002', '2023-03-11', 'Causa 2'),
  ('T003', 'R003', '2023-03-12', 'Causa 3'),
  ('T004', 'R004', '2023-03-13', 'Causa 4'),
  ('T005', 'R005', '2023-03-14', 'Causa 5'),
  ('T006', 'R006', '2023-03-15', 'Causa 6'),
  ('T007', 'R007', '2023-03-16', 'Causa 7'),
  ('T008', 'R008', '2023-03-17', 'Causa 8');

-- Insertar datos en PAQUETES
INSERT INTO PAQUETES (codigo_de_paquetes, dirección_inicial, destino, notas, n_pedidos, id_cliente)
VALUES 
  ('PQ001', 'Dirección Inicial 1', 'Destino 1', 'Notas Paquete 1', 'PED001', 'C001'),
  ('PQ002', 'Dirección Inicial 2', 'Destino 2', 'Notas Paquete 2', 'PED002', 'C002'),
  ('PQ003', 'Dirección Inicial 3', 'Destino 3', 'Notas Paquete 3', 'PED003', 'C003'),
  ('PQ004', 'Dirección Inicial 4', 'Destino 4', 'Notas Paquete 4', 'PED004', 'C004'),
  ('PQ005', 'Dirección Inicial 5', 'Destino 5', 'Notas Paquete 5', 'PED005', 'C005'),
  ('PQ006', 'Dirección Inicial 6', 'Destino 6', 'Notas Paquete 6', 'PED006', 'C006'),
  ('PQ007', 'Dirección Inicial 7', 'Destino 7', 'Notas Paquete 7', 'PED007', 'C007'),
  ('PQ008', 'Dirección Inicial 8', 'Destino 8', 'Notas Paquete 8', 'PED008', 'C008');

-- Insertar datos en Designar
INSERT INTO Designar (dni_repartidor, codigo_de_paquetes)
VALUES 
  ('R001', 'PQ001'),
  ('R002', 'PQ002'),
  ('R003', 'PQ003'),
  ('R004', 'PQ004'),
  ('R005', 'PQ005'),
  ('R006', 'PQ006'),
  ('R007', 'PQ007'),
  ('R008', 'PQ008');

-- Insertar datos en ESTADO
INSERT INTO ESTADO (id_estado, nombre, fecha_hora, ubicación)
VALUES 
  ('E001', 'En Almacén', '2023-03-10 10:00:00', 'Almacén A'),
  ('E002', 'En Ruta', '2023-03-11 12:00:00', 'Camino a Destino 2'),
  ('E003', 'Entregado', '2023-03-12 14:00:00', 'Destino 3'),
  ('E004', 'En Almacén', '2023-03-13 16:00:00', 'Almacén D'),
  ('E005', 'En Ruta', '2023-03-14 18:00:00', 'Camino a Destino 5'),
  ('E006', 'Entregado', '2023-03-15 20:00:00', 'Destino 6'),
  ('E007', 'En Almacén', '2023-03-16 22:00:00', 'Almacén G'),
  ('E008', 'En Ruta', '2023-03-17 23:30:00', 'Camino a Destino 8');

-- Insertar datos en Tener
INSERT INTO Tener (id_estado, dni_repartidor, codigo_de_paquetes)
VALUES 
  ('E001', 'R001', 'PQ001'),
  ('E002', 'R002', 'PQ002'),
  ('E003', 'R003', 'PQ003'),
  ('E004', 'R004', 'PQ004'),
  ('E005', 'R005', 'PQ005'),
  ('E006', 'R006', 'PQ006'),
  ('E007', 'R007', 'PQ007'),
  ('E008', 'R008', 'PQ008');
