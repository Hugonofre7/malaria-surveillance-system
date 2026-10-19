-- =========================================
-- SYNTHETIC TEST DATA (SEEDS)
-- Epidemiological Surveillance Information System
-- =========================================

USE paludismo_db;

-- 1. LOCALIDAD
INSERT INTO localidad (nombre_localidad, municipio, estado, zona_riesgo)
VALUES ('Chilpancingo Centro', 'Chilpancingo', 'Guerrero', 'MEDIA');

-- 2. VIVIENDA
INSERT INTO vivienda (direccion, tipo_vivienda, condicion_sanitaria, id_localidad)
VALUES ('Calle 123, Col Centro', 'Casa', 'Buena', 1);

-- 3. PACIENTE (Synthetic data for public repository security)
INSERT INTO paciente (nombre, edad, sexo, curp, id_vivienda)
VALUES ('Patient Synthetic 01', 30, 'M', 'XXXX000101HGRXXX01', 1);

-- 4. CASO
INSERT INTO caso (fecha_diagnostico, tipo_caso, clasificacion, estatus, id_paciente)
VALUES ('2026-03-23', 'CONFIRMADO', 'AUTOCTONO', 'ACTIVO', 1);

-- 5. LABORATORIO
INSERT INTO laboratorio (tipo_prueba, resultado, fecha_prueba, id_caso)
VALUES ('GOTA_GRUESA', 'POSITIVO', '2026-03-23', 1);

-- 6. BRIGADA
INSERT INTO brigada (nombre_brigada, responsable, zona_asignada)
VALUES ('Brigada Centro', 'Carlos Lopez', 'Zona Centro');

-- 7. INTERVENCION
INSERT INTO intervencion (tipo_intervencion, fecha, observaciones, id_brigada, id_vivienda)
VALUES ('FUMIGACION', '2026-03-24', 'Fumigation completed successfully', 1, 1);