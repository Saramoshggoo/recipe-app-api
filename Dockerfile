#dependency we need 
FROM python:3.7-alpine 
MAINTAINER SARA MOSHGGOO 
#tell python to run on unbuffed mood
ENV PYTHONUNBUFFERED 1
#create dependancy 
COPY ./requirements.txt /requirements.txt
RUN pip install -r/requirements.txt
#create directory
RUN mkdir /app
#defult directory
WORKDIR /app
COPY ./app /app
#create user 
RUN adduser -D user
USER user

# in terminal  put  docker build .