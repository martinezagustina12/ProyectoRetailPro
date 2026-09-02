--consulta 1

    SELECT
    v.fecha_venta AS fecha,
    c.nombre_cliente AS nombre_cliente,
    c.ciudad AS ciudad,
    
    -- 1. Dimensión Región (derivada de la ciudad del cliente)
    CASE 
        WHEN c.ciudad IN ('Buenos Aires', 'CABA', 'La Plata') THEN 'Centro'
        WHEN c.ciudad IN ('Córdoba', 'Rosario', 'Mendoza') THEN 'Interior'
        ELSE 'Otras Regiones'
    END AS region,

    -- 2. Dimensión Segmento (derivada de la fecha de registro del cliente)
    CASE 
        WHEN c.fecha_registro < '2023-01-01' THEN 'Cliente Frecuente'
        ELSE 'Cliente Nuevo'
    END AS segmento,

    -- 3. Dimensión Canal (literal de origen)
    'Presencial' AS canal,

    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_facturado

FROM Ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_Producto = p.id_Producto
INNER JOIN Categorias AS cat
    ON p.id_categoria = cat.id_Categoria;


--CONSULTA 2

SELECT 
      c.nombre_cliente,
      c.email,
      c.fecha_registro
      FROM Clientes as c
      LEFT JOIN ventas as v
      ON c.id_cliente = v.id_cliente
      WHERE v.id_cliente IS NULL;

-- NO HAY CLIENTES QUE NO HAYAN REALIZADO NINGUNA COMPRA

--CONSULTA 3

 SELECT 
    p.id_Producto,
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v
    ON p.id_Producto = v.id_Producto
WHERE v.id_Producto IS NULL;

     -- no se registraron productos sin ventas

     -- CONSULTA 4
     WITH ventas_consolidadas AS (
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Online' AS canal
    FROM ventas
    WHERE fecha_venta < '2023-07-01'

    UNION ALL

    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE fecha_venta >= '2023-07-01'
)
SELECT 
    canal,
    SUM(total) AS monto_total
FROM ventas_consolidadas
GROUP BY canal;

-- SOLO SE REGISTRARON VENTAS PRESENCIALES--