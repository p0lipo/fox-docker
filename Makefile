.SILENT:

VERSION=$(shell cd FOX; git describe --always --dirty)
THIS_VERSION=$(shell git describe --always --dirty)

default: help

## build a fox docker container
build:
	docker build -t fox:$(VERSION) .

tag:
	docker tag fox:testing rpietzsch/fox:$(THIS_VERSION)

## This help screen
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