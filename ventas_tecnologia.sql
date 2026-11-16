-- Tabla temporal y datos ficticios para probar las consultas en una sola sesión.
CREATE TEMP TABLE IF NOT EXISTS ventas_tecnologia (
    id_venta INTEGER PRIMARY KEY,
    producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio_unitario NUMERIC(12, 2) NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha DATE NOT NULL,
    pais VARCHAR(50) NOT NULL
);

-- Carga las ventas de ejemplo sin duplicarlas si vuelves a ejecutar el archivo.
INSERT INTO ventas_tecnologia (
    id_venta, producto, categoria, precio_unitario, cantidad, fecha, pais
)
VALUES
    (1, 'Laptop Pro', 'Computadoras', 1200.00, 5, '2026-11-01', 'Colombia'),
    (2, 'Laptop Air', 'Computadoras', 800.00, 6, '2026-11-01', 'Perú'),
    (3, 'Monitor 4K', 'Monitores', 500.00, 12, '2026-11-02', 'Colombia'),
    (4, 'Monitor Ultra', 'Monitores', 800.00, 5, '2026-11-02', 'México'),
    (5, 'Router empresarial', 'Redes', 950.00, 8, '2026-11-03', 'Colombia'),
    (6, 'Switch gestionable', 'Redes', 600.00, 5, '2026-11-03', 'Chile'),
    (7, 'Teclado mecánico', 'Accesorios', 80.00, 6, '2026-11-04', 'Colombia'),
    (8, 'Mouse inalámbrico', 'Accesorios', 35.50, 4, '2026-11-04', 'Perú'),
    (9, 'Webcam', NULL, 75.00, 3, '2026-11-05', 'Colombia'),
    (10, 'SSD externo', NULL, 500.01, 1, '2026-11-05', 'Colombia'),
    (11, 'Adaptador USB', 'Accesorios', 24.99, 3, '2026-11-06', 'Colombia')
ON CONFLICT (id_venta) DO NOTHING;

-- ¿Qué productos se vendieron y a qué precio unitario, en orden alfabético?
SELECT producto, precio_unitario
FROM ventas_tecnologia
ORDER BY producto ASC;

-- ¿Qué ventas de Colombia tuvieron un precio unitario superior a $500?
SELECT id_venta, producto, categoria, precio_unitario, cantidad, fecha, pais
FROM ventas_tecnologia
WHERE pais = 'Colombia'
    AND precio_unitario > 500
ORDER BY id_venta;

-- ¿Qué ventas quedaron sin categoría asignada?
SELECT id_venta, producto, categoria, precio_unitario, cantidad, fecha, pais
FROM ventas_tecnologia
WHERE categoria IS NULL
ORDER BY id_venta;

-- ¿Cuánto ingresó por cada categoría? NULL agrupa las ventas sin clasificar.
SELECT categoria, SUM(cantidad * precio_unitario) AS ingresos_totales
FROM ventas_tecnologia
GROUP BY categoria
ORDER BY ingresos_totales DESC;

-- ¿Qué categorías superaron los $10,000 de ingresos totales?
SELECT categoria, SUM(cantidad * precio_unitario) AS ingresos_totales
FROM ventas_tecnologia
GROUP BY categoria
HAVING SUM(cantidad * precio_unitario) > 10000
ORDER BY ingresos_totales DESC;
