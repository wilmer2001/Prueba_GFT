-- =============================================================
-- DATOS DE PRUEBA - Cadena de Gimnasios/Spas
-- Mínimo 10 registros por tabla
-- =============================================================

-- -----------------------------------------------
-- Clientes (12 registros)
-- -----------------------------------------------
INSERT INTO Cliente (nombre, apellidos, ciudad) VALUES
('Carlos',    'Gómez Torres',      'Bogotá'),
('Ana',       'Martínez López',    'Medellín'),
('Luis',      'Pérez Rodríguez',   'Cali'),
('María',     'Hernández Vargas',  'Bogotá'),
('Jorge',     'Díaz Morales',      'Medellín'),
('Sofía',     'Ramírez Castro',    'Barranquilla'),
('Andrés',    'Torres Ruiz',       'Bogotá'),
('Valentina', 'Flores Jiménez',    'Medellín'),
('Ricardo',   'Sánchez Mendoza',   'Cali'),
('Camila',    'Ortiz Reyes',       'Bogotá'),
('Felipe',    'Moreno Aguilar',    'Barranquilla'),
('Daniela',   'Vargas Suárez',     'Medellín');

-- -----------------------------------------------
-- Sucursales (10 registros)
-- -----------------------------------------------
INSERT INTO Sucursal (nombre, ciudad) VALUES
('Sucursal Norte',      'Bogotá'),
('Sucursal Sur',        'Bogotá'),
('Sucursal El Poblado', 'Medellín'),
('Sucursal Laureles',   'Medellín'),
('Sucursal San Fernando','Cali'),
('Sucursal Chipichape', 'Cali'),
('Sucursal Bocagrande', 'Cartagena'),
('Sucursal Centro',     'Barranquilla'),
('Sucursal Manga',      'Cartagena'),
('Sucursal Cabecera',   'Bucaramanga');

-- -----------------------------------------------
-- Productos (10 registros)
-- -----------------------------------------------
INSERT INTO Producto (nombre, tipoProducto) VALUES
('Membresía Mensual Básica',    'Membresía'),
('Membresía Mensual Premium',   'Membresía'),
('Membresía Anual',             'Membresía'),
('Clase de Yoga',               'Clase'),
('Clase de Spinning',           'Clase'),
('Clase de Pilates',            'Clase'),
('Clase de Natación',           'Clase'),
('Masaje Relajante',            'Servicio'),
('Spa Facial Completo',         'Servicio'),
('Entrenamiento Personal',      'Servicio');

-- -----------------------------------------------
-- Disponibilidad (productos por sucursal, 12+ registros)
-- -----------------------------------------------
INSERT INTO Disponibilidad (idSucursal, idProducto) VALUES
-- Sucursal Norte (Bogotá): id=1
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 8),
-- Sucursal Sur (Bogotá): id=2
(2, 1), (2, 3), (2, 6), (2, 7), (2, 9),
-- Sucursal El Poblado (Medellín): id=3
(3, 1), (3, 2), (3, 4), (3, 5), (3, 8), (3, 10),
-- Sucursal Laureles (Medellín): id=4
(4, 1), (4, 3), (4, 6), (4, 9),
-- Sucursal San Fernando (Cali): id=5
(5, 1), (5, 2), (5, 5), (5, 7), (5, 10);

-- -----------------------------------------------
-- Inscripciones (cliente-producto, 14+ registros)
-- -----------------------------------------------
INSERT INTO Inscripcion (idProducto, idCliente) VALUES
(1, 1), (4, 1), (8, 1),  -- Carlos inscrito en 3 productos
(2, 2), (5, 2), (9, 2),  -- Ana inscrita en 3 productos
(1, 3),                   -- Luis inscrito en 1 producto
(3, 4), (6, 4), (8, 4), (10, 4), -- María inscrita en 4 productos
(1, 5), (5, 5),           -- Jorge inscrito en 2 productos
(2, 6), (7, 6), (9, 6),  -- Sofía inscrita en 3 productos
(1, 7),                   -- Andrés inscrito en 1 producto
(4, 8), (5, 8), (6, 8), (10, 8); -- Valentina inscrita en 4 productos

-- -----------------------------------------------
-- Visitas (12+ registros)
-- -----------------------------------------------
INSERT INTO Visitan (idSucursal, idCliente, fechaVisita) VALUES
-- Visitas recientes (último mes desde 2026-03-31)
(1, 1, '2026-03-25'),
(1, 2, '2026-03-20'),
(1, 4, '2026-03-15'),
(1, 7, '2026-03-10'),
(1, 10,'2026-03-05'),
-- Visitas más antiguas
(2, 3, '2026-02-18'),
(3, 2, '2026-03-22'),
(3, 5, '2026-03-18'),
(3, 8, '2026-02-10'),
(4, 6, '2026-03-28'),
(5, 9, '2026-03-01'),
(2, 4, '2026-03-12'),
-- Cliente sin visitas: id=11 (Felipe) y id=12 (Daniela) no tienen registros en Visitan
(1, 3, '2026-01-15'),
(3, 1, '2026-02-20');
