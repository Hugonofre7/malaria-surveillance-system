# Data Dictionary — Malaria Surveillance System

This document provides a detailed description of the tables, fields, data types, constraints, and relationships that constitute the relational database schema for the Malaria Program (Vector Department, Secretariat of Health, Guerrero, Mexico).

---

## 1. Entity: `localidad` (Locality)
Stores geographic and administrative location information associated with epidemiological events.

| Column Name | Data Type | Nullable | Key | Constraints / Description |
| :--- | :--- | :--- | :--- | :--- |
| `id_localidad` | `INT` | NO | Primary Key | Auto-increment unique identifier. |
| `nombre_localidad` | `VARCHAR(100)` | NO | — | Name of the locality/community. |
| `municipio` | `VARCHAR(100)` | NO | — | Municipality name. |
| `estado` | `VARCHAR(100)` | NO | — | State name. |
| `zona_riesgo` | `ENUM` | NO | — | Risk level: `'ALTA'`, `'MEDIA'`, `'BAJA'`. |

* **Unique Constraints:** `uk_localidad_ubicacion` (`nombre_localidad`, `municipio`, `estado`).

---

## 2. Entity: `vivienda` (Dwelling)
Stores physical dwelling/household data linked to field activities and cases.

| Column Name | Data Type | Nullable | Key | Constraints / Description |
| :--- | :--- | :--- | :--- | :--- |
| `id_vivienda` | `INT` | NO | Primary Key | Auto-increment unique identifier. |
| `direccion` | `VARCHAR(150)` | NO | — | Physical address or reference location. |
| `tipo_vivienda` | `VARCHAR(50)` | YES | — | Structural housing type (e.g., Casa, Cabaña). |
| `condicion_sanitaria` | `VARCHAR(100)` | YES | — | Sanitary condition evaluation. |
| `id_localidad` | `INT` | NO | Foreign Key | References `localidad(id_localidad)`. |

* **Foreign Keys:**
  * `fk_vivienda_localidad`: `id_localidad` -> `localidad(id_localidad)` (`ON DELETE RESTRICT ON UPDATE CASCADE`).

---

## 3. Entity: `paciente` (Patient)
Contains demographic information of registered patients. Sensitive fields must be anonymized in public deployments.

| Column Name | Data Type | Nullable | Key | Constraints / Description |
| :--- | :--- | :--- | :--- | :--- |
| `id_paciente` | `INT` | NO | Primary Key | Auto-increment unique identifier. |
| `nombre` | `VARCHAR(100)` | NO | — | Patient full name (Synthetic in public repos). |
| `edad` | `INT` | YES | — | Patient age in years. |
| `sexo` | `ENUM` | NO | — | Gender: `'M'`, `'F'`. |
| `curp` | `VARCHAR(18)` | YES | Unique | Unique Population Registry Code (Anonymized). |
| `id_vivienda` | `INT` | NO | Foreign Key | References `vivienda(id_vivienda)`. |

* **Unique Constraints:** `uk_paciente_curp` (`curp`).
* **Foreign Keys:**
  * `fk_paciente_vivienda`: `id_vivienda` -> `vivienda(id_vivienda)` (`ON DELETE RESTRICT ON UPDATE CASCADE`).

---

## 4. Entity: `caso` (Malaria Case)
Represents clinical/epidemiological case events linked to patients.

| Column Name | Data Type | Nullable | Key | Constraints / Description |
| :--- | :--- | :--- | :--- | :--- |
| `id_caso` | `INT` | NO | Primary Key | Auto-increment unique identifier. |
| `fecha_diagnostico` | `DATE` | NO | — | Diagnosis date. |
| `tipo_caso` | `ENUM` | NO | — | Case type: `'SOSPECHOSO'`, `'CONFIRMADO'`. |
| `clasificacion` | `ENUM` | NO | — | Classification: `'IMPORTADO'`, `'AUTOCTONO'`. |
| `estatus` | `ENUM` | NO | — | Case status: `'ACTIVO'`, `'CERRADO'`. |
| `id_paciente` | `INT` | NO | Foreign Key | References `paciente(id_paciente)`. |

* **Foreign Keys:**
  * `fk_caso_paciente`: `id_paciente` -> `paciente(id_paciente)` (`ON DELETE RESTRICT ON UPDATE CASCADE`).

---

## 5. Entity: `laboratorio` (Laboratory Diagnostic)
Stores laboratory test results linked to specific reported cases.

| Column Name | Data Type | Nullable | Key | Constraints / Description |
| :--- | :--- | :--- | :--- | :--- |
| `id_laboratorio` | `INT` | NO | Primary Key | Auto-increment unique identifier. |
| `tipo_prueba` | `ENUM` | NO | — | Test type: `'GOTA_GRUESA'`, `'PRUEBA_RAPIDA'`. |
| `resultado` | `ENUM` | NO | — | Result: `'POSITIVO'`, `'NEGATIVO'`. |
| `fecha_prueba` | `DATE` | NO | — | Test execution date. |
| `id_caso` | `INT` | NO | Foreign Key | References `caso(id_caso)`. |

* **Foreign Keys:**
  * `fk_laboratorio_caso`: `id_caso` -> `caso(id_caso)` (`ON DELETE RESTRICT ON UPDATE CASCADE`).

---

## 6. Entity: `brigada` (Field Brigade / Vector Control Team)
Contains information regarding active field operation brigades.

| Column Name | Data Type | Nullable | Key | Constraints / Description |
| :--- | :--- | :--- | :--- | :--- |
| `id_brigada` | `INT` | NO | Primary Key | Auto-increment unique identifier. |
| `nombre_brigada` | `VARCHAR(100)` | NO | Unique | Name/identifier of the operational team. |
| `responsable` | `VARCHAR(100)` | YES | — | Name of brigade leader/responsible person. |
| `zona_asignada` | `VARCHAR(100)` | YES | — | Operational sector/zone assigned. |

* **Unique Constraints:** `uk_brigada_nombre` (`nombre_brigada`).

---

## 7. Entity: `intervencion` (Field Intervention)
Tracks vector control activities performed by brigades at specific dwellings.

| Column Name | Data Type | Nullable | Key | Constraints / Description |
| :--- | :--- | :--- | :--- | :--- |
| `id_intervencion` | `INT` | NO | Primary Key | Auto-increment unique identifier. |
| `tipo_intervencion` | `ENUM` | NO | — | Activity: `'FUMIGACION'`, `'LARVICIDA'`, `'CONTROL_FISICO'`. |
| `fecha` | `DATE` | NO | — | Execution date of the activity. |
| `observaciones` | `TEXT` | YES | — | Field observations and comments. |
| `id_brigada` | `INT` | NO | Foreign Key | References `brigada(id_brigada)`. |
| `id_vivienda` | `INT` | NO | Foreign Key | References `vivienda(id_vivienda)`. |

* **Foreign Keys:**
  * `fk_intervencion_brigada`: `id_brigada` -> `brigada(id_brigada)` (`ON DELETE RESTRICT ON UPDATE CASCADE`).
  * `fk_intervencion_vivienda`: `id_vivienda` -> `vivienda(id_vivienda)` (`ON DELETE RESTRICT ON UPDATE CASCADE`).