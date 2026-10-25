-- SAMPLE ANALYTICAL QUERIES
-- Malaria Surveillance System

USE paludismo_db;


-- QUERY 1: Complete Patient Epidemiological Traceability
-- Purpose: Join patient, dwelling, locality, case, and diagnostic lab test.

SELECT 
    p.id_paciente,
    p.nombre AS paciente_nombre,
    p.edad,
    p.sexo,
    l.nombre_localidad,
    l.municipio,
    l.zona_riesgo,
    v.direccion AS vivienda_direccion,
    c.id_caso,
    c.fecha_diagnostico,
    c.tipo_caso,
    c.clasificacion,
    c.estatus AS caso_estatus,
    lab.tipo_prueba,
    lab.resultado AS resultado_laboratorio,
    lab.fecha_prueba
FROM paciente p
INNER JOIN vivienda v ON p.id_vivienda = v.id_vivienda
INNER JOIN localidad l ON v.id_localidad = l.id_localidad
INNER JOIN caso c ON p.id_paciente = c.id_paciente
LEFT JOIN laboratorio lab ON c.id_caso = lab.id_caso;



-- QUERY 2: Active Confirmed Cases by Locality and Risk Zone
-- Purpose: Aggregate total active cases grouped by community and risk level.

SELECT 
    l.nombre_localidad,
    l.municipio,
    l.zona_riesgo,
    COUNT(c.id_caso) AS total_casos_confirmados_activos
FROM caso c
INNER JOIN paciente p ON c.id_paciente = p.id_paciente
INNER JOIN vivienda v ON p.id_vivienda = v.id_vivienda
INNER JOIN localidad l ON v.id_localidad = l.id_localidad
WHERE c.tipo_caso = 'CONFIRMADO' 
  AND c.estatus = 'ACTIVO'
GROUP BY l.id_localidad, l.nombre_localidad, l.municipio, l.zona_riesgo
ORDER BY total_casos_confirmados_activos DESC;


-- QUERY 3: Field Brigade Interventions by Dwelling
-- Purpose: Track vector control activities conducted by active operational teams.

SELECT 
    i.id_intervencion,
    i.fecha AS fecha_intervencion,
    i.tipo_intervencion,
    b.nombre_brigada,
    b.responsable AS responsable_brigada,
    v.direccion AS vivienda_intervenida,
    l.nombre_localidad,
    i.observaciones
FROM intervencion i
INNER JOIN brigada b ON i.id_brigada = b.id_brigada
INNER JOIN vivienda v ON i.id_vivienda = v.id_vivienda
INNER JOIN localidad l ON v.id_localidad = l.id_localidad
ORDER BY i.fecha DESC;