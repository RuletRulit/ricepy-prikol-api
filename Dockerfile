FROM python:3.9-alpine3.13
LABEL maintainer="ruletrulit"

ENV PYTHONUNBUFFERED 1

COPY ./requirenments.txt /tmp/requirenments.txt
COPY ./requirenments.dev.txt /tmp/requirenments.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirenments.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirenments.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disable-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user