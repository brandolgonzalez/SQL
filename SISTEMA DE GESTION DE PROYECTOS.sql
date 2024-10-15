CREATE DATABASE IF NOT EXISTS Sistema_Gestión_Proyectos;

USE Sistema_Gestión_Proyectos;

#Usuarios
CREATE TABLE Usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    rol ENUM('gerente_proyecto', 'miembro_equipo', 'administrador') NOT NULL,
    habilidades TEXT
);


#Proyectos
CREATE TABLE Proyectos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin_estimada DATE,
    estado ENUM('en_progreso', 'completado', 'cancelado') NOT NULL,
    prioridad ENUM('alta', 'media', 'baja') NOT NULL
);

#Tareas
CREATE TABLE Tareas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado ENUM('pendiente', 'en_progreso', 'completada') NOT NULL,
    prioridad ENUM('alta', 'media', 'baja') NOT NULL,
    usuario_id INT,
    proyecto_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(id)
);

#Subtareas
CREATE TABLE Subtareas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado ENUM('pendiente', 'en_progreso', 'completada') NOT NULL,
    tarea_id INT,
    usuario_id INT,
    FOREIGN KEY (tarea_id) REFERENCES Tareas(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

#Recursos
CREATE TABLE Recursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    tipo ENUM('humano', 'material', 'equipo') NOT NULL,
    costo DECIMAL(10,2),
    proyecto_id INT,
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(id)
);

#Seguimiento del Tiempo
CREATE TABLE TiempoTrabajado (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    horas_trabajadas DECIMAL(5,2) NOT NULL,
    descripcion TEXT,
    tarea_id INT,
    usuario_id INT,
    FOREIGN KEY (tarea_id) REFERENCES Tareas(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

#Costos
CREATE TABLE Costos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT,
    monto DECIMAL(10,2) NOT NULL,
    proyecto_id INT,
    recurso_id INT,
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(id),
    FOREIGN KEY (recurso_id) REFERENCES Recursos(id)
);

#Documentación
CREATE TABLE Documentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_documento VARCHAR(255),
    ruta_documento VARCHAR(255),
    fecha_subida DATE NOT NULL,
    proyecto_id INT,
    tarea_id INT,
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(id),
    FOREIGN KEY (tarea_id) REFERENCES Tareas(id)
);

#Comentarios y Notificaciones
CREATE TABLE Comentarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    comentario TEXT NOT NULL,
    fecha_comentario DATE NOT NULL,
    tarea_id INT,
    usuario_id INT,
    FOREIGN KEY (tarea_id) REFERENCES Tareas(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

CREATE TABLE Notificaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mensaje TEXT NOT NULL,
    fecha_notificacion DATE NOT NULL,
    usuario_id INT,
    tarea_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (tarea_id) REFERENCES Tareas(id)
);

#Informes
CREATE VIEW InformeProyecto AS
SELECT p.nombre AS proyecto,
       p.estado,
       p.prioridad,
       SUM(tt.horas_trabajadas) AS total_horas,
       SUM(c.monto) AS total_costos
FROM Proyectos p
LEFT JOIN Tareas t ON t.proyecto_id = p.id
LEFT JOIN TiempoTrabajado tt ON tt.tarea_id = t.id
LEFT JOIN Costos c ON c.proyecto_id = p.id
GROUP BY p.id;



