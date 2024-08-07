FROM python:3.13.0b2-slim
MAINTAINER Stephan Telling <st@telling.xyz>

ENV DOCKERIZE_VERSION="v0.6.1" \
    PYTHONUNBUFFERED="1" \
    DJANGO_VERSION="3.2.5" \
    DJANGO_DB_HOST="" \
    DJANGO_DB_PORT="" \
    DJANGO_SUPERUSER_NAME="" \
    DJANGO_SUPERUSER_MAIL="" \
    DJANGO_SUPERUSER_PASS=""

RUN apt-get update && apt-get install -y \
        gcc \
        gettext \
        libmariadb-dev \
        libpq-dev \
        sqlite3 \
        wget \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir /code
WORKDIR /code

RUN pip install Django==$DJANGO_VERSION

COPY entrypoint /entrypoint
RUN chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
CMD ["runserver", "0.0.0.0:8000"]
