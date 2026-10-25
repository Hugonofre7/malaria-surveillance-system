# Malaria Epidemiological Information System

Relational database for tracking cases, localities, and risk zones for the Malaria Program (Vector Department, Secretariat of Health of the State of Guerrero, Mexico).

---

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MySQL](https://img.shields.io/badge/MySQL-8.4%2B-blue.svg)](https://www.mysql.com/)
[![Status](https://img.shields.io/badge/Status-Active%20Prototype-green.svg)]()

## 📌 Project Overview
The **Malaria Epidemiological Information System** is a relational database architecture designed to centralize, organize, and streamline the management of epidemiological data, risk areas, dwellings, and vector control field activities. 

This project was developed in coordination with the **Malaria Program of the Vector Department, Guerrero State Health Secretariat (Chilpancingo, Mexico)** as part of professional engineering practices, and it is structured as a robust portfolio project and foundational base for advanced public health informatics research.

---

## 🏗️ Database Architecture & Entity Model
The relational database (`paludismo_db`) consists of **7 core normalized tables** configured with strict foreign key constraints (`ON DELETE RESTRICT`, `ON UPDATE CASCADE`) to ensure referential integrity:

1. **`localidad` (Locality):** Geographic and administrative regions categorized by risk levels (`ALTA`, `MEDIA`, `BAJA`).
2. **`vivienda` (Dwelling):** Physical household units linked to localities and targeted for field interventions[cite: 1, 2].
3. **`paciente` (Patient):** Demographic records of individuals evaluated for epidemiological events (fully anonymized for public repositories)[cite: 1, 2].
4. **`caso` (Malaria Case):** Clinical diagnostic event tracking (suspected/confirmed cases, classification, and active/closed status)[cite: 1, 2].
5. **`laboratorio` (Laboratory Diagnostic):** Diagnostic test results (thick blood smear, rapid diagnostic tests) linked to specific cases[cite: 1, 2].
6. **`brigada` (Field Brigade):** Operational vector control teams and assigned zones[cite: 1, 2].
7. **`intervencion` (Field Intervention):** Tracking vector control activities (fumigation, larviciding, physical control) performed at dwellings by brigades[cite: 1, 2].

For a detailed breakdown of fields, data types, and constraints, see the [Data Documentation (`docs/data_dictionary.md`)](docs/data_dictionary.md)[cite: 1].

---

## 📂 Repository Structure

```text
malaria-surveillance-system/
├── database/
│   ├── schema.sql      # DDL script: Database creation, tables, and FK constraints
│   ├── seeds.sql       # DML script: Synthetic and anonymized test data
│   └── queries.sql     # Analytical SQL queries for epidemiological reporting
├── diagrams/           # EER models and visual database exports
├── docs/
│   └── data_dictionary.md # Comprehensive technical data dictionary
├── tests/              # SQL validation scripts and test cases
├── .gitignore          # Excluded temporary and system files
└── README.md           # Project documentation and portfolio presentation

## 🚀 Getting Started & Local Reproduction

### Prerequisites
* **MySQL Server** (v8.0 or higher)
* **MySQL Workbench** or any preferred SQL client (DBeaver, DataGrip, VS Code SQL extensions)

### Installation Steps
1. **Clone the repository:**
   ```bash
   git clone git@github.com:Hugonofre7/malaria-surveillance-system.git
   cd malaria-surveillance-system

🔒 Security & Privacy ConsiderationsAnonymization.

 All patient names, CURP codes, and addresses contained within public repository seeds (database/seeds.sql) are 100% synthetic and randomized to comply with health data privacy standards.   
 
 Institutional Scope: Operational deployment in production requires official authorization, strict Role-Based Access Control (RBAC), and compliance with regional health data governance regulations.   

 🔮 Future RoadmapREST API Layer.
  Backend development to handle secure authentication, validation, and authorized operations.   
  
  Geospatial Analytics: Integration of secure geographic data clustering for aggregate risk zone mapping (subject to privacy protocols).   
  Executive Dashboards: BI indicators to track operational efficiency and epidemiological trends.   
  
  👤 Author:
  Hugo Antonio Onofre Rojas
  Computer Systems Engineering Degree