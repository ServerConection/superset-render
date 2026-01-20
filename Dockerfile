FROM apache/superset:latest

USER root

# 1. Instalar herramientas necesarias para compilar drivers
RUN apt-get update && \
    apt-get install -y build-essential gcc libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# 2. Instalar soporte PostgreSQL para Superset
RUN pip install --no-cache-dir psycopg2-binary

EXPOSE 8088

# 3. Inicialización de Superset
CMD superset db upgrade && \
    superset fab create-admin \
      --username admin \
      --firstname Admin \
      --lastname User \
      --email admin@superset.com \
      --password admin123 || true && \
    superset init && \
    superset run -h 0.0.0.0 -p 8088
