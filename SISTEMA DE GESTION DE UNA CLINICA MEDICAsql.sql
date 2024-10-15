CREATE DATABASE IF NOT EXISTS sistema_hospital;

USE sistema_hospital;

#Pacientes
CREATE TABLE Pacientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    fecha_nacimiento DATE,
    direccion VARCHAR(255),
    numero_contacto VARCHAR(20),
    correo_electronico VARCHAR(100)
);

#Médicos
CREATE TABLE Medicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    especialidad VARCHAR(100),
    numero_licencia VARCHAR(50),
    numero_contacto VARCHAR(20),
    correo_electronico VARCHAR(100)
)ENGINE INNODB;

#Citas
CREATE TABLE Citas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE,
    hora TIME,
    motivo TEXT,
    paciente_id INT,
    medico_id INT,
    FOREIGN KEY (paciente_id) REFERENCES Pacientes(id),
    FOREIGN KEY (medico_id) REFERENCES Medicos(id)
);

#Tratamientos
CREATE TABLE Tratamientos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    costo DECIMAL(10,2),
    paciente_id INT,
    medico_id INT,
    FOREIGN KEY (paciente_id) REFERENCES Pacientes(id),
    FOREIGN KEY (medico_id) REFERENCES Medicos(id)
);

#Facturación
CREATE TABLE Facturas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_emision DATE,
    total DECIMAL(10,2),
    paciente_id INT,
    tratamiento_id INT,
    FOREIGN KEY (paciente_id) REFERENCES Pacientes(id),
    FOREIGN KEY (tratamiento_id) REFERENCES Tratamientos(id)
);
