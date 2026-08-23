
-- Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. --
 -- Calculá el total como cantidad * precio_unitario. --
 --Usá alias descriptivos en español y agrupá por mes con EXTRACT(MONTH FROM fecha_venta). --

 SELECT 
        MONTH (fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado,
        COUNT (id_Venta) as cantidad_pedidos,
        AVG(cantidad * precio_unitario) AS ticket_promedio
      FROM dbo.DimVentas 
     GROUP BY MONTH (fecha_venta);

--Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) 
--y el total generado. Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.--

   SELECT 
          TOP 5 id_producto,
          SUM(cantidad) as unidades_vendidas,
          SUM(cantidad * precio_unitario) as total_facturado

   FROM dbo.DimVentas
   GROUP BY id_Producto
   ORDER BY total_facturado DESC;

   -- Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado.
   --Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.

   SELECT
        id_cliente,
        COUNT(id_Venta) AS cantidad_pedidos,
        SUM(cantidad * precio_unitario) AS total_gastado

   FROM dbo.DimVentas
   GROUP BY id_cliente
   HAVING COUNT (*) > 1;

   --Meses por encima/por debajo del promedio Total facturado por mes, con una columna adicional que etiquete con CASE WHEN si ese mes quedó
   --'Por encima' o 'Por debajo' del promedio mensual general.

   
  SELECT 
         MONTH (fecha_venta) as mes,
         SUM(cantidad * precio_unitario) AS total_facturado,
        case
        when SUM(cantidad * precio_unitario)  > 6444
        then 'por encima' else 'por debajo'
        end as comparacion
         FROM DBO.DimVentas
         GROUP BY MONTH (fecha_venta) ;

        
 -- El producto con mayor facturacion es el producto con id_producto = 1 con un total facturado de $3600--
 -- El analisis permitio identificar los productos que generan mas ingresos pudiendo observar que el producto con mas unidades vendidas no es el que genera mayor facturacion
 -- El cliente que mas gasto con una cantidad de pedidos de 2 con id_cliente =1 vive en Buenos Aires -- 


        

   