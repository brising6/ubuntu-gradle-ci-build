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
    && curl -SLO "https://nodejs.org/dist/v4.4.7/node-v4.4.7.tar.xz" \
    && tar -xJf "node-v4.4.7.tar.xz" -C /usr/local --strip-components=1 \
    && rm "node-v4.4.7.tar.xz" \
    && curl -SLO "https://registry.npmjs.org/npm/-/npm-2.15.1.tgz" \
    && tar -xJf "npm-2.15.1.tgz" -C /usr/local --strip-components=1 \
    && rm "npm-2.15.1.tgz" \
    && node -v \
    && npm -v \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/unlimited_jce_policy.zip "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" \
    && unzip -jo -d ${JAVA_HOME}/jre/lib/security /tmp/unlimited_jce_policy.zip \
    && cd /meta \
    && gradle build \
    && gradle test \
    && npm update \
    && npm install -g phantomjs \
    && npm install -g webpack \
    && npm install -g \
    && git config --global user.name CI-BuildBot \
    && git config --global user.email svc_payments_ci \
    && tar -xzf cf-cli*.tgz -C /usr/bin/
