-- =====================================================================
-- m4_consultas_negocio.sql
-- Consultas SQL de negocio sobre Ventas_Tech_DB (tabla: ventas)
-- Pre-entrega M4 — RetailPro
-- Versión: SQL Server (T-SQL)
-- =====================================================================


-- =====================================================================
-- Consulta 1 — Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio por mes
-- =====================================================================
SELECT
    MONTH(fecha_venta)                                    AS mes,
    SUM(cantidad * precio_unitario)                        AS total_facturado,
    COUNT(*)                                               AS cantidad_pedidos,
    ROUND(SUM(cantidad * precio_unitario) / COUNT(*), 2)   AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- =====================================================================
-- Consulta 2 — Ranking de productos (Top 5 por facturación)
-- =====================================================================
SELECT TOP 5
    id_producto,
    SUM(cantidad)                    AS unidades_vendidas,
    SUM(cantidad * precio_unitario)  AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


-- =====================================================================
-- Consulta 3 — Clientes recurrentes (más de un pedido)
-- =====================================================================
SELECT
    id_cliente,
    COUNT(*)                          AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)   AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


-- =====================================================================
-- Consulta 4 — Meses por encima/por debajo del promedio general
-- =====================================================================
WITH facturacion_mensual AS (
    SELECT
        MONTH(fecha_venta)               AS mes,
        SUM(cantidad * precio_unitario)  AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM facturacion_mensual) THEN 'Por encima'
        WHEN total_facturado < (SELECT AVG(total_facturado) FROM facturacion_mensual) THEN 'Por debajo'
        ELSE 'En el promedio'
    END AS comparacion_promedio
FROM facturacion_mensual
ORDER BY mes;


-- =====================================================================
-- HALLAZGOS
-- =====================================================================
-- 1. El producto 1 (Laptop Pro 15) concentra el 56% de la facturación
--    total ($3.600 de $6.444), muy por encima del segundo puesto del
--    ranking (producto 3, con $1.350). Es el producto que más define
--    el resultado del período.
--
-- 2. Los 5 clientes de la base hicieron exactamente 2 pedidos cada uno:
--    con la regla "más de un pedido" TODOS califican como recurrentes.
--    No hay compradores de una sola compra en este dataset, lo cual
--    conviene revisar cuando se cargue más historial de ventas.
--
-- 3. Todas las ventas registradas caen en marzo de 2024, por lo que la
--    Consulta 4 (comparación mes por mes) todavía no aporta valor real:
--    con un solo mes, el total del mes SIEMPRE coincide con el
--    promedio general. Esta métrica va a volverse útil recién cuando
--    se carguen ventas de varios meses distintos.
