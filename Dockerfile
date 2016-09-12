FROM java:8

ENV PORT=8080 \
    GRADLE_HOME=/usr/bin/gradle-2.14 \
    PATH=$PATH:/usr/bin/gradle-2.14/bin:/meta/.cli

EXPOSE 8080

ADD . /meta

WORKDIR /usr/bin

RUN x	