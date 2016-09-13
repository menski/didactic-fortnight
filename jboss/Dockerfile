FROM alpine:3.4

EXPOSE 8080

WORKDIR /camunda

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/camunda/bin/standalone.sh"]

# jboss settings
ENV PREPEND_JAVA_OPTS="-Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0" \
    LAUNCH_JBOSS_IN_BACKGROUND=TRUE

RUN apk --no-cache add openjdk7-jre-base openssl tini

COPY camunda/server/jboss-as-7.2.0.Final/ /camunda/
