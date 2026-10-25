-- REFERENTIAL INTEGRITY & CONSTRAINT TESTS
-- Malaria Surveillance System

USE paludismo_db;


-- TEST 1: Foreign Key Restriction on Delete
-- Expectation: Expect Error 1451 (Cannot delete parent row with foreign key constraint)
-- Purpose: Verify that deleting a locality with existing dwellings is restricted.

-- DELETE FROM localidad WHERE id_localidad = 1;



-- TEST 2: Unique Constraint Verification on Patient CURP
-- Expectation: Expect Error 1062 (Duplicate entry for key 'uk_paciente_curp')
-- Purpose: Prevent registering duplicate patient identity codes.

-- INSERT INTO paciente (nombre, edad, sexo, curp, id_vivienda)
-- VALUES ('Duplicate Patient Test', 25, 'F', 'XXXX000101HGRXXX01', 1);



-- TEST 3: Invalid Foreign Key Reference
-- Expectation: Expect Error 1452 (Cannot add or update a child row: a foreign key constraint fails)
-- Purpose: Prevent creating a case for a non-existent patient ID.

-- INSERT INTO caso (fecha_diagnostico, tipo_caso, clasificacion, estatus, id_paciente)
-- VALUES ('2026-03-25', 'CONFIRMADO', 'AUTOCTONO', 'ACTIVO', 9999);