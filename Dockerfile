FROM phusion/baseimage:latest
MAINTAINER newjanson

WORKDIR /usr/src/app

RUN apt-get update
RUN apt-get install -y chromium-chromedriver python python-pip git build-essential libssl-dev libffi-dev python-dev tar wget 
RUN pip install --upgrade pip
COPY . /usr/src/app/

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && tar xvfj phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin \
    && rm -rf phantomjs-2.1.1-linux-x86_64*

RUN for r in `cat requirements.txt`; do pip install $r; done
RUN pip install .

ENV PATH=$PATH:/usr/lib/chromium-browser/

ENTRYPOINT ["pikaptcha"]
