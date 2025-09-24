CREATE DATABASE IF NOT EXISTS esports_competitions;
USE esports_competitions;

-- Tabla de Equipos
CREATE TABLE Equipos (
    equipo_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(50) NOT NULL,
    fecha_creacion DATE,
    manager VARCHAR(100),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_equipos_region (region),
    INDEX idx_equipos_activo (activo)
);

-- Tabla de Jugadores
CREATE TABLE Jugadores (
    jugador_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    edad INT NOT NULL CHECK (edad >= 13 AND edad <= 50),
    nacionalidad VARCHAR(50),
    rol ENUM('Carry', 'Support', 'Mid', 'Offlane', 'Coach') NOT NULL,
    equipo_id INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (equipo_id) REFERENCES Equipos(equipo_id) ON DELETE SET NULL ON UPDATE CASCADE,
    INDEX idx_jugadores_equipo (equipo_id),
    INDEX idx_jugadores_rol (rol),
    UNIQUE(nombre, apellido, equipo_id)
);

-- Tabla de Competencias
CREATE TABLE Competencias (
    competencia_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    premio_total DECIMAL(15,2) NOT NULL CHECK (premio_total >= 0),
    tipo_competencia ENUM('Torneo', 'Liga', 'Campeonato') NOT NULL,
    estado ENUM('Activa', 'Finalizada', 'Cancelada') DEFAULT 'Activa',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_competencias_fecha (fecha_inicio, fecha_fin),
    INDEX idx_competencias_tipo (tipo_competencia),
    UNIQUE(nombre, fecha_inicio)
);

-- Tabla intermedia Competencia-Equipos
CREATE TABLE Competencia_Equipos (
    competencia_equipo_id INT PRIMARY KEY AUTO_INCREMENT,
    competencia_id INT NOT NULL,
    equipo_id INT NOT NULL,
    grupo VARCHAR(1) NOT NULL,
    seed INT NOT NULL CHECK (seed >= 1 AND seed <= 16),
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (competencia_id) REFERENCES Competencias(competencia_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (equipo_id) REFERENCES Equipos(equipo_id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_comp_equipos_comp (competencia_id),
    INDEX idx_comp_equipos_equipo (equipo_id),
    UNIQUE(competencia_id, equipo_id)
);

-- Tabla de Partidos
CREATE TABLE Partidas (
    partida_id INT PRIMARY KEY AUTO_INCREMENT,
    competencia_id INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    equipo_local_id INT NOT NULL,
    equipo_visitante_id INT NOT NULL,
    ronda VARCHAR(50) NOT NULL,
    mejor_de INT DEFAULT 3 CHECK (mejor_de IN (1,3,5)),
    resultado_local INT DEFAULT 0 CHECK (resultado_local >= 0),
    resultado_visitante INT DEFAULT 0 CHECK (resultado_visitante >= 0),
    duracion_minutos INT,
    estado ENUM('Programado','EnCurso','Finalizado','Cancelado') DEFAULT 'Programado',
    FOREIGN KEY (competencia_id) REFERENCES Competencias(competencia_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (equipo_local_id) REFERENCES Equipos(equipo_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (equipo_visitante_id) REFERENCES Equipos(equipo_id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_partidas_competencia (competencia_id),
    INDEX idx_partidas_fecha (fecha_hora),
    INDEX idx_partidas_estado (estado)
);

-- Tabla de Estadísticas de Jugadores por Partido (sin equipo_id)
CREATE TABLE Estadisticas_Jugador_Partido (
    estadistica_id INT PRIMARY KEY AUTO_INCREMENT,
    partida_id INT NOT NULL,
    jugador_id INT NOT NULL,
    kills INT DEFAULT 0 CHECK (kills >= 0),
    deaths INT DEFAULT 0 CHECK (deaths >= 0),
    assists INT DEFAULT 0 CHECK (assists >= 0),
    valor_neto DECIMAL(10,2) DEFAULT 0 CHECK (valor_neto >= 0),
    daño_infligido INT DEFAULT 0 CHECK (daño_infligido >= 0),
    daño_recibido INT DEFAULT 0 CHECK (daño_recibido >= 0),
    heroe VARCHAR(50) NOT NULL,
    FOREIGN KEY (partida_id) REFERENCES Partidas(partida_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (jugador_id) REFERENCES Jugadores(jugador_id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_estadisticas_partida (partida_id),
    INDEX idx_estadisticas_jugador (jugador_id),
    UNIQUE(partida_id, jugador_id)
);