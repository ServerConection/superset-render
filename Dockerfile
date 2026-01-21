FROM apache/superset:latest

USER root

# Driver de Postgres
RUN pip install psycopg2-binary

USER superset

# Render asigna el puerto dinámicamente
CMD gunicorn \
  -w 2 \
  -k gevent \
  --timeout 120 \
  -b 0.0.0.0:$PORT \
  "superset.app:create_app()"
