FROM apache/superset:latest
RUN pip install apache-superset[postgres]

USER root

EXPOSE 8088

CMD superset db upgrade && \
    superset fab create-admin \
      --username admin \
      --firstname Admin \
      --lastname User \
      --email admin@superset.com \
      --password admin123 || true && \
    superset init && \
    superset run -h 0.0.0.0 -p 8088
