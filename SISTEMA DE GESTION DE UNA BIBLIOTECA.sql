CREATE DATABASE IF NOT EXISTS sistema_gestion_biblioteca;

USE sistema_gestion_biblioteca; 

#Libros
CREATE TABLE Libros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255),
    autor VARCHAR(255),
    isbn VARCHAR(20),
    editorial VARCHAR(100),
    anio_publicacion YEAR,
    categoria VARCHAR(100)
);

#Usuarios
CREATE TABLE Usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    numero_identificacion VARCHAR(50),
    direccion VARCHAR(255),
    correo_electronico VARCHAR(100),
    telefono VARCHAR(20)
);

#Préstamos
CREATE TABLE Prestamos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_inicio DATE,
    fecha_vencimiento DATE,
    usuario_id INT,
    libro_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (libro_id) REFERENCES Libros(id)
);

#Devoluciones
CREATE TABLE Devoluciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_devolucion DATE,
    estado_libro ENUM('bueno', 'dañado', 'perdido'),
    prestamo_id INT,
    FOREIGN KEY (prestamo_id) REFERENCES Prestamos(id)
);

# Multas
CREATE TABLE Multas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    total DECIMAL(10,2),
    dias_retraso INT,
    prestamo_id INT,
    FOREIGN KEY (prestamo_id) REFERENCES Prestamos(id)
);
