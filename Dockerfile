FROM python:3.10-slim

# Instalar dependencias del sistema
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev

# Crear un directorio de trabajo
WORKDIR /app

# Instalar Superset y el driver de Postgres
RUN pip install --upgrade pip
RUN pip install apache-superset psycopg2-binary

# Exponer puerto
EXPOSE 8088

# Inicializar Superset (migraciones + admin + arranque)
CMD superset db upgrade && \
    superset fab create-admin \
      --username admin \
      --firstname Admin \
      --lastname User \
      --email admin@superset.com \
      --password admin123 || true && \
    superset init && \
    superset run -h 0.0.0.0 -p 8088
