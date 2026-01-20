FROM apache/superset:latest

# 1. Pasar a root para poder instalar cosas
USER root

# 2. Instalar el driver de Postgres (psycopg2)
RUN pip install --no-cache-dir psycopg2-binary

# 3. Volver al usuario superset por seguridad (opcional, pero recomendado)
# USER superset

EXPOSE 8088

# 4. El comando de inicio (Script de inicialización)
CMD superset db upgrade && \
    superset fab create-admin \
      --username admin \
      --firstname Admin \
      --lastname User \
      --email admin@superset.com \
      --password admin123 || true && \
    superset init && \
    superset run -h 0.0.0.0 -p 8088
