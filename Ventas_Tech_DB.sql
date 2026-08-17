IF DB_ID('Ventas_Tech_DB') IS NULL
BEGIN
    CREATE DATABASE Ventas_Tech_DB;
END
GO

USE Ventas_Tech_DB;
GO


-- =====================================================================
-- DROP TABLES (orden inverso de dependencias)
-- =====================================================================
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorios;

-- =====================================================================
-- CREATE TABLES
-- =====================================================================

-- Tabla categorias
CREATE TABLE categorias (
    id_categoria     INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion      VARCHAR(200)
);

-- Tabla territorios (NUEVA — M5: soporte para región en la vista de JOINs)
CREATE TABLE territorios (
    id_territorio INT PRIMARY KEY,
    ciudad        VARCHAR(50) NOT NULL,
    region        VARCHAR(50) NOT NULL
);

-- Tabla clientes (M5: se agregan segmento e id_territorio)
CREATE TABLE clientes (
    id_cliente     INT PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    email          VARCHAR(100) UNIQUE,
    ciudad         VARCHAR(50),
    fecha_registro DATE NOT NULL,
    segmento       VARCHAR(20),
    id_territorio  INT,
    CONSTRAINT fk_clientes_territorio
        FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);

-- Tabla productos
CREATE TABLE productos (
    id_producto     INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria    INT,
    precio          DECIMAL(10,2) NOT NULL,
    stock           INT DEFAULT 0,
    activo          SMALLINT DEFAULT 1,
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Tabla ventas (M5: se agrega canal)
CREATE TABLE ventas (
    id_venta        INT PRIMARY KEY,
    id_cliente      INT,
    id_producto     INT,
    cantidad        INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta     DATE NOT NULL,
    canal           VARCHAR(20) NOT NULL,
    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ventas_producto
        FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- =====================================================================
-- INSERT DATA (orden correcto: tablas sin dependencias primero)
-- =====================================================================

-- categorias (4 registros)
INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

-- territorios (5 registros — una región por ciudad de la base original)
INSERT INTO territorios VALUES (1, 'Buenos Aires', 'CABA / GBA');
INSERT INTO territorios VALUES (2, 'Córdoba',      'Centro');
INSERT INTO territorios VALUES (3, 'Rosario',      'Litoral');
INSERT INTO territorios VALUES (4, 'Mendoza',      'Cuyo');
INSERT INTO territorios VALUES (5, 'Tucumán',      'NOA');

-- clientes (6 registros — se agrega un cliente sin ventas para probar la Consulta 2 de M5)
INSERT INTO clientes VALUES (1, 'María López',     'maria@mail.com',  'Buenos Aires', '2024-01-05', 'Retail',      1);
INSERT INTO clientes VALUES (2, 'Carlos Ruiz',     'carlos@mail.com', 'Córdoba',      '2024-01-10', 'Corporativo', 2);
INSERT INTO clientes VALUES (3, 'Ana Gómez',       'ana@mail.com',    'Rosario',      '2024-02-01', 'Retail',      3);
INSERT INTO clientes VALUES (4, 'Pedro Sanz',      'pedro@mail.com',  'Mendoza',      '2024-02-15', 'Premium',     4);
INSERT INTO clientes VALUES (5, 'Laura Torres',    'laura@mail.com',  'Tucumán',      '2024-03-01', 'Corporativo', 5);
INSERT INTO clientes VALUES (6, 'Diego Fernández', 'diego@mail.com',  'Buenos Aires', '2024-03-05', 'Retail',      1);

-- productos (7 registros — se agrega un producto sin ventas para probar la Consulta 3 de M5)
INSERT INTO productos VALUES (1, 'Laptop Pro 15',      1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',  2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"',     1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro', 3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',    4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',   2,   95.00, 40, 1);
INSERT INTO productos VALUES (7, 'Webcam Full HD',     2,   60.00, 25, 1);

-- ventas (10 registros — se agrega canal Online/Presencial)
INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05', 'Online');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06', 'Presencial');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07', 'Online');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08', 'Presencial');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10', 'Online');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11', 'Presencial');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12', 'Online');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13', 'Presencial');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14', 'Online');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15', 'Presencial');

-- =====================================================================
-- VALIDACIÓN
-- =====================================================================
SELECT * FROM categorias;
SELECT * FROM territorios;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
