#dependency we need 
FROM python:3.7-alpine 
MAINTAINER SARA MOSHGGOO 
#tell python to run on unbuffed mood
ENV PYTHONUNBUFFERED 1
#create dependancy 
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps
#create directory
RUN mkdir /app
#defult directory
WORKDIR /app
COPY ./app /app
#create user 
RUN adduser -D user
USER user


# in terminal  put  docker build .