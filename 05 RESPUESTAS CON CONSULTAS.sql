--Pregunta 01: ¿Cuántos pedidos se han registrado en el año 2024?
SELECT YEAR(fecha_hora) as año, COUNT(*) AS cantidad
FROM grupo02.pedidos
WHERE YEAR(fecha_hora) = 2024
GROUP BY YEAR(fecha_hora)

						
--Pregunta 02: ¿Qué producto ha vendido mas unidades en el año 2024?
SELECT TOP 1
p.id_producto,
p.nombre,
SUM(dp.cantidad) AS cantidad
FROM [grupo02].[productos] p
INNER JOIN [grupo02].[detalles_pedidos] dp ON p.id_producto = dp.id_producto
INNER JOIN [grupo02].[pedidos] pp ON dp.id_pedido = pp.id_pedido
WHERE YEAR(pp.fecha_hora) = 2024
GROUP BY 
p.id_producto,
p.nombre
ORDER BY
cantidad DESC


--Pregunta 03: ¿Qué categoría de producto ha sido la menos pedida en el año 2024?
WITH CategoriaFrecuencias AS (
    SELECT 
        C.id_categoria,
                C.Descripción,
        COUNT(*) AS pedidos
    FROM 
        grupo02.detalles_pedidos D
    JOIN 
        grupo02.productos P ON D.id_producto = P.id_producto
    JOIN 
        grupo02.categorias C ON P.id_categoria = C.id_categoria
    JOIN 
        grupo02.pedidos PED ON D.id_pedido = PED.id_pedido
    GROUP BY 
        C.id_categoria,
                C.descripción
)

SELECT TOP 1
    id_categoria,
        descripción,
    pedidos
FROM 
    CategoriaFrecuencias
ORDER BY pedidos ASC
				


-- Pregunta 04: ¿Cuál es el tiempo máximo que ha demorado un pedido en ser entregado (de estado Pendiente 1 a estado Entregado 7) en el 2024?
WITH EstadoPendiente AS (
    SELECT 
        id_pedido, 
        fecha_hora AS fecha_pendiente
    FROM 
        grupo02.operaciones_estados
    WHERE 
        id_estado = 1 -- Estado 'Pendiente'
        AND YEAR(fecha_hora) = 2024
),
EstadoEntregado AS (
    SELECT 
        id_pedido, 
        fecha_hora AS fecha_entregado
    FROM 
        grupo02.operaciones_estados
    WHERE 
        id_estado = 7 -- Estado 'Entregado'
        AND YEAR(fecha_hora) = 2024
),
TiemposEntrega AS (
    SELECT 
        p.id_pedido,
        DATEDIFF(SECOND, p.fecha_pendiente, e.fecha_entregado) AS tiempo_segundos
    FROM 
        EstadoPendiente p
    JOIN 
        EstadoEntregado e ON p.id_pedido = e.id_pedido
)

SELECT TOP 1
    id_pedido,
    tiempo_segundos AS tiempo_segundos,
    tiempo_segundos / 86400 AS dias,
    (tiempo_segundos % 86400) / 3600 AS horas,
    ((tiempo_segundos % 86400) % 3600) / 60 AS minutos,
    ((tiempo_segundos % 86400) % 3600) % 60 AS segundos
FROM 
    TiemposEntrega
ORDER BY tiempo_segundos DESC

						

--Pregunta 05: ¿Cuál ha sido el producto más caro pedido en el año 2024?
SELECT TOP 1 WITH TIES
p.id_producto,
p.nombre,
p.precio,
SUM(dp.cantidad) AS Unidades_Vendidas
FROM [grupo02].[productos] p
INNER JOIN [grupo02].[detalles_pedidos] dp ON p.id_producto = dp.id_producto
INNER JOIN [grupo02].[pedidos] pp ON dp.id_pedido = pp.id_pedido
WHERE YEAR(pp.fecha_hora) = 2024
GROUP BY 
p.id_producto,
p.nombre,
p.precio
ORDER BY
p.precio DESC						


--Pregunta 06: ¿Cuántos pedidos han sido entregados en el año 2024? (estado Entregado)
SELECT COUNT(p.id_pedido) AS Pedidos_Entregados
FROM [grupo02].[pedidos] p
INNER JOIN [grupo02].[operaciones_estados] o ON p.id_pedido = o.id_pedido
INNER JOIN [grupo02].[estados] e ON o.id_estado = e.id_estado
WHERE e.descripción = 'Entregado' AND YEAR(o.fecha_hora) = 2024


--Pregunta 07: ¿Qué cuantos pedidos han sido cancelados en el año 2024? (estado Cancelado)
SELECT COUNT(p.id_pedido) AS Pedidos_Cancelados
FROM [grupo02].[pedidos] p
INNER JOIN [grupo02].[operaciones_estados] o ON p.id_pedido = o.id_pedido
INNER JOIN [grupo02].[estados] e ON o.id_estado = e.id_estado
WHERE e.descripción = 'Cancelado' AND YEAR(o.fecha_hora) = 2024					


--Pregunta 08: ¿Cuales son los 3 productos con menos unidades vendidas en 2024?
SELECT TOP 3
p.id_producto,
p.nombre,
SUM(dp.cantidad) AS Unidades_Vendidas
FROM [grupo02].[productos] p
INNER JOIN [grupo02].[detalles_pedidos] dp ON p.id_producto = dp.id_producto
INNER JOIN [grupo02].[pedidos] pp ON dp.id_pedido = pp.id_pedido
WHERE YEAR(pp.fecha_hora) = 2024		
GROUP BY 
p.id_producto,
p.nombre
ORDER BY
Unidades_Vendidas						


--Pregunta 09: ¿Cual ha sido la importacion con mayor monto total (precio_unitario x cantidad) en el 2024?
SELECT TOP 1
i.id_importacion,
SUM(di.cantidad*di.precio_unitario) AS Monto_total
FROM [grupo02].[importaciones] i
INNER JOIN [grupo02].[detalles_importaciones] di ON i.id_importacion = di.id_importacion
WHERE YEAR(i.fecha_hora) = 2024
GROUP BY
i.id_importacion
ORDER BY
Monto_total DESC					


--Pregunta 10: ¿Cual ha sido el pedido con mayor  monto total (precio_unitario x cantidad)  en el 2024?
SELECT TOP 1
p.id_pedido,
SUM(dp.cantidad*dp.precio_unitario) AS Monto_total
FROM [grupo02].[pedidos] p
INNER JOIN [grupo02].[detalles_pedidos] dp ON p.id_pedido = dp.id_pedido
WHERE YEAR(p.fecha_hora) = 2024
GROUP BY
p.id_pedido
ORDER BY
Monto_total DESC					