CREATE DATABASE DBProcedimiento;
use DBProcedimiento;

CREATE TABLE cliente(
	ClienteID INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100),
	Estatura DECIMAL(5,2),
	FechaNacimiento DATE,
	Sueldo DECIMAL(10,2),
	Edad INT
);

INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo,Edad) VALUES
('David Muela', 1.73, '1990-05-14', 4500.50,20),
('Laura García', 1.62, '1985-08-22', 3700.00,15),
('Carlos Pérez', 1.80, '1992-11-10', 5200.75,60),
('Ana López', 1.55, '2000-02-18', 2800.40,39),
('Luis Martínez', 1.67, '1988-09-05', 3100.20,41);

SELECT * FROM cliente;


-- MOSTRAR DATOS CON PROCEDIMIENTO

CREATE PROCEDURE MostrarInformacion
AS
BEGIN
    SELECT * FROM cliente;
END;

EXEC MostrarInformacion;


-- INSERTAR DATOS CON PROCEDIMIENTO

CREATE  PROCEDURE InsertarDatos
	@Nombre NVARCHAR(100),
	@Estatura DECIMAL(5,2),
	@FechaNacimiento DATE,
	@Sueldo DECIMAL(10,2),
	@Edad INT
AS 
BEGIN
	INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo,Edad)
	VALUES (@Nombre,@Estatura,@FechaNacimiento,@Sueldo,@Edad);
END;

EXEC InsertarDatos 
@Nombre = 'Pepe Perez',
@Estatura = 1.75, 
@FechaNacimiento = '1985-03-20', 
@Sueldo = 4000.50,
@Edad = 24;

SELECT * FROM cliente;


-- ACTUALIZAR DATOS CON PROCEDIMIENTO

CREATE PROCEDURE ActualizarDatos
	@ClienteID INT,
	@Edad INT
AS
BEGIN 
	UPDATE cliente SET Edad = @Edad WHERE ClienteID = @ClienteID;
END;

EXEC ActualizarDatos 
@ClienteID = 1, 
@Edad = 35;

SELECT * FROM cliente;


-- ELIMINAR DATOS CON PROCEDIMIENTO

CREATE PROCEDURE EliminarCliente
    @ClienteID INT
AS
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = @ClienteID;
END;d

EXEC EliminarCliente 
    @ClienteID = 1;


SELECT * FROM cliente;


-- CONDICION DE  DATOS CON PROCEDIMIENTO

CREATE PROCEDURE VerificarEdad
    @EdadMinima INT
AS
BEGIN
    IF @EdadMinima >= 22
    BEGIN
        SELECT * 
        FROM cliente
        WHERE Edad >= @EdadMinima;
    END
    ELSE
    BEGIN
        PRINT 'La edad minima debe ser mayor o igual a 22.';
    END
END;

EXEC VerificarEdad 
    @EdadMinima = 22;



-- CREAR TABLA ORDENES 
CREATE TABLE ordenes (
    OrdenID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT,
    Detalle NVARCHAR(255),
    Fecha DATE,
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);


-- INSERTAR UNA ORDEN CON PROCEDIMIENTO

CREATE PROCEDURE InsertarOrdenes
    @ClienteID INT,
    @Detalle NVARCHAR(255),
    @Fecha DATE
AS
BEGIN
    INSERT INTO ordenes (ClienteID, Detalle, Fecha)
    VALUES (@ClienteID, @Detalle, @Fecha);
END;


EXEC InsertarOrdenes
@ClienteID = 2,
@Detalle = 'Compra de electrodomésticos',
@Fecha = '2024-12-17';

SELECT * FROM ordenes;

-- ACTUALIZAR UNA ORDEN CON PROCEDIMIENTO

CREATE PROCEDURE ActualizarOrden
    @OrdenID INT,
    @NuevoDetalle NVARCHAR(255)
AS
BEGIN
    UPDATE ordenes SET Detalle = @NuevoDetalle WHERE OrdenID = @OrdenID;
END;

EXEC ActualizarOrden
@OrdenID = 1,
@NuevoDetalle = 'Compra de muebles';



-- ELIMINAR UNA ORDEN CON PROCEDIMIENTO

CREATE PROCEDURE EliminarOrden
    @OrdenID INT
AS
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = @OrdenID;
END;

EXEC EliminarOrden
@OrdenID = 1;

SELECT * FROM ordenes;
