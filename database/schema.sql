-- =========================================
-- DATABASE SCHEMA: MALARIA SURVEILLANCE
-- Epidemiological Information System
-- =========================================

CREATE DATABASE IF NOT EXISTS paludismo_db;
USE paludismo_db;

-- 1. LOCALITY
CREATE TABLE localidad (
    id_localidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_localidad VARCHAR(100) NOT NULL,
    municipio VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    zona_riesgo ENUM('ALTA', 'MEDIA', 'BAJA') NOT NULL,
    CONSTRAINT uk_localidad_ubicacion UNIQUE (nombre_localidad, municipio, estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. DWELLING
CREATE TABLE vivienda (
    id_vivienda INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(150) NOT NULL,
    tipo_vivienda VARCHAR(50),
    condicion_sanitaria VARCHAR(100),
    id_localidad INT NOT NULL,
    CONSTRAINT fk_vivienda_localidad FOREIGN KEY (id_localidad) 
        REFERENCES localidad(id_localidad) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. PATIENT
CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edad INT,
    sexo ENUM('M', 'F') NOT NULL,
    curp VARCHAR(18),
    id_vivienda INT NOT NULL,
    CONSTRAINT uk_paciente_curp UNIQUE (curp),
    CONSTRAINT fk_paciente_vivienda FOREIGN KEY (id_vivienda) 
        REFERENCES vivienda(id_vivienda) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. EPIDEMIOLOGICAL CASE
CREATE TABLE caso (
    id_caso INT AUTO_INCREMENT PRIMARY KEY,
    fecha_diagnostico DATE NOT NULL,
    tipo_caso ENUM('SOSPECHOSO', 'CONFIRMADO') NOT NULL,
    clasificacion ENUM('IMPORTADO', 'AUTOCTONO') NOT NULL,
    estatus ENUM('ACTIVO', 'CERRADO') NOT NULL,
    id_paciente INT NOT NULL,
    CONSTRAINT fk_caso_paciente FOREIGN KEY (id_paciente) 
        REFERENCES paciente(id_paciente) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. LABORATORY DIAGNOSTIC
CREATE TABLE laboratorio (
    id_laboratorio INT AUTO_INCREMENT PRIMARY KEY,
    tipo_prueba ENUM('GOTA_GRUESA', 'PRUEBA_RAPIDA') NOT NULL,
    resultado ENUM('POSITIVO', 'NEGATIVO') NOT NULL,
    fecha_prueba DATE NOT NULL,
    id_caso INT NOT NULL,
    CONSTRAINT fk_laboratorio_caso FOREIGN KEY (id_caso) 
        REFERENCES caso(id_caso) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. FIELD BRIGADE
CREATE TABLE brigada (
    id_brigada INT AUTO_INCREMENT PRIMARY KEY,
    nombre_brigada VARCHAR(100) NOT NULL,
    responsable VARCHAR(100),
    zona_asignada VARCHAR(100),
    CONSTRAINT uk_brigada_nombre UNIQUE (nombre_brigada)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. FIELD INTERVENTION
CREATE TABLE intervencion (
    id_intervencion INT AUTO_INCREMENT PRIMARY KEY,
    tipo_intervencion ENUM('FUMIGACION', 'LARVICIDA', 'CONTROL_FISICO') NOT NULL,
    fecha DATE NOT NULL,
    observaciones TEXT,
    id_brigada INT NOT NULL,
    id_vivienda INT NOT NULL,
    CONSTRAINT fk_intervencion_brigada FOREIGN KEY (id_brigada) 
        REFERENCES brigada(id_brigada) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_intervencion_vivienda FOREIGN KEY (id_vivienda) 
        REFERENCES vivienda(id_vivienda) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;