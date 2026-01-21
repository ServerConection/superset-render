FROM apache/superset:latest

USER root

RUN pip install psycopg2-binary

USER superset

CMD gunicorn \
  -w 2 \
  --timeout 120 \
  -b 0.0.0.0:$PORT \
  "superset.app:create_app()"
