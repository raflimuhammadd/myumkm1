FROM python:3.11-slim

ENV PYTHONUNBUFFERED True

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY . ./

RUN mkdir model

RUN mkdir content

ADD https://storage.googleapis.com/myumkm_bucket/chatbot.h5 model/.

ADD https://storage.googleapis.com/myumkm_bucket/umkm.json content/.

RUN pip install -r requirements.txt

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
