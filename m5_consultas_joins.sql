--consulta 1

SELECT
       v.fecha_venta as fecha,
       c.nombre_cliente as nombre_cliente,
       c.ciudad as ciudad,
       p.nombre_producto as producto,
       cat.nombre_categoria as categoria,
       v.cantidad,
       v.precio_unitario,
       v.cantidad * v.precio_unitario as total_facturado
     
      FROM Ventas as v
      INNER JOIN clientes as c
      ON v.id_cliente = c.id_cliente
      INNER JOIN  productos as p
      ON v.id_Producto = p.id_Producto
    INNER JOIN Categorias as cat
    ON p.id_categoria = cat.id_Categoria

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
       p.nombre_producto,
       cat.nombre_categoria,
       p.precio

       FROM productos as p
       LEFT JOIN ventas as v
       ON p.id_Producto = v.id_Producto
       INNER JOIN categorias as cat
       ON p.id_categoria = cat.id_categoria
       WHERE v.id_Producto IS NULL

     -- no se registraron productos sin ventas

     -- consulta 4
     --no entiendo como hacerlo si no tengo ninguna columna relacionada con la modalidad de la venta