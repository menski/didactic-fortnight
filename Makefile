SERVERS = tomcat jboss wildfly

.PHONY: all
all:
	$(foreach server,$(SERVERS),make -C $(server) all;)

.PHONY: build-ee
build-ee:
	$(foreach server,$(SERVERS),make -C $(server) build-ee;)

.PHONY: push
push:
	$(foreach server,$(SERVERS),make -C $(server) push;)

.PHONY: clean
clean:
	$(foreach server,$(SERVERS),make -C $(server) clean;)
	rm -fr .m2

.PHONY: rmf
rmf:
	$(foreach server,$(SERVERS),make -C $(server) rmf;)
