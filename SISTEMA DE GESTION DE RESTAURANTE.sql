CREATE DATABASE IF NOT EXISTS Sistema_Gestión_Restaurante;

USE Sistema_Gestión_Restaurante;

#Menú de Platos
CREATE TABLE Platos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    categoria ENUM('entrada', 'plato principal', 'postre'),
    ingredientes TEXT
);

#Clientes
CREATE TABLE Clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    contacto VARCHAR(20)
);

#Órdenes
CREATE TABLE Ordenes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE,
    hora TIME,
    cliente_id INT,
    empleado_id INT,
    mesa_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id),
    FOREIGN KEY (mesa_id) REFERENCES Mesas(id)
);

#Mesas
CREATE TABLE Mesas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero INT,
    capacidad INT
);

#Empleados
CREATE TABLE Empleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    puesto VARCHAR(50),
    contacto VARCHAR(20)
);

#Inventario de Ingredientes
CREATE TABLE Ingredientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    cantidad INT,
    proveedor_id INT,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);

#Proveedores
CREATE TABLE Proveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    contacto VARCHAR(100)
);
