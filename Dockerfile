FROM apache/superset:latest

USER root

# Driver Postgres
RUN pip install psycopg2-binary

USER superset

# Arranque limpio (NO inicializa, NO crea usuarios)
CMD gunicorn \
  -w 2 \
  --timeout 120 \
  -b 0.0.0.0:$PORT \
  "superset.app:create_app()"
