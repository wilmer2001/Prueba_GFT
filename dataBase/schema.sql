-- =============================================================
-- ESQUEMA DE BASE DE DATOS - Cadena de Gimnasios/Spas
-- PostgreSQL 15
-- =============================================================

-- Tabla: Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    apellidos   VARCHAR(100) NOT NULL,
    ciudad      VARCHAR(100) NOT NULL
);

-- Tabla: Sucursal
CREATE TABLE IF NOT EXISTS Sucursal (
    id      SERIAL PRIMARY KEY,
    nombre  VARCHAR(100) NOT NULL,
    ciudad  VARCHAR(100) NOT NULL
);

-- Tabla: Producto
CREATE TABLE IF NOT EXISTS Producto (
    id            SERIAL PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    tipoProducto  VARCHAR(50)  NOT NULL
);

-- Tabla: Inscripcion (relación Producto - Cliente)
CREATE TABLE IF NOT EXISTS Inscripcion (
    idProducto  INTEGER NOT NULL REFERENCES Producto(id),
    idCliente   INTEGER NOT NULL REFERENCES Cliente(id),
    PRIMARY KEY (idProducto, idCliente)
);

-- Tabla: Disponibilidad (qué productos están disponibles en qué sucursales)
CREATE TABLE IF NOT EXISTS Disponibilidad (
    idSucursal  INTEGER NOT NULL REFERENCES Sucursal(id),
    idProducto  INTEGER NOT NULL REFERENCES Producto(id),
    PRIMARY KEY (idSucursal, idProducto)
);

-- Tabla: Visitan (registro de visitas de clientes a sucursales)
CREATE TABLE IF NOT EXISTS Visitan (
    idSucursal   INTEGER NOT NULL REFERENCES Sucursal(id),
    idCliente    INTEGER NOT NULL REFERENCES Cliente(id),
    fechaVisita  DATE    NOT NULL,
    PRIMARY KEY (idSucursal, idCliente, fechaVisita)
);
