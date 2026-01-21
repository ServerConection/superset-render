FROM python:3.10-slim

# Dependencias del sistema
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Instalar Superset + Postgres
RUN pip install --upgrade pip && \
    pip install apache-superset psycopg2-binary gunicorn

# Variables necesarias
ENV SUPERSET_ENV=production
ENV FLASK_ENV=production

# Puerto para Render
EXPOSE 8088

# Arranque FORZADO (sí, se reinicia, pero FUNCIONA)
CMD superset db upgrade && \
    superset fab create-admin \
      --username admin \
      --firstname Admin \
      --lastname User \
      --email admin@superset.com \
      --password admin123 || true && \
    superset init && \
    gunicorn \
      --workers 2 \
      --timeout 120 \
      --bind 0.0.0.0:$PORT \
      "superset.app:create_app()"
