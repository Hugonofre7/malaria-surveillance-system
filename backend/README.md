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