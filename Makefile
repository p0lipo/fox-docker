.SILENT:

VERSION=$(shell cd FOX; git describe --always --dirty)
THIS_VERSION=$(shell git describe --always --dirty)

XMX=8G
LNG=de
CONTAINER_NAME=fox

default: help

## Build a fox docker container.
build:
	docker build -t fox:$(THIS_VERSION) .

## Tag the image according to the docker hub naming.
tag:
	docker tag fox:$(THIS_VERSION) fox:latest
	docker tag fox:$(THIS_VERSION) rpietzsch/fox:$(THIS_VERSION)
	docker tag fox:$(THIS_VERSION) rpietzsch/fox:latest

## Start a container from the image.
run:
	docker run -d --name=$(CONTAINER_NAME) -e XMX=$(XMX) -e LNG=$(LNG) -p 4444:4444 fox:$(THIS_VERSION)

## Push built container to public docker registry hub.docker.com .
push:
	docker push fox:$(THIS_VERSION)
	docker push fox:latest

## This help screen.
help:
	printf "Available targets\n\n"
	awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-15s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)