-- 1 pregunta
SELECT e.nombre AS equipo, 
       COUNT(p.partida_id) AS victorias
FROM Equipos e
JOIN Partidas p ON e.equipo_id = p.equipo_local_id AND p.resultado_local > p.resultado_visitante
               OR e.equipo_id = p.equipo_visitante_id AND p.resultado_visitante > p.resultado_local
GROUP BY e.equipo_id
ORDER BY victorias DESC
LIMIT 1;

-- 2 pregunta
SELECT j.nombre, j.apellido,
       AVG(CASE 
               WHEN (j.jugador_id = ej.jugador_id AND p.resultado_local > p.resultado_visitante AND p.equipo_local_id = ej.jugador_id)
                OR (j.jugador_id = ej.jugador_id AND p.resultado_visitante > p.resultado_local AND p.equipo_visitante_id = ej.jugador_id)
               THEN 1 ELSE 0 END) AS promedio_victorias
FROM Jugadores j
JOIN Estadisticas_Jugador_Partido ej ON j.jugador_id = ej.jugador_id
JOIN Partidas p ON ej.partida_id = p.partida_id
GROUP BY j.jugador_id
ORDER BY promedio_victorias DESC
LIMIT 1;

-- 3 pregunta
SELECT c.nombre AS competencia,
       COUNT(ce.equipo_id) AS total_equipos
FROM Competencias c
JOIN Competencia_Equipos ce ON c.competencia_id = ce.competencia_id
GROUP BY c.competencia_id
ORDER BY total_equipos DESC;