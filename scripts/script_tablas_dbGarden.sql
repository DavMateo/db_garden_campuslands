-- CREANDO Y USANDO LA BASE DE DATOS "garden"
DROP DATABASE IF EXISTS garden;
CREATE DATABASE IF NOT EXISTS garden;
USE garden;



/*
CREANDO LAS TABLAS PERTINENTES PARA LA BASE DE DATOS
SOBRE JARDINERÍA CON SUS RESPECTIVOS CONSTRAINTS
*/
-- CREANDO LAS TABLAS PARA "producto"
-- Creación de la tabla "gama"
CREATE TABLE IF NOT EXISTS gama(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre_gama VARCHAR(50) NOT NULL,
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(255),
    CONSTRAINT pk_gama PRIMARY KEY(id)
);

-- Creación de la tabla "tipo_identificacion"
CREATE TABLE IF NOT EXISTS tipo_identificacion (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion TEXT,
    CONSTRAINT pk_tipo_identificacion PRIMARY KEY(id)
);

-- Creación de la tabla "direcciones"
CREATE TABLE IF NOT EXISTS direcciones (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    linea_direccion1 VARCHAR(100) NOT NULL,
    linea_direccion2 VARCHAR(100),
    relacion_direccion ENUM('Cliente', 'Proveedor', 'Oficina') NOT NULL,
    CONSTRAINT pk_direcciones PRIMARY KEY(id)
);

-- Creación de la tabla "proveedor"
CREATE TABLE IF NOT EXISTS proveedor (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nro_identificacion INT NOT NULL,
    id_tipo_identificacion INT UNSIGNED NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    id_direcciones INT UNSIGNED NOT NULL,
    tipo_proveedor ENUM('Persona natural', 'Persona jurídica') NOT NULL,
    CONSTRAINT pk_proveedor PRIMARY KEY(id, id_tipo_identificacion, id_direcciones),
    CONSTRAINT fk_proveedor_id_tipo_identificacion FOREIGN KEY(id_tipo_identificacion) REFERENCES tipo_identificacion(id),
    CONSTRAINT fk_proveedor_id_direcciones FOREIGN KEY(id_direcciones) REFERENCES direcciones(id)
);

-- Creación de la tabla "producto"
CREATE TABLE IF NOT EXISTS producto (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_gama INT UNSIGNED NOT NULL,
    dimensiones VARCHAR(30),
    unidad_medida_dimensiones ENUM('mm', 'cm', 'm', 'in', 'ft', 'L', 'kg'),
    descripcion TEXT,
    cantidad_en_stock INT UNSIGNED NOT NULL,
    precio_venta DECIMAL(15, 2) NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY(id, id_gama),
    CONSTRAINT fk_producto_id_gama FOREIGN KEY(id_gama) REFERENCES gama(id)
);

-- Creación de la tabla intermedia "proveedor_producto"
CREATE TABLE IF NOT EXISTS proveedor_producto (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_proveedor INT UNSIGNED NOT NULL,
    id_producto INT UNSIGNED NOT NULL,
    precio_proveedor DECIMAL(15, 2) NOT NULL,
    CONSTRAINT pk_proveedor_producto PRIMARY KEY(id, id_proveedor, id_producto),
    CONSTRAINT fk_proveedor_producto_id_proveedor FOREIGN KEY(id_proveedor) REFERENCES proveedor(id),
    CONSTRAINT fk_proveedor_producto_id_producto FOREIGN KEY(id_producto) REFERENCES producto(id)
);


/* CREANDO LAS TABLAS PARA "oficina"  */
-- Creación de la tabla "tipo_moneda"
CREATE TABLE IF NOT EXISTS tipo_moneda (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    abreviatura CHAR(6) NOT NULL,
    simbologia CHAR(4),
    es_digital BIT NOT NULL,
    CONSTRAINT pk_tipo_moneda PRIMARY KEY(id)
);

-- Creación de la tabla "pais"
CREATE TABLE IF NOT EXISTS pais (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    abreviatura CHAR(6) NOT NULL,
    prefijo SMALLINT(3) NOT NULL,
    id_tipo_moneda INT UNSIGNED NOT NULL,
    CONSTRAINT pk_pais PRIMARY KEY(id),
    CONSTRAINT fk_pais_id_tipo_moneda FOREIGN KEY(id_tipo_moneda) REFERENCES tipo_moneda(id)
);

-- Creación de la tabla "region"
CREATE TABLE IF NOT EXISTS region (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(75) NOT NULL,
    id_pais INT UNSIGNED NOT NULL,
    CONSTRAINT pk_region PRIMARY KEY(id, id_pais),
    CONSTRAINT fk_region_id_pais FOREIGN KEY(id_pais) REFERENCES pais(id)
);

-- Creación de la tabla "ciudad"
CREATE TABLE IF NOT EXISTS ciudad (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(75) NOT NULL,
    es_capital BIT NOT NULL,
    id_region INT UNSIGNED NOT NULL,
    CONSTRAINT pk_ciudad PRIMARY KEY(id, id_region),
    CONSTRAINT fk_ciudad_id_region FOREIGN KEY(id_region) REFERENCES region(id)
);

-- Creación de la tabla "codigo_postal"
CREATE TABLE IF NOT EXISTS codigo_postal (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    codigo VARCHAR(15) NOT NULL,
    id_ciudad INT UNSIGNED NOT NULL,
    CONSTRAINT pk_codigo_postal PRIMARY KEY(id, id_ciudad),
    CONSTRAINT fk_codigo_postal_id_ciudad FOREIGN KEY(id_ciudad) REFERENCES ciudad(id)
);

-- Creación de la tabla "oficina"
CREATE TABLE IF NOT EXISTS oficina (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_ciudad INT UNSIGNED NOT NULL,
    nro_telefono INT NOT NUlL,
    extension VARCHAR(15) NOT NULL,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50),
    CONSTRAINT pk_oficina PRIMARY KEY(id, id_ciudad),
    CONSTRAINT fk_oficina_id_ciudad FOREIGN KEY(id_ciudad) REFERENCES ciudad(id)
);


/* CREANDO LAS TABLAS PARA "empleado"  */
-- Creación de la tabla "puesto"
CREATE TABLE IF NOT EXISTS puesto (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    CONSTRAINT pk_puesto PRIMARY KEY(id)
);

-- Creación de la tabla "tipo_telefono"
CREATE TABLE IF NOT EXISTS tipo_telefono (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion TEXT,
    CONSTRAINT pk_tipo_telefono PRIMARY KEY(id)
);

-- Creación de la tabla "telefono"
CREATE TABLE IF NOT EXISTS telefono (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_pais INT UNSIGNED NOT NULL,
    nro_telefono BIGINT NOT NULL,
    extension VARCHAR(10) NOT NULL,
    id_tipo_telefono INT UNSIGNED NOT NULL,
    CONSTRAINT pk_telefono PRIMARY KEY(id, id_tipo_telefono),
    CONSTRAINT fk_telefono_id_tipo_telefono FOREIGN KEY(id_tipo_telefono) REFERENCES tipo_telefono(id)
);

-- Creación de la tabla "email"
CREATE TABLE IF NOT EXISTS email (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre_usuario VARCHAR(100) NOT NULL,
    organizacion_dominio VARCHAR(45) NOT NULL,
    tipo_dominio VARCHAR(20) NOT NULL,
    CONSTRAINT pk_email PRIMARY KEY(id)
);

-- Creación de la tabla "contacto"
CREATE TABLE IF NOT EXISTS contacto (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_telefono INT UNSIGNED NOT NULL,
    id_email INT UNSIGNED,
    sitio_web VARCHAR(255),
    CONSTRAINT pk_contacto PRIMARY KEY(id, id_telefono),
    CONSTRAINT fk_contacto_id_telefono FOREIGN KEY(id_telefono) REFERENCES telefono(id),
    CONSTRAINT fk_contacto_id_email FOREIGN KEY(id_email) REFERENCES email(id)
);

-- Creación de la tabla "empleado"
CREATE TABLE IF NOT EXISTS empleado (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    primer_nombre VARCHAR(25) NOT NULL,
    segundo_nombre VARCHAR(25),
    primer_apellido VARCHAR(25) NOT NULL,
    segundo_apellido VARCHAR(25),
    id_oficina INT UNSIGNED,
    id_contacto INT UNSIGNED NOT NULL,
    codigo_jefe INT,
    id_puesto INT UNSIGNED,
    es_jefe BIT NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY(id, id_contacto, id_puesto),
    CONSTRAINT fk_empleado_id_oficina FOREIGN KEY(id_oficina) REFERENCES oficina(id),
    CONSTRAINT fk_empleado_id_contacto FOREIGN KEY(id_contacto) REFERENCES contacto(id),
    CONSTRAINT fk_empleado_id_puesto FOREIGN KEY(id_puesto) REFERENCES puesto(id)
);


/* CREANDO LAS TABLAS PARA "cliente"  */
-- Creación de la tabla "cliente"
CREATE TABLE IF NOT EXISTS cliente (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nro_identificacion INT UNSIGNED NOT NULL,
    id_tipo_identificacion INT UNSIGNED NOT NULL,
    id_empleado_rep_ventas INT(11) UNSIGNED,
    primer_nombre VARCHAR(25) NOT NULL,
    segundo_nombre VARCHAR(25),
    primer_apellido VARCHAR(25) NOT NULL,
    segundo_apellido VARCHAR(25),
    id_contacto INT UNSIGNED NOT NULL,
    fax VARCHAR(15) NOT NULL,
    id_direcciones INT UNSIGNED NOT NULL,
    id_ciudad INT UNSIGNED NOT NULL,
    limite_credito DECIMAL(15, 2),
    CONSTRAINT pk_cliente PRIMARY KEY(id, id_tipo_identificacion, id_contacto, id_direcciones, id_ciudad),
    CONSTRAINT fk_cliente_id_tipo_identificacion FOREIGN KEY(id_tipo_identificacion) REFERENCES tipo_identificacion(id),
    CONSTRAINT fk_cliente_id_empleado_rep_ventas FOREIGN KEY(id_empleado_rep_ventas) REFERENCES empleado(id),
    CONSTRAINT fk_cliente_id_contacto FOREIGN KEY(id_contacto) REFERENCES contacto(id),
    CONSTRAINT fk_cliente_id_direcciones FOREIGN KEY(id_direcciones) REFERENCES direcciones(id),
    CONSTRAINT fk_cliente_id_ciudad FOREIGN KEY(id_ciudad) REFERENCES ciudad(id)
);


/* CREANDO LAS TABLAS PARA "pago"  */
-- Creación de la tabla "forma_pago"
CREATE TABLE IF NOT EXISTS forma_pago (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    es_digital BIT NOT NULL,
    CONSTRAINT pk_forma_pago PRIMARY KEY(id)
);

-- Creación de la tabla "pago"
CREATE TABLE IF NOT EXISTS pago (
    id_transaccion VARCHAR(50) NOT NULL,
    id_cliente INT(11) UNSIGNED NOT NULL,
    id_forma_pago INT UNSIGNED NOT NULL,
    fecha_pago DATE NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    id_tipo_moneda INT UNSIGNED NOT NULL,
    CONSTRAINT pk_pago PRIMARY KEY(id_transaccion, id_cliente, id_forma_pago),
    CONSTRAINT fk_pago_id_cliente FOREIGN KEY(id_cliente) REFERENCES cliente(id),
    CONSTRAINT fk_pago_id_forma_pago FOREIGN KEY(id_forma_pago) REFERENCES forma_pago(id),
    CONSTRAINT fk_pago_id_tipo_moneda FOREIGN KEY(id_tipo_moneda) REFERENCES tipo_moneda(id)
);


/* CREANDO LAS TABLAS PARA "pedido" */
-- Creación de la tabla "estado"
CREATE TABLE IF NOT EXISTS estado (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion TEXT,
    CONSTRAINT pk_estado PRIMARY KEY(id)
);

-- Creación de la tabla "pedido"
CREATE TABLE IF NOT EXISTS pedido (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    fecha_pedido DATE NOT NULL,
    fecha_entrega_esperada DATE NOT NULL,
    fecha_entrega DATE,
    comentarios TEXT,
    id_cliente INT UNSIGNED NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY(id, id_cliente),
    CONSTRAINT fk_pedido_id_cliente FOREIGN KEY(id_cliente) REFERENCES cliente(id)
);

-- Creación de la tabla intermedia "detalle_pedido"
CREATE TABLE IF NOT EXISTS detalle_pedido (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nro_factura INT UNSIGNED NOT NULL,
    id_producto INT UNSIGNED NOT NULL,
    id_pedido INT UNSIGNED NOT NULL,
    id_pago VARCHAR(50) NOT NULL,
    cantidad INT(11) NOT NULL,
    precio_unidad DECIMAL(15, 2) NOT NULL,
    numero_linea SMALLINT(6) NOT NULL,
    precio_iva SMALLINT(3) NOT NULL,
    fecha_generado DATETIME NOT NULL,
    fecha_expedido DATETIME NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    descripcion TEXT,
    CONSTRAINT pk_detalle_pedido PRIMARY KEY(id, id_producto, id_pedido, id_pago),
    CONSTRAINT fk_detalle_pedido_id_producto FOREIGN KEY(id_producto) REFERENCES producto(id),
    CONSTRAINT fk_detalle_pedido_id_pedido FOREIGN KEY(id_pedido) REFERENCES pedido(id),
    CONSTRAINT fk_detalle_pedido_id_pago FOREIGN KEY(id_pago) REFERENCES pago(id_transaccion)
);

-- Creación de la tabla intermedia "pedido_estado"
CREATE TABLE IF NOT EXISTS pedido_estado (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_pedido INT UNSIGNED NOT NULL,
    id_estado INT UNSIGNED NOT NULL,
    fecha_estado DATETIME NOT NULL,
    notas TEXT DEFAULT NULL,
    CONSTRAINT pk_pedido_estado PRIMARY KEY(id, id_pedido, id_estado),
    CONSTRAINT fk_pedido_estado_id_pedido FOREIGN KEY(id_pedido) REFERENCES pedido(id),
    CONSTRAINT fk_pedido_estado_id_estado FOREIGN KEY(id_estado) REFERENCES estado(id)
);