# vim: noet sw=4 ts=4 :
#
# Usage:
#
# To build all docker images (including ee) call
#
# 	make CAMUNDA_USER=your_user CAMUNDA_PASSWORD=your_password
#
# Or set both variables as environment variable and use the -e flag of make
#
# 	export CAMUNDA_USER=your_user
# 	export CAMUNDA_PASSWORD=your_password
#
# 	make -e
#
#
# To only build the community images no password is needed just call
#
# 	make build
#
#
# To override the camunda version you can override the VERSION variable (do not add
# the -ee suffix)
#
# 	make build-ee VERSION=7.5.3 CAMUNDA_USER=your_user CAMUNDA_PASSWORD=your_password

### Camunda version ########################
VERSION = 7.6.0-alpha3

### Docker image and container names #######
IMAGE = registry.camunda.com/camunda-bpm-platform:wildfly-$(VERSION)
IMAGE_EE = registry.camunda.com/camunda-bpm-platform:wildfly-$(VERSION)-ee
CONTAINER = camunda-wildfly-$(VERSION)

### Camunda metadata ######################
GROUP = org.camunda.bpm.wildfly
ARTIFACT = camunda-bpm-wildfly10
ARTIFACT_EE = camunda-bpm-ee-wildfly10

### Maven settings and binary ##############
MVN_OPTS = -s ../settings.xml -Dmaven.repo.local=../.m2 -Dproject.basedir=target
ifeq ($(MAVEN_HOME),)
	MVN = /usr/bin/mvn $(MVN_OPTS)
else
	MVN = $(MAVEN_HOME)/bin/mvn $(MVN_OPTS)
endif


### Build all docker images ################
.PHONY: all
all: build build-ee


### Build docker image #####################

.PHONY: build
build: download
	docker build -t $(IMAGE) .

.PHONY: build-ee
build-ee: download-ee
	docker build -t $(IMAGE_EE) .


### Download Camunda distro ################

.PHONY: download
download:
	rm -rf camunda/ target/
	$(MVN) org.apache.maven.plugins:maven-dependency-plugin:2.8:unpack \
		-Dartifact=$(GROUP):$(ARTIFACT):$(VERSION):tar.gz \
		-DoutputDirectory=camunda/
	rm -rf target

.PHONY: download-ee
download-ee:
	rm -rf camunda/ target/
	$(MVN) org.apache.maven.plugins:maven-dependency-plugin:2.8:unpack \
		-P camunda-bpm-ee \
		-Dartifact=$(GROUP):$(ARTIFACT_EE):$(VERSION)-ee:tar.gz \
		-Dproject.basedir=target/ \
		-DoutputDirectory=camunda/
	rm -rf target


### Development ############################
.PHONY: pull
pull:
	-docker pull $(IMAGE)
	-docker pull $(IMAGE_EE)

.PHONY: push
push:
	docker push $(IMAGE)
	docker push $(IMAGE_EE)

.PHONY: run
run: rmf
	docker run -d --name $(CONTAINER) -P $(IMAGE)

.PHONY: run-ee
run-ee: rmf
	docker run -d --name $(CONTAINER) -P $(IMAGE_EE)

.PHONY: url
url:
	@echo "http://localhost:$(shell docker inspect --format='{{(index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort}}' $(CONTAINER))/camunda-welcome/"

.PHONY: clean
clean:
	rm -rf camunda/ target/

.PHONY: rmf
rmf:
	-docker rm -f -v $(CONTAINER)

.PHONY: rmi
rmi:
	-docker rmi $(IMAGE)
	-docker rmi $(IMAGE_EE)
