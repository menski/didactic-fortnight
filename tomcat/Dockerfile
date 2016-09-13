FROM alpine:3.4

EXPOSE 8080

WORKDIR /camunda

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/camunda/bin/catalina.sh", "run"]

ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"

RUN apk --no-cache add openjdk8-jre-base openssl tini

COPY camunda/server/apache-tomcat-8.0.24/ /camunda/
