-- =============================================================
-- QUERIES - Cadena de Gimnasios/Spas
-- PostgreSQL 15
-- =============================================================

-- -------------------------------------------------------------
-- Query 1: Listar nombre completo de clientes que han visitado
--          la sucursal "Sucursal Norte" en el último mes.
-- -------------------------------------------------------------
SELECT
    c.nombre || ' ' || c.apellidos AS nombre_completo
FROM Cliente c
INNER JOIN Visitan v    ON v.idCliente  = c.id
INNER JOIN Sucursal s   ON s.id         = v.idSucursal
WHERE s.nombre = 'Sucursal Norte'
  AND v.fechaVisita >= CURRENT_DATE - INTERVAL '1 month'
ORDER BY c.nombre;


-- -------------------------------------------------------------
-- Query 2: Mostrar cuántos clientes distintos han visitado cada
--          sucursal, ordenado por cantidad de visitas descendente.
-- -------------------------------------------------------------
SELECT
    s.nombre                        AS sucursal,
    COUNT(DISTINCT v.idCliente)     AS total_clientes_distintos
FROM Sucursal s
LEFT JOIN Visitan v ON v.idSucursal = s.id
GROUP BY s.id, s.nombre
ORDER BY total_clientes_distintos DESC;


-- -------------------------------------------------------------
-- Query 3: Encontrar productos disponibles en la sucursal de
--          ciudad "Medellín" pero NO en la de ciudad "Bogotá".
-- -------------------------------------------------------------
SELECT DISTINCT
    p.nombre          AS producto,
    p.tipoProducto
FROM Producto p
INNER JOIN Disponibilidad d ON d.idProducto = p.id
INNER JOIN Sucursal s       ON s.id         = d.idSucursal
WHERE s.ciudad = 'Medellín'
  AND p.id NOT IN (
      SELECT d2.idProducto
      FROM Disponibilidad d2
      INNER JOIN Sucursal s2 ON s2.id = d2.idSucursal
      WHERE s2.ciudad = 'Bogotá'
  )
ORDER BY p.nombre;


-- -------------------------------------------------------------
-- Query 4: Listar clientes inscritos en más de 2 productos,
--          mostrando la cantidad de productos inscritos.
-- -------------------------------------------------------------
SELECT
    c.nombre                    AS nombre,
    c.apellidos                 AS apellido,
    COUNT(i.idProducto)         AS cantidad_productos
FROM Cliente c
INNER JOIN Inscripcion i ON i.idCliente = c.id
GROUP BY c.id, c.nombre, c.apellidos
HAVING COUNT(i.idProducto) > 2
ORDER BY cantidad_productos DESC;


-- -------------------------------------------------------------
-- Query 5: Para cada cliente, mostrar su última visita (fecha
--          más reciente) y a qué sucursal fue.
--          Si no ha visitado, mostrar "Sin visitas".
-- -------------------------------------------------------------
SELECT
    c.nombre || ' ' || c.apellidos             AS nombre_completo,
    COALESCE(TO_CHAR(MAX(v.fechaVisita), 'YYYY-MM-DD'), 'Sin visitas') AS ultima_visita,
    COALESCE(s.nombre, 'Sin visitas')           AS sucursal
FROM Cliente c
LEFT JOIN Visitan v ON v.idCliente = c.id
LEFT JOIN Sucursal s ON s.id = (
    SELECT v2.idSucursal
    FROM Visitan v2
    WHERE v2.idCliente = c.id
    ORDER BY v2.fechaVisita DESC
    LIMIT 1
)
GROUP BY c.id, c.nombre, c.apellidos, s.nombre
ORDER BY c.nombre;
