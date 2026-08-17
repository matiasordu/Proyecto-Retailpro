-- =====================================================================
-- m5_consultas_joins.sql
-- Consultas con JOINs sobre Ventas_Tech_DB
-- Pre-entrega M5 — RetailPro
-- Versión: SQL Server (T-SQL)
--
-- Nota: esta versión usa el esquema extendido de Ventas_Tech_DB.sql,
-- que agrega la tabla territorios y las columnas segmento (clientes)
-- y canal (ventas), necesarias para las consultas de este pre-entrega.
-- =====================================================================


-- =====================================================================
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Fuente de datos principal para Power BI (M7): una fila por venta con
-- toda la información de cliente, producto, categoría y territorio.
-- =====================================================================
SELECT
    v.fecha_venta,
    c.nombre                          AS nombre_cliente,
    c.segmento,
    t.region,
    p.nombre_producto,
    cat.nombre_categoria              AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario    AS total_venta,
    v.canal
FROM ventas v
INNER JOIN clientes c    ON v.id_cliente = c.id_cliente
INNER JOIN territorios t ON c.id_territorio = t.id_territorio
INNER JOIN productos p   ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;


-- =====================================================================
-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Clientes registrados que todavía no hicieron ninguna compra.
-- =====================================================================
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- =====================================================================
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Productos del catálogo que no tienen ninguna venta registrada.
-- =====================================================================
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v        ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- =====================================================================
-- Consulta 4 — Consolidado por canal (UNION ALL)
-- Combina las ventas Online y Presencial en un solo resultado y
-- calcula el total facturado por canal.
-- =====================================================================
WITH ventas_consolidadas AS (
    SELECT
        canal,
        id_venta,
        cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE canal = 'Online'

    UNION ALL

    SELECT
        canal,
        id_venta,
        cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE canal = 'Presencial'
)
SELECT
    canal,
    COUNT(*)           AS cantidad_pedidos,
    SUM(total_venta)   AS total_facturado
FROM ventas_consolidadas
GROUP BY canal
ORDER BY total_facturado DESC;


-- =====================================================================
-- HALLAZGOS
-- =====================================================================
-- 1. La vista base (Consulta 1) deja lista la tabla plana que va a
--    alimentar el dashboard de Power BI en M7: cada fila trae cliente,
--    segmento, región, producto, categoría y canal, sin necesidad de
--    relacionar tablas dentro de la herramienta de BI.
--
-- 2. Con el dataset original, todos los clientes y productos tenían
--    al menos una venta (ver hallazgos de M4). Para que las Consultas
--    2 y 3 tuvieran casos reales que mostrar, se agregó un cliente
--    (Diego Fernández) y un producto (Webcam Full HD) sin ventas en
--    Ventas_Tech_DB.sql; en producción, estos LEFT JOIN deberían
--    revisarse periódicamente para detectar clientes inactivos y
--    productos sin rotación.
--
-- 3. El consolidado por canal (Consulta 4) muestra 5 pedidos Online y
--    5 Presencial, con un canal claramente por encima del otro en
--    facturación total: es una primera señal de qué canal priorizar,
--    aunque con solo 10 ventas conviene confirmarla cuando se cargue
--    más historial.
