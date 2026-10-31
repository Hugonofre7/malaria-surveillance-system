# Entity-Relationship Diagram (EER) — Malaria Surveillance System

This document visualizes the relational schema (`paludismo_db`) and primary/foreign key relationships across all 7 entities using standard Mermaid entity-relationship syntax natively rendered by GitHub.

---

```mermaid
erDiagram
    LOCALIDAD ||--o{ VIVIENDA : "contiene (id_localidad)"
    VIVIENDA ||--o{ PACIENTE : "alberga (id_vivienda)"
    VIVIENDA ||--o{ INTERVENCION : "recibe (id_vivienda)"
    PACIENTE ||--o{ CASO : "registra (id_paciente)"
    CASO ||--o{ LABORATORIO : "valida (id_caso)"
    BRIGADA ||--o{ INTERVENCION : "ejecuta (id_brigada)"

    LOCALIDAD {
        int id_localidad PK
        string nombre_localidad
        string municipio
        string estado
        enum zona_riesgo
    }

    VIVIENDA {
        int id_vivienda PK
        string direccion
        string tipo_vivienda
        string condicion_sanitaria
        int id_localidad FK
    }

    PACIENTE {
        int id_paciente PK
        string nombre
        int edad
        enum sexo
        string curp UK
        int id_vivienda FK
    }

    CASO {
        int id_caso PK
        date fecha_diagnostico
        enum tipo_caso
        enum clasificacion
        enum estatus
        int id_paciente FK
    }

    LABORATORIO {
        int id_laboratorio PK
        enum tipo_prueba
        enum resultado
        date fecha_prueba
        int id_caso FK
    }

    BRIGADA {
        int id_brigada PK
        string nombre_brigada UK
        string responsable
        string zona_asignada
    }

    INTERVENCION {
        int id_intervencion PK
        enum tipo_intervencion
        date fecha
        text observaciones
        int id_brigada FK
        int id_vivienda FK
    }