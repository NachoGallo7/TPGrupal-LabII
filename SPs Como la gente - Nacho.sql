USE COMPLEJO_CINE_v3
GO
--==ALTER DB
--Agregar imagenes a peliculas
ALTER TABLE PELICULAS
ADD imagen varbinary(MAX)

----Relacionado al Usuario
--UsuarioExistente
CREATE PROC SP_USUARIO_EXISTENTE @documento varchar(50), @tipoDoc int=0, @resultado int=0 OUTPUT
	AS
	BEGIN
		IF( (SELECT id_empleado FROM EMPLEADOS WHERE nro_doc = @documento and id_tipo_doc = @tipoDoc) IS NOT NULL)
			SET @resultado = 2 --Empleado
		ELSE IF ( (SELECT id_cliente FROM clientes WHERE nro_doc = @documento AND id_tipo_doc = @tipoDoc) IS NOT NULL) 
			SET @resultado = 1 --Cliente
		ELSE
			SET @resultado = 0 --Usuario inexistente
	END

--ProximoUsuario
CREATE PROC SP_PROXIMO_ID_USUARIO @proximoId int OUTPUT
	AS
	SELECT @proximoId = MAX(id_cliente)+1 FROM CLIENTES

--InsertarUsuario
CREATE PROC SP_INSERTAR_USUARIO @id int, @apellido varchar(50)='testApellido', @nombre varchar(50)='testNombre', 
								@idTipoCliente int=1, @fechaNac DateTime='1-1-2000', @idTipoDoc int=1, 
								@nroDoc varchar(50)='123456789', @idCalle int=1, @altura int=1234, @idGenero int=1
	AS
	INSERT CLIENTES (id_cliente, Apellido_Cliente, Nombre_Cliente, Id_Tipo_Cliente, 
					 Fecha_Nac, Id_Tipo_Doc, Nro_Doc, Id_Calle, Altura, Id_Genero)
		VALUES(@id, @apellido, @nombre, @idTipoCliente, @fechaNac, @idTipoDoc, 
			   @nroDoc, @idCalle, @altura, @idGenero)

--NombreDeUsuario
CREATE PROC SP_NOMBRE_DE_USUARIO @documento varchar(50), @tipoDocumento int=0, @nombreSalida varchar(50) OUTPUT
	AS
	BEGIN
		DECLARE @resultado varchar(50)
		SELECT @resultado = nombre_cliente FROM CLIENTES
			WHERE Nro_Doc = @documento AND Id_Tipo_Doc = @tipoDocumento
		IF (@resultado IS NULL)
			SELECT @resultado = nombre_empleado FROM EMPLEADOS
				WHERE Nro_Doc = @documento AND Id_Tipo_Doc = @tipoDocumento
		SET @nombreSalida = @resultado
	END

--NombreDeCliente
CREATE PROC SP_NOMBRE_DE_CLIENTE @documento varchar(50), @tipoDocumento int=0, @nombreSalida varchar(50) OUTPUT
	AS
	BEGIN
		SELECT @nombreSalida = nombre_cliente FROM CLIENTES
			WHERE Nro_Doc = @documento AND Id_Tipo_Doc = @tipoDocumento
	END

--NombreDeEmpleado
CREATE PROC SP_NOMBRE_DE_EMPLEADO @documento varchar(50), @tipoDocumento int=0, @nombreSalida varchar(50) OUTPUT
	AS
	BEGIN
		SELECT @nombreSalida = nombre_empleado FROM EMPLEADOS
			WHERE Nro_Doc = @documento AND Id_Tipo_Doc = @tipoDocumento
	END

--==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-
----Cargar Combos
CREATE PROC SP_CARGAR_COMBO @nombreTabla nvarchar(50)
	AS
	BEGIN
		DECLARE @query nvarchar(200)
		SET @query = 'SELECT * FROM ' + @nombreTabla
		EXEC SP_EXECUTESQL @stmt = @query
	END


--==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-
----Form de Compras

--SP DGV Cartelera
CREATE VIEW view_peliculas_detalles
	AS
	SELECT p.id_pelicula, p.nombre, g.id_tipo_genero_pelicula, g.tipo_genero_pelicula, p.id_pais_origen, 
		   ce.id_calificacion_etaria, ce.calificacion_etarias, id.id_idioma, id.idioma, 
		   p.duracion, p.subtitulada, p.imagen --, f.Dia 'fecha', f.horario, f.precio_actual 
		FROM PELICULAS p JOIN TIPOS_GENERO_PELICULA g ON p.Id_Genero = g.Id_Tipo_Genero_Pelicula
						 JOIN CALIFICACIONES_ETARIAS ce 
							ON p.Id_Calificacion_Etaria = ce.Id_Calificacion_Etaria
						 JOIN IDIOMAS id ON id.Id_Idioma = p.Id_Idioma

CREATE PROC SP_PELICULAS_DETALLES
	AS
	BEGIN
		SELECT * FROM view_peliculas_detalles
	END
EXEC SP_PELICULAS_DETALLES

SELECT * FROM view_peliculas_detalles WHERE tipo_genero_pelicula = 'Musical'


--Funciones de Pelicula
CREATE PROC SP_FUNCIONES_DETALLES
	AS
		SELECT * FROM view_funciones_detalles
		
CREATE VIEW view_funciones_detalles
	AS
		SELECT f.id_funcion, p.id_pelicula, p.nombre, f.id_sala, s.Capacidad, s.Id_Tipo_Sala, ts.Tipo_Sala,
			   f.dia, f.horario, f.precio_actual, DATEADD( MINUTE, DATEPART(MINUTE, f.horario), 
			   DATEADD(HOUR, DATEPART(HOUR, f.Horario), f.dia) ) 'fecha_hora'
			FROM FUNCIONES f JOIN PELICULAS p ON f.Id_Pelicula = p.Id_Pelicula
							 JOIN SALAS s ON s.Id_Sala = f.Id_Sala
							 JOIN TIPOS_SALA ts ON ts.Id_Tipo_Sala = s.Id_Tipo_Sala
			WHERE f.id_sala = 2

--Cargar Salas

CREATE PROC SP_CARGA_SALAS
	AS
	SELECT id_sala, capacidad, id_tipo_sala
		FROM SALAS

CREATE PROC SP_CARGA_TIPOSSALA
	AS
	SELECT id_tipo_sala, tipo_sala
		FROM TIPOS_SALA
		
CREATE PROC SP_CARGA_TIPO_BUTACA
	AS
	SELECT id_tipo_butaca, tipo_butaca FROM TIPOS_BUTACAS

CREATE PROC SP_CARGA_BUTACAS
	AS
	SELECT id_butaca, id_fila, nro_butaca, id_tipo_butaca, id_sala
		FROM BUTACAS

CREATE PROC SP_CARGA_BUTACAS_FUNCIONES
	AS
	SELECT bf.id_butaca_funcion, bf.id_butaca, bf.id_funcion, bf.id_reserva, r.Id_Cliente, Fecha_Reserva
		FROM BUTACAS_FUNCIONES bf LEFT JOIN RESERVAS r ON bf.id_reserva = r.id_reserva;

CREATE PROC SP_CARGA_CLIENTES
	AS
	SELECT * FROM CLIENTES

CREATE PROC SP_ALTA_COMPRA @inIdCliente int=1, @inIdButaca int, @inIdFuncion int, @inPrecio float, @inReserva BIT=0
	AS
	BEGIN
		--id_comprobante(SP), id_empleado (1), id_cliente, fecha(hoy), hora(ahora), id_tipo_compra(0), descuento(null)
		--id_detalle_comprobante(SP), id_comprobante(SP), id_butaca_funcion(SP), precio_historico, cantidad(1), id_forma_pago(2)
		
		DECLARE @idReserva int
		IF(@inReserva = 1)
		BEGIN
			SET @idReserva = (SELECT MAX(id_reserva)+1 FROM RESERVAS)
			INSERT RESERVAS VALUES(@idReserva, @inIdCliente, GETDATE())
		END
		
		DECLARE @idButacaFuncion int = (SELECT MAX(id_butaca_funcion)+1 FROM BUTACAS_FUNCIONES)
		DECLARE @idComprobante int = (SELECT MAX(id_comprobante)+1 FROM COMPROBANTES)
		DECLARE @idDetalle int = (SELECT MAX(id_detalle_comprobante)+1 FROM DETALLES_COMBROBANTES)
		INSERT BUTACAS_FUNCIONES VALUES(@idButacaFuncion, @inIdButaca, @inIdFuncion, @idReserva)

		IF(@inReserva = 0)
		BEGIN
			INSERT COMPROBANTES VALUES (
				@idComprobante, 1, @inIdCliente, GETDATE(), CONVERT(DATETIME, CONVERT(TIME, GETDATE())), 0, NULL
			)
			INSERT DETALLES_COMBROBANTES VALUES (@idDetalle, @idComprobante, @idButacaFuncion, @inPrecio, 1, 2)
		END
	END
	
--==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-

/*
DECLARE @imageQuery nvarchar(500)
DECLARE @imagesPath nvarchar(500) = 'D:\00Nacho\Tecnicatura Universitaria en Programacion\00Materias 2do Cuatrimestre\3 Laboratorio de Computacion II\TPI\Parte_3\Estructura TPI 3\Imagenes\'
DECLARE @index int = 1
WHILE @index < 31
	BEGIN
	SET @imageQuery = 
	'UPDATE PELICULAS
		SET imagen = 
		(SELECT BulkColumn FROM OPENROWSET(BULK N''' + @imagesPath + CAST(@index as varchar(4)) + '.jpg'', 
		SINGLE_BLOB) image)
		WHERE id_pelicula = ' + CAST(@index as varchar(4)) + ''
	EXEC SP_EXECUTESQL @stmt = @imageQuery
	--PRINT @imageQuery
	SET @index += 1
	END

EXEC SP_EXECUTESQL @stmt = @imageQuery
*/

----Alex==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-
----Alex

--Select Nombre 'Pelicula'
--	from PELICULAS P
--		JOIN TIPOS_GENERO_PELICULA TP ON TP.Id_Tipo_Genero_Pelicula = P.Id_Genero 
--		JOIN IDIOMAS I ON I.Id_Idioma = P.Id_Idioma 
--		JOIN CALIFICACIONES_ETARIAS C ON C.Id_Calificacion_Etaria = P.Id_Calificacion_Etaria
--		JOIN PAIS_ORIGEN PA ON PA.Id_Pais_Origen = P.Id_Pais_Origen
--	where Id_Pelicula in (
--			select p.id_pelicula, p.Nombre, COUNT(*)
--				from FUNCIONES f JOIN PELICULAS p ON f.id_pelicula = p.Id_Pelicula
--								 JOIN BUTACAS_FUNCIONES bf ON bf.Id_Funcion = f.Id_Funcion
--								 JOIN DETALLES_COMBROBANTES dc ON dc.Id_Butaca_Funcion = bf.Id_Butaca_Funcion
--								 JOIN COMPROBANTES c ON dc.Id_Comprobante = c.Id_Comprobante
--				where year(dia) = year(GETDATE())   
--				GROUP BY p.Id_Pelicula, p.Nombre
--				ORDER BY COUNT(*) DESC
--	)


--SELECT DISTINCT Id_Pelicula FROM FUNCIONES WHERE YEAR(dia) = 2022

--SELECT * FROM FUNCIONES
--SELECT * FROM DETALLES_COMBROBANTES
--SELECT * FROM COMPROBANTES
