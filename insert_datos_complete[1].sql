-- =======================================
-- INSERTS DE DATOS
-- =======================================

-- Equipos
INSERT INTO Equipos (nombre, region, fecha_creacion, manager) VALUES
('Dragons EC','LatAm','2018-03-15','Carlos Pérez'),
('Shadow Wolves','NA','2019-06-10','Megan Smith'),
('Cyber Titans','EU','2020-01-20','Lukas Müller'),
('Rising Suns','Asia','2017-08-25','Hiroshi Tanaka'),
('Andes Warriors','LatAm','2021-11-05','María González');

-- Jugadores
INSERT INTO Jugadores (nombre, apellido, edad, nacionalidad, rol, equipo_id) VALUES
('Juan','Martínez',22,'Ecuador','Carry',1),
('Pedro','Lopez',24,'Colombia','Support',1),
('Emily','Johnson',21,'USA','Mid',2),
('David','Smith',27,'USA','Offlane',2),
('Hans','Keller',25,'Alemania','Carry',3),
('Lucas','Müller',23,'Alemania','Support',3),
('Kenji','Sato',20,'Japón','Mid',4),
('Takeshi','Yamamoto',26,'Japón','Coach',4),
('Andrés','García',19,'Perú','Carry',5),
('Marcos','Fernández',28,'Chile','Support',5);

-- Competencias
INSERT INTO Competencias (nombre, fecha_inicio, fecha_fin, ubicacion, premio_total, tipo_competencia, estado) VALUES
('LatAm Masters 2025','2025-06-01','2025-06-15','Quito',50000.00,'Torneo','Activa'),
('World Esports League','2025-07-10','2025-07-30','Los Angeles',200000.00,'Liga','Activa'),
('Asian Championship','2025-08-05','2025-08-20','Tokyo',100000.00,'Campeonato','Activa'),
('Europe Clash Cup','2025-09-01','2025-09-18','Berlín',75000.00,'Torneo','Activa'),
('Andes Esports Open','2025-10-01','2025-10-10','Lima',30000.00,'Campeonato','Activa');

-- Competencia_Equipos
INSERT INTO Competencia_Equipos (competencia_id, equipo_id, grupo, seed) VALUES
(1,1,'A',1),(1,2,'A',2),(1,5,'B',3),
(2,3,'A',1),(2,4,'B',2),(2,1,'C',3),
(3,4,'A',1),(3,2,'B',2),
(4,3,'A',1),(4,1,'B',2),
(5,5,'A',1),(5,2,'B',2);

-- Partidas
INSERT INTO Partidas (competencia_id, fecha_hora, equipo_local_id, equipo_visitante_id, ronda, mejor_de, resultado_local, resultado_visitante, duracion_minutos, estado) VALUES
(1,'2025-06-02 15:00:00',1,2,'Cuartos de Final',3,2,1,45,'Finalizado'),
(1,'2025-06-03 17:00:00',5,1,'Semifinal',3,1,2,50,'Finalizado'),
(2,'2025-07-11 18:30:00',3,4,'Semifinal',5,3,2,55,'Finalizado'),
(2,'2025-07-12 20:00:00',1,3,'Final',5,2,3,60,'Finalizado'),
(3,'2025-08-06 20:00:00',4,2,'Final',3,0,0,NULL,'Programado'),
(4,'2025-09-02 16:00:00',3,1,'Cuartos',3,0,0,NULL,'Programado'),
(5,'2025-10-03 14:00:00',5,2,'Final',3,0,0,NULL,'Programado');

-- Estadisticas_Jugador_Partido
INSERT INTO Estadisticas_Jugador_Partido (partida_id,jugador_id,kills,deaths,assists,valor_neto,daño_infligido,daño_recibido,heroe) VALUES
(1,1,12,3,8,15000.50,25000,12000,'Invoker'),
(1,2,2,2,5,15,9000.00,10000,'Crystal Maiden'),
(1,3,10,4,6,14000.75,20000,13000,'Storm Spirit'),
(1,4,4,6,12,11000.20,15000,16000,'Earthshaker'),
(2,5,20,2,10,20000.00,30000,10000,'Phantom Assassin'),
(2,6,3,8,18,9500.00,12000,17000,'Lion'),
(2,7,14,5,7,17000.00,22000,14000,'Shadow Fiend');
