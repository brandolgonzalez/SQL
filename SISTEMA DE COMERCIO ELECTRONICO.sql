CREATE DATABASE IF NOT EXISTS Sistema_Comercio_Electrónico;

USE Sistema_Comercio_Electrónico;

#Usuarios
CREATE TABLE Usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    rol ENUM('cliente', 'administrador') NOT NULL,
    preferencias_pago VARCHAR(50)
);

#Productos
CREATE TABLE Productos (
     id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    imagenes TEXT,
    sku VARCHAR(50) NOT NULL,
    categoria VARCHAR(100),
    inventario INT NOT NULL
);

CREATE TABLE Variaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT,
    color VARCHAR(50),
    tamaño VARCHAR(50),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

#Órdenes de Compra
CREATE TABLE Ordenes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM('procesando', 'enviado', 'entregado', 'cancelado') NOT NULL,
    fecha_orden DATE NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

CREATE TABLE OrdenDetalle (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES Ordenes(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

#Pagos
CREATE TABLE Pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT NOT NULL,
    metodo_pago ENUM('tarjeta_credito', 'paypal', 'transferencia') NOT NULL,
    fecha_pago DATE NOT NULL,
    monto_total DECIMAL(10,2),
    estado_pago ENUM('pendiente', 'completado', 'fallido'),
    FOREIGN KEY (orden_id) REFERENCES Ordenes(id)
);

#Envíos
CREATE TABLE Envios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT NOT NULL,
    direccion_envio VARCHAR(255) NOT NULL,
    metodo_envio ENUM('estándar', 'expreso') NOT NULL,
    numero_seguimiento VARCHAR(100),
    estado_envio ENUM('preparando', 'en_transito', 'entregado'),
    FOREIGN KEY (orden_id) REFERENCES Ordenes(id)
);

#inventario
CREATE TRIGGER actualizar_inventario
AFTER INSERT ON OrdenDetalle
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET inventario = inventario - NEW.cantidad
    WHERE id = NEW.producto_id
END;

#opiniones
CREATE TABLE Opiniones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT,
    usuario_id INT,
    comentario TEXT,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    fecha_opinion DATE NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

#promociones
CREATE TABLE Promociones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    porcentaje_descuento DECIMAL(5,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    codigo_promocion VARCHAR(50)
);

CREATE TABLE PromocionProducto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    promocion_id INT,
    producto_id INT,
    FOREIGN KEY (promocion_id) REFERENCES Promociones(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

#atencio al cliente
CREATE TABLE TicketsSoporte (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    orden_id INT,
    descripcion TEXT NOT NULL,
    estado ENUM('abierto', 'en_proceso', 'resuelto') NOT NULL,
    fecha_creacion DATE NOT NULL,
    fecha_resolucion DATE,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (orden_id) REFERENCES Ordenes(id)
);

#historial de actividades
CREATE TABLE HistorialActividades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    tipo_actividad ENUM('orden_realizada', 'producto_visualizado', 'comentario_realizado'),
    descripcion TEXT,
    fecha_actividad DATE NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);


