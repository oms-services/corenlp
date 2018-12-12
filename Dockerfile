FROM java:jre-alpine

RUN apk add --update --no-cache \
	 unzip \
	 wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2015-12-09.zip
RUN unzip stanford-corenlp-full-2015-12-09.zip && \
	rm stanford-corenlp-full-2015-12-09.zip

WORKDIR stanford-corenlp-full-2015-12-09

RUN export CLASSPATH="`find . -name '*.jar'`"

ENV PORT 9000
ENV PORT1 8080

EXPOSE $PORT
EXPOSE $PORT1

CMD java -cp "*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer

FROM        python:3.7-alpine
RUN         sudo apt install python3.7-dev
run         python3.7 -m pip install psutil
RUN         mkdir /app
ADD         requirements.txt /app
RUN         pip install -r /app/requirements.txt
ADD         app.py /app

ENTRYPOINT  ["python", "/app/app.py"]
