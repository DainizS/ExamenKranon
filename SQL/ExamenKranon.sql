CREATE DATABASE ExamenKranon
GO
USE ExamenKranon
GO

---CREACION DE TABLAS
CREATE TABLE Autor
(
IdAutor INT PRIMARY KEY IDENTITY (1,1),
Nombre VARCHAR(50) NOT NULL,
ApellidoPaterno VARCHAR (50) NOT NULL,
ApellidoMaterno VARCHAR(50),
Pais VARCHAR(60) NOT NULL,
FechaNacimiento DATE NOT NULL
)

GO

CREATE TABLE Editorial
(
IdEditorial INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50)
)

GO

CREATE TABLE Libro
(
IdLibro INT PRIMARY KEY IDENTITY(1,1),
Titulo VARCHAR(50),
IdAutor INT,
IdEditorial INT,
FechaPublicacion DATE,
Portada VARCHAR(MAX),
Descripcion VARCHAR (300),

FOREIGN KEY (IdAutor) REFERENCES Autor(IdAutor),
FOREIGN KEY (IdEditorial) REFERENCES Editorial (IdEditorial)
)
GO
---STORED PROCEDURES AUTOR
CREATE PROCEDURE AutorAdd
@Nombre VARCHAR(50) ,
@ApellidoPaterno VARCHAR (50) ,
@ApellidoMaterno VARCHAR(50),
@Pais VARCHAR(60) ,
@FechaNacimiento DATE 
AS
INSERT INTO Autor
(
Nombre,
ApellidoPaterno,
ApellidoMaterno,
Pais,
FechaNacimiento
)VALUES
(
@Nombre,
@ApellidoPaterno,
@ApellidoMaterno,
@Pais,
CONVERT(DATE,@FechaNacimiento,105)
)
GO

CREATE PROCEDURE AutorUpdate
@IdAutor INT,
@Nombre VARCHAR(50) ,
@ApellidoPaterno VARCHAR (50) ,
@ApellidoMaterno VARCHAR(50),
@Pais VARCHAR(60) ,
@FechaNacimiento DATE 
AS
UPDATE Autor SET
Nombre = @Nombre,
ApellidoPaterno = @ApellidoPaterno,
ApellidoMaterno = @ApellidoMaterno,
Pais = @Pais,
FechaNacimiento = CONVERT(DATE,@FechaNacimiento,105)
WHERE
IdAutor = @IdAutor
GO

CREATE PROCEDURE AutorGetAll
AS
SELECT 
IdAutor,
Nombre,
ApellidoPaterno,
ApellidoMaterno,
Pais,
FechaNacimiento
FROM Autor

GO

CREATE PROCEDURE AutorGetById
@IdAutor INT
AS
SELECT 
IdAutor,
Nombre,
ApellidoPaterno,
ApellidoMaterno,
Pais,
FechaNacimiento
FROM Autor
WHERE
IdAutor = @IdAutor
GO

CREATE PROCEDURE AutorDelete
@IdAutor INT
AS
DELETE 
FROM Autor
WHERE
IdAutor = @IdAutor
GO

---STORED PROCEDURES EDITORIAL

CREATE PROCEDURE EditorialAdd
@Nombre VARCHAR(50) 

AS
INSERT INTO Autor
(
Nombre

)VALUES
(
@Nombre
)
GO

CREATE PROCEDURE EditorialUpdate
@IdEditorial INT,
@Nombre VARCHAR(50) 
AS
UPDATE Autor SET
Nombre = @Nombre
WHERE
IdAutor = @IdEditorial
GO

CREATE PROCEDURE EditorialGetAll
AS
SELECT 
IdEditorial,
Nombre
FROM Editorial

GO

CREATE PROCEDURE EditorialGetById
@IdEditorial INT
AS
SELECT 
IdEditorial,
Nombre
FROM Editorial
WHERE
IdEditorial = @IdEditorial
GO

CREATE PROCEDURE EditorialDelete
@IdEditorial INT
AS
DELETE 
FROM Editorial
WHERE
IdEditorial = @IdEditorial
GO

--STORED PROCEDURES LIBRO
CREATE PROCEDURE LibroAdd
@Titulo VARCHAR(50),
@IdAutor INT,
@IdEditorial INT,
@FechaPublicacion DATE,
@Portada VARCHAR(MAX),
@Descripcion VARCHAR (300)
AS
INSERT INTO Libro
(
Titulo,
IdAutor,
IdEditorial,
FechaPublicacion,
Portada,
Descripcion
)
VALUES
(
@Titulo,
@IdAutor,
@IdEditorial,
CONVERT(DATE,@FechaPublicacion,105),
@Portada,
@Descripcion
)
GO

CREATE PROCEDURE LibroUpdate
@IdLibro INT,
@Titulo VARCHAR(50),
@IdAutor INT,
@IdEditorial INT,
@FechaPublicacion DATE,
@Portada VARCHAR(MAX),
@Descripcion VARCHAR (300)
AS
UPDATE Libro SET

Titulo = @Titulo,
IdAutor = @IdAutor,
IdEditorial = @IdEditorial,
FechaPublicacion =CONVERT(DATE,@FechaPublicacion,105),
Portada = @Portada,
Descripcion =  @Descripcion
WHERE
IdLibro = @IdLibro
GO
--GETS Normales
CREATE PROCEDURE LibroGetAll
AS
SELECT 
Libro.IdLibro,
Libro.Titulo,
Autor.IdAutor,
Autor.Nombre AS Autor,
Editorial.IdEditorial,
Editorial.Nombre AS Editorial,
Libro.FechaPublicacion,
Libro.Portada,
Libro.Descripcion
FROM Libro
INNER JOIN Autor ON Libro.IdAutor = Autor.IdAutor
INNER JOIN Editorial ON Libro.IdEditorial = Editorial.IdEditorial
GO

CREATE PROCEDURE LibroGetById
@IdLibro INT
AS
SELECT 
Libro.IdLibro,
Libro.Titulo,
Autor.IdAutor,
Autor.Nombre AS Autor,
Editorial.IdEditorial,
Editorial.Nombre AS Editorial,
Libro.FechaPublicacion,
Libro.Portada,
Libro.Descripcion
FROM Libro
INNER JOIN Autor ON Libro.IdAutor = Autor.IdAutor
INNER JOIN Editorial ON Libro.IdEditorial = Editorial.IdEditorial
WHERE Libro.IdLibro= @IdLibro

GO
ALTER PROCEDURE LIbroGetAllBA
@Autor VARCHAR(50),
@Titulo VARCHAR (50),
@Editorial VARCHAR (50)
AS
IF @Autor ='' AND @Autor = '' AND @Autor= ''
	BEGIN
		SELECT 
			Libro.IdLibro,
			Libro.Titulo,
			Autor.IdAutor,
			Autor.Nombre AS Autor,
			Editorial.IdEditorial,
			Editorial.Nombre AS Editorial,
			Libro.FechaPublicacion,
			Libro.Portada,
			Libro.Descripcion
			FROM Libro
			INNER JOIN Autor ON Libro.IdAutor = Autor.IdAutor
			INNER JOIN Editorial ON Libro.IdEditorial = Editorial.IdEditorial
END;
ELSE
	BEGIN
		SELECT 
			Libro.IdLibro,
			Libro.Titulo,
			Autor.IdAutor,
			Autor.Nombre AS Autor,
			Editorial.IdEditorial,
			Editorial.Nombre AS Editorial,
			Libro.FechaPublicacion,
			Libro.Portada,
			Libro.Descripcion
			FROM Libro
			INNER JOIN Autor ON Libro.IdAutor = Autor.IdAutor
			INNER JOIN Editorial ON Libro.IdEditorial = Editorial.IdEditorial

		WHERE lib.Nombre LIKE '%'+@Nombre+'%' AND 
		Usuario.ApellidoPaterno LIKE '%'+@ApellidoPaterno+'%' 
		AND  Usuario.ApellidoMaterno LIKE '%'+@ApellidoMaterno+'%'
	END;