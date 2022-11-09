--INSERTS NUEVOS 
INSERT INTO FUNCIONES VALUES (27,25,2,'11/10/2022','13:30',950)
INSERT INTO FUNCIONES VALUES (28,25,2,'11/10/2022','16:00',950)
INSERT INTO FUNCIONES VALUES (29,29,1,'11/10/2022','13:00',950)
INSERT INTO FUNCIONES VALUES (30,29,1,'11/11/2022','15:45',950)
INSERT INTO FUNCIONES VALUES (31,27,3,'11/11/2022','20:00',950)
INSERT INTO FUNCIONES VALUES (32,25,2,'11/11/2022','22:00',950)
INSERT INTO FUNCIONES VALUES (33,26,3,'11/12/2022','13:00',950)
INSERT INTO FUNCIONES VALUES (34,26,3,'11/12/2022','17:00',950)
INSERT INTO FUNCIONES VALUES (35,26,3,'11/12/2022','20:00',950)
INSERT INTO FUNCIONES VALUES (36,30,1,'11/13/2022','13:30',950)
INSERT INTO FUNCIONES VALUES (37,30,3,'11/13/2022','13:00',950)
INSERT INTO FUNCIONES VALUES (38,30,3,'11/13/2022','15:45',950)
INSERT INTO FUNCIONES VALUES (39,30,3,'11/14/2022','13:00',950)

---SP 
--Para cargar el combo de estrenos
CREATE PROC SP_CONSULTAR_ESTRENOS 
AS
SELECT  DISTINCT  f.id_pelicula,Nombre,Id_Funcion,dia
FROM PELICULAS P
JOIN FUNCIONES F ON F.Id_Pelicula = P.Id_Pelicula
WHERE Dia  >= GETDATE()  

--Para mostrar los estrenos en la grilla 
create procedure SP_CONSULTAR_FUNCIONES_ESTRENOS 
@id int
as
SELECT  Nombre 'Pelicula',tp.Tipo_Genero_Pelicula  'Genero', C.Calificacion_Etarias,Duracion , idioma ,Subtitulada , Dia, Horario
FROM PELICULAS P
JOIN FUNCIONES F ON F.Id_Pelicula = P.Id_Pelicula
JOIN TIPOS_GENERO_PELICULA TP ON TP.Id_Tipo_Genero_Pelicula = P.Id_Genero 
JOIN IDIOMAS I ON I.Id_Idioma = P.Id_Idioma 
JOIN CALIFICACIONES_ETARIAS C ON C.Id_Calificacion_Etaria = P.Id_Calificacion_Etaria
WHERE  f.id_pelicula = @id 
AND  Dia  >= GETDATE()  

---Para mostrar las peliculas mas vistas en el año 
Create proc peliculas_mas_vistas_por_año
@Año int
 as
select p.Nombre, COUNT(*) 'Cantidad de Entradas vendidas'
from FUNCIONES f JOIN PELICULAS p ON f.id_pelicula = p.Id_Pelicula
                 JOIN BUTACAS_FUNCIONES bf ON bf.Id_Funcion = f.Id_Funcion
                 JOIN DETALLES_COMBROBANTES dc ON dc.Id_Butaca_Funcion = bf.Id_Butaca_Funcion
                 JOIN COMPROBANTES c ON dc.Id_Comprobante = c.Id_Comprobante
                where year(dia) = @Año
                GROUP BY p.Id_Pelicula, p.Nombre
                ORDER BY COUNT(*) DESC

---Para mostrar los generos mas vistos por año 
create proc Generos_mas_vistos_por_año
@Año int
 as
select G.Tipo_Genero_Pelicula 'Generos', COUNT(*) 'Cantidad de Entradas vendidas'
from FUNCIONES f JOIN PELICULAS p ON f.id_pelicula = p.Id_Pelicula
                 JOIN BUTACAS_FUNCIONES bf ON bf.Id_Funcion = f.Id_Funcion
                 JOIN DETALLES_COMBROBANTES dc ON dc.Id_Butaca_Funcion = bf.Id_Butaca_Funcion
                 JOIN COMPROBANTES c ON dc.Id_Comprobante = c.Id_Comprobante
				 JOIN TIPOS_GENERO_PELICULA G ON P.Id_Genero = G.Id_Tipo_Genero_Pelicula
                where year(dia) = @Año
                GROUP BY G.Id_Tipo_Genero_Pelicula, G.Tipo_Genero_Pelicula
                ORDER BY COUNT(*) DESC
