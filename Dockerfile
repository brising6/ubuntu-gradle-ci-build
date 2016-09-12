FROM java:8

ENV PORT=8080 \
    GRADLE_HOME=/usr/bin/gradle-2.14 \
    PATH=$PATH:/usr/bin/gradle-2.14/bin:/meta/.cli

EXPOSE 8080

ADD . /meta

WORKDIR /usr/bin

RUN wget -q https://services.gradle.org/distributions/gradle-2.14-bin.zip -O gradle.zip \
    && unzip -q gradle.zip \
    && rm gradle.zip \
    && wget https://nodejs.org/dist/v5.3.0/node-v5.3.0-linux-x64.tar.gz \
    && tar -xzf "node-v5.3.0-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v5.3.0-linux-x64.tar.gz" \
    && node -v \
    && npm -v \
    && npm install -g newman \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/unlimited_jce_policy.zip "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" \
    && unzip -jo -d ${JAVA_HOME}/jre/lib/security /tmp/unlimited_jce_policy.zip \
    && cd /meta \
    && gradle build \
    && gradle test \
    && git config --global user.name CI-BuildBot \
    && git config --global user.email svc_payments_ci \
    && tar -xzf cf-cli*.tgz -C /usr/bin/
