CREATE DATABASE Ventas_Tech_DB; 

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

CREATE TABLE dbo.DimCategorias (
    id_Categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripción VARCHAR(200)

);

CREATE TABLE dbo.DimClientes (
       id_Cliente INT PRIMARY KEY,
       nombre_cliente VARCHAR(100) NOT NULL,
       email VARCHAR (100) NOT NULL,
       ciudad VARCHAR (50) NOT NULL,
       fecha_registro DATE NOT NULL

       );
CREATE TABLE dbo.DimProductos (
       id_Producto INT PRIMARY KEY,
       nombre_producto VARCHAR (100) NOT NULL,
       id_categoria INT FOREIGN KEY (id_Categoria) REFERENCES dbo.DimCategorias (id_Categoria),
       precio DECIMAL(10,2) NOT NULL,
       stock INT DEFAULT 0,
       activo TINYINT DEFAULT 1
       );

CREATE TABLE dbo.DimVentas (
      id_Venta INT PRIMARY KEY,
      id_Cliente INT FOREIGN KEY (id_Cliente) REFERENCES dbo.DimClientes (id_Cliente),
      id_Producto INT FOREIGN KEY (id_Producto) REFERENCES dbo.DimProductos (id_Producto),
      cantidad INT NOT NULL,
      precio_unitario DECIMAL(10,2) NOT NULL,
      fecha_venta DATE NOT NULL
      );


      INSERT INTO  dbo.DimCategorias VALUES (1, 'Computación', 'Laptops, PCs y Monitores');
      INSERT INTO  dbo.DimCategorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
      INSERT INTO  dbo.DimCategorias VALUES (3, 'Audio', 'Auriculares y parlantes');
      INSERT INTO  dbo.DimCategorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

      INSERT INTO dbo.DimClientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
      INSERT INTO dbo.DimClientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
      INSERT INTO dbo.DimClientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
      INSERT INTO dbo.DimClientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
      INSERT INTO dbo.DimClientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

      INSERT INTO dbo.DimProductos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
      INSERT INTO dbo.DimProductos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
      INSERT INTO dbo.DimProductos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
      INSERT INTO dbo.DimProductos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
      INSERT INTO dbo.DimProductos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
      INSERT INTO dbo.DimProductos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);

      INSERT INTO dbo.DimVentas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO dbo.DimVentas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO dbo.DimVentas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO dbo.DimVentas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO dbo.DimVentas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO dbo.DimVentas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO dbo.DimVentas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO dbo.DimVentas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO dbo.DimVentas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO dbo.DimVentas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');

-- Confirmá que cada tabla se cargó correctamente
SELECT * FROM dbo.DimCategorias;
SELECT * FROM dbo.DimClientes;
SELECT * FROM dbo.Dimproductos;
SELECT * FROM dbo.DimVentas;
-- (Más adelante, en el Módulo 5, vas a poder cruzar estas tablas con JOIN
--  para ver las ventas junto al nombre del cliente y del producto.
--  Por ahora alcanza con confirmar que las 4 tablas tienen sus datos.)