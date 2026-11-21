# Backend — Malaria Surveillance API

RESTful API built with Python, FastAPI, and SQLAlchemy for epidemiological data management.

## Installation & Setup

Create and activate a virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate

 Install dependencies:
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt

pip install --upgrade pip
pip install -r requirements.txt

Troubleshooting: Python 3.13 & Pydantic Core Compatibility
Issue: When using Python 3.13, older versions of pydantic-core attempt to compile from source via maturin/Cargo and fail with TypeError: ForwardRef._evaluate() missing 1 required keyword-only argument: 'recursive_guard'.

Solution: Use pydantic>=2.10.6 and fastapi>=0.110.2 in requirements.txt to leverage precompiled binary wheels compatible with Python 3.13.

### Troubleshooting: SQLAlchemy & Python 3.13 Compatibility
* **Issue:** Older versions of `sqlalchemy` fail during initialization under Python 3.13 with an `AssertionError: Class <class 'sqlalchemy.sql.elements.SQLCoreOperations'> directly inherits TypingOnly...` due to internal type introspection changes.
* **Solution:** Ensure you are using `sqlalchemy>=2.0.38` in `requirements.txt` to leverage full compatibility with Python 3.13

## Configuración de entorno y base de datos (MySQL)

La conexión a MySQL se configura en `app/database.py` mediante `load_dotenv()`, leyendo las variables `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `DB_PORT` y `DB_NAME` desde un archivo `.env` ubicado en `backend/.env` (asegúrate de mantener `.env` en `.gitignore` para no exponer credenciales).

### 1. Crear el archivo `backend/.env`

```env
DB_USER=root
DB_PASSWORD=tu_password_de_mysql
DB_HOST=localhost
DB_PORT=3306
DB_NAME=paludismo_db

## 2. Dependencia cryptography en el entorno virtual
Cuando el usuario de MySQL utiliza métodos de autenticación como caching_sha2_password o sha256_password, PyMySQL requiere el paquete cryptography instalado en el venv:

pip install cryptography
pip freeze > requirements.txt

## 3. Verificar o crear la base de datos paludismo_db
Con el servicio de MySQL iniciado, verifica tu acceso y asegúrate de que exista la base de datos antes de arrancar Uvicorn:

/usr/local/mysql/bin/mysql -u root -p
Dentro del monitor de MySQL:

SQL
CREATE DATABASE IF NOT EXISTS paludismo_db;
SHOW DATABASES LIKE 'paludismo_db';
EXIT;
Solución de problemas frecuentes (MySQL)
OperationalError: (1045, "Access denied for user 'root'@'localhost'")
Causa habitual: El archivo backend/.env no existe, tiene una línea mal formateada que impide a python-dotenv cargarlo, o DB_PASSWORD no coincide con la contraseña real asignada a 'root'@'localhost' en MySQL (cayendo en cadena vacía por defecto en app/database.py).

Revisión rápida:

Confirma que backend/.env exista y que todas sus líneas sigan el formato CLAVE=VALOR sin caracteres inválidos.

Comprueba que puedas iniciar sesión con el cliente CLI de MySQL usando la misma contraseña definida en DB_PASSWORD.

Restablecer la contraseña de 'root'@'localhost' en macOS (si no coincide)
Detén cualquier instancia previa de MySQL y verifica que no queden procesos mysqld o mysqld_safe activos (pgrep -fl mysqld).

Crea un archivo temporal /tmp/mysql_reset.sql con la nueva contraseña y la creación de la base:

SQL
ALTER USER 'root'@'localhost' IDENTIFIED BY 'tu_nueva_password';
CREATE DATABASE IF NOT EXISTS paludismo_db;
FLUSH PRIVILEGES;
Inicia mysqld aplicando el script y luego elimina /tmp/mysql_reset.sql:

Bash
sudo /usr/local/mysql/bin/mysqld --user=mysql --init-file=/tmp/mysql_reset.sql
rm -f /tmp/mysql_reset.sql
Actualiza DB_PASSWORD en backend/.env con esa misma contraseña y vuelve a levantar el servidor con uvicorn app.main:app --reload.