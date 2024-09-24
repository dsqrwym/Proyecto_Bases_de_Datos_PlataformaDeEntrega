CREATE TABLE FONDOS(
	codigo varchar(10),
	cantidad numeric(8,2) CHECK (cantidad > 0),
	fecha_horas timestamp NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE TIENDAS(
	nif varchar(9),
	nombre varchar(50) NOT NULL,
	categoria varchar(30) DEFAULT 'Otros',
	direccion varchar(50),
	cuenta_bancaria varchar(30) NOT NULL,
	ventas numeric(10) CHECK (ventas >= 0),
	codigo_fondos varchar(10),
	PRIMARY KEY(nif),
	FOREIGN KEY(codigo_fondos) REFERENCES FONDOS(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ALMACEN(
	codigo_almacen varchar(6),
	direccion varchar(50) NOT NULL,
	tamanio numeric(10,2) NOT NULL,
	PRIMARY KEY (codigo_almacen)
);

CREATE TABLE PRODUCTOS(
	n_de_referencia varchar(10),
	nombre varchar(50),
	categoria varchar(30) DEFAULT 'Otros',
	precio numeric(8,2) CHECK(precio >= 0),
	inventarios numeric(6) CHECK(inventarios >= 0),
	nif_tiendas varchar(9) NOT NULL,
	codigo_almacen varchar(6) NOT NULL,
	PRIMARY KEY (n_de_referencia),
	FOREIGN KEY (nif_tiendas) REFERENCES TIENDAS(nif) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (codigo_almacen) REFERENCES ALMACEN(codigo_almacen) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Modificar(
	codigo_almacen varchar(6),
	n_productos varchar(10),
	fecha_hora timestamp,
	PRIMARY KEY(codigo_almacen, n_productos),
	FOREIGN KEY(codigo_almacen) REFERENCES ALMACEN(codigo_almacen) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(n_productos) REFERENCES PRODUCTOS(n_de_referencia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PROVEEDOR(
	nif varchar(9),
	direccion varchar(50),
	telefono varchar(15) NOT NULL,
	nombre varchar(50) NOT NULL,
	email varchar(50),
	PRIMARY KEY(nif)
);

CREATE TABLE Suministrar(
	nif_proveedor varchar(9),
	codigo_almacen varchar(6),
	n_productos varchar(10),
	fecha date,
	PRIMARY KEY(nif_proveedor, codigo_almacen, n_productos)
);
ALTER TABLE Suministrar
ADD FOREIGN KEY(nif_proveedor) REFERENCES PROVEEDOR(nif) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY(codigo_almacen) REFERENCES ALMACEN(codigo_almacen) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY(n_productos) REFERENCES PRODUCTOS(n_de_referencia) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE CLIENTES(
	id varchar(9),
	nombre varchar(50) NOT NULL,
	direccion varchar(50),
	genero varchar(11) DEFAULT 'Desconocido',
	telefono varchar(15),
	PRIMARY KEY(id)
);

CREATE TABLE Visitar(
	nif_tiendas varchar(9),
	id_clientes varchar(9),
	fechas date NOT NULL,
	veces numeric(6) CHECK(veces > 0),
	PRIMARY KEY(nif_tiendas, id_clientes),
	FOREIGN KEY(id_clientes) REFERENCES CLIENTES(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(nif_tiendas) REFERENCES TIENDAS(nif) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PEDIDOS(
	n_pedidos varchar(20),
	importe_total numeric(8,2) CHECK(importe_total > -1),
	fecha_hora timestamp NOT NULL,
	costo_envios numeric(5,2) CHECK(costo_envios > -1),
	notas varchar(100),
	id_cliente varchar(9) NOT NULL,
	PRIMARY KEY(n_pedidos),
	FOREIGN KEY(id_cliente) REFERENCES CLIENTES(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Contenido(
	n_pedidos varchar(20),
	n_productos varchar(10),
	PRIMARY KEY(n_pedidos, n_productos),
	FOREIGN KEY(n_pedidos) REFERENCES PEDIDOS(n_pedidos) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(n_productos) REFERENCES PRODUCTOS(n_de_referencia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE COMENTARIOS(
	n_comentarios varchar(10), 
	fecha_hora timestamp NOT NULL,
	valoracion numeric(2,1) CHECK(valoracion BETWEEN 0 AND 5) DEFAULT 5,
	n_pedidos varchar(20),
	id_cliente varchar(9),
	PRIMARY KEY(n_comentarios),
	UNIQUE(n_pedidos,id_cliente),
	FOREIGN KEY(n_pedidos) REFERENCES PEDIDOS(n_pedidos) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY(id_cliente) REFERENCES CLIENTES(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE METODO_DE_PAGO(
	n_de_pago varchar(10), 
	fecha_hora timestamp,
	n_pedidos varchar(20),
	PRIMARY KEY(n_de_pago),
	UNIQUE(n_pedidos),
	FOREIGN KEY(n_pedidos) REFERENCES PEDIDOS(n_pedidos) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE REPARTIDOR(
	dni varchar(9), 
	nombre_completo varchar(50) NOT NULL, 
	telefono varchar(15) NOT NULL, 
	domicilio varchar(50) NOT NULL, 
	salario numeric(6,2), 
	codigo_fondo varchar(10),
	cantidad_ingresar numeric(8,2),
	PRIMARY KEY(dni),
	FOREIGN KEY(codigo_fondo) REFERENCES FONDOS(codigo)
);

CREATE TABLE Sustituir(
	repartidor1 varchar(9), 
	repartidor2 varchar(9),
	fecha_start timestamp NOT NULL,
	fecha_end timestamp,
	PRIMARY KEY(repartidor1),
	UNIQUE(repartidor2),
	FOREIGN KEY(repartidor1) REFERENCES REPARTIDOR(dni) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(repartidor2) REFERENCES REPARTIDOR(dni) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE EFECTIVO(
	n_de_pago varchar(10), 
	dni_repartidor varchar(9),
	cantidad numeric(6,2) CHECK(cantidad BETWEEN 0 AND 1000),
	fecha date NOT NULL,
	PRIMARY KEY(n_de_pago),
	FOREIGN KEY(dni_repartidor) REFERENCES REPARTIDOR(dni) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(n_de_pago) REFERENCES METODO_DE_PAGO(n_de_pago) ON DELETE CASCADE
);

CREATE TABLE TARJETA(
	n_de_pago varchar(10),
	n_tarjeta varchar(19) CHECK(LENGTH(n_tarjeta) BETWEEN 13 AND 19),
	fecha date,
	codigo_fondo varchar(10) NOT NULL,
	cantidad numeric(8,2),
	PRIMARY KEY(n_de_pago, n_tarjeta, fecha),
	FOREIGN KEY(n_de_pago) REFERENCES METODO_DE_PAGO(n_de_pago) ON DELETE CASCADE,
	FOREIGN KEY(codigo_fondo) REFERENCES FONDOS(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Seleccionar(
	n_pedidos varchar(20),
	id_cliente varchar(9),
	n_de_pago varchar(10),
	PRIMARY KEY(n_pedidos),
	UNIQUE(n_de_pago, id_cliente),
	FOREIGN KEY(id_cliente) REFERENCES CLIENTES(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(n_pedidos) REFERENCES PEDIDOS(n_pedidos) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(n_de_pago) REFERENCES METODO_DE_PAGO(n_de_pago) ON DELETE CASCADE ON UPDATE CASCADE
);
	
CREATE TABLE Quejar(
	nif_tiendas varchar(9),
	dni_repartidor varchar(9), 
	fecha date NOT NULL, 
	causa varchar(500) NOT NULL,
	PRIMARY KEY(nif_tiendas, dni_repartidor),
	FOREIGN KEY(nif_tiendas) REFERENCES TIENDAS(nif),
	FOREIGN KEY(dni_repartidor) REFERENCES REPARTIDOR(dni)
);

CREATE TABLE PAQUETES(
	codigo_de_paquetes varchar(12), 
	dirección_inicial varchar(50), 
	destino varchar(50), 
	notas varchar(200), 
	n_pedidos varchar(10), 
	id_cliente varchar(9),
	PRIMARY KEY(codigo_de_paquetes),
	UNIQUE(n_pedidos, id_cliente),
	FOREIGN KEY(n_pedidos) REFERENCES PEDIDOS(n_pedidos) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(id_cliente) REFERENCES CLIENTES(id) ON DELETE CASCADE ON UPDATE CASCADE
);
	
CREATE TABLE Designar(
	dni_repartidor varchar(9), 
	codigo_de_paquetes varchar(12),
	PRIMARY KEY(dni_repartidor, codigo_de_paquetes),
	FOREIGN KEY(dni_repartidor) REFERENCES REPARTIDOR(dni) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(codigo_de_paquetes) REFERENCES PAQUETES(codigo_de_paquetes) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ESTADO(
	id_estado varchar(6),
	nombre varchar(20), 
	fecha_hora timestamp, 
	ubicación varchar(50),
	PRIMARY KEY (id_estado)
);

CREATE TABLE Tener(
	id_estado varchar(6), 
	dni_repartidor varchar(9), 
	codigo_de_paquetes varchar(12),
	PRIMARY KEY(id_estado, dni_repartidor, codigo_de_paquetes),
	FOREIGN KEY(id_estado) REFERENCES ESTADO(id_estado),
	FOREIGN KEY(dni_repartidor, codigo_de_paquetes) REFERENCES Designar(dni_repartidor, codigo_de_paquetes) ON DELETE CASCADE ON UPDATE CASCADE
);
	
CREATE TABLE Consultar(
	id_cliente varchar(9), 
	id_estado varchar(6),
	PRIMARY KEY (id_cliente, id_estado),
	FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_estado) REFERENCES ESTADO(id_estado) ON DELETE CASCADE ON UPDATE CASCADE
);