FROM python:3.8-alpine

WORKDIR /usr/src/app

RUN echo "import this" > myscript.py

COPY . /usr/src/app

RUN python myscript.py
