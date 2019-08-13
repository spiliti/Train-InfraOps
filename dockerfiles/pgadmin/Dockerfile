# FROM python:3.7.3-alpine3.10
# RUN  apk add --no-cache postgresql-libs && \
#      apk add --no-cache --virtual .build-deps gcc musl-dev make postgresql-dev libffi-dev && \
#      python3 -m pip install uwsgi --no-cache-dir https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v4.10/pip/pgadmin4-4.10-py2.py3-none-any.whl && \
#      apk --purge del .build-deps
# CMD uwsgi --http-socket 0.0.0.0:80 \
#       --processes 1 \
#       --threads 25 \
#       --chdir /usr/local/lib/python3.7/site-packages/pgadmin4/ \
#       --mount /=pgAdmin4:app

FROM python:3.7.3-alpine3.10

# create a non-privileged user to use at runtime
# RUN addgroup -g 50 -S pgadmin \
#  && adduser -D -S -h /pgadmin -s /sbin/nologin -u 1000 -G pgadmin pgadmin \
#  && mkdir -p /pgadmin/config /pgadmin/storage \
#  && chown -R 1000:50 /pgadmin

RUN mkdir -p /pgadmin/config /pgadmin/storage

# Install postgresql tools for backup/restore
RUN apk add --no-cache libedit postgresql \
 && cp /usr/bin/psql /usr/bin/pg_dump /usr/bin/pg_dumpall /usr/bin/pg_restore /usr/local/bin/ \
 && apk del postgresql

RUN apk add --no-cache postgresql-dev libffi-dev

ENV PGADMIN_VERSION=4.10
ENV PYTHONDONTWRITEBYTECODE=1

RUN apk add --no-cache alpine-sdk linux-headers \
 && pip install --upgrade pip \
 && echo "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${PGADMIN_VERSION}/pip/pgadmin4-${PGADMIN_VERSION}-py2.py3-none-any.whl" | pip install --no-cache-dir -r /dev/stdin \
 && pip install uwsgi && apk del alpine-sdk linux-headers

EXPOSE 5050

COPY config_distro.py /usr/local/lib/python3.7/site-packages/pgadmin4/

COPY entrypoint.sh init.py /

# USER pgadmin:pgadmin
# CMD ["python", "./usr/local/lib/python2.7/site-packages/pgadmin4/pgAdmin4.py"]
VOLUME /pgadmin/
CMD ["/entrypoint.sh"]

