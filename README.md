# Build and runtime container for FOX

- fox project: http://aksw.org/Projects/FOX.html
- fox githup repo: https://github.com/AKSW/fox
- prebuilt container: https://hub.docker.com/r/rpietzsch/fox-docker/

## make targets

    $ make
    Available targets

    build   Build a fox docker container.
    tag     Tags the image according to the docker hub naming.
    run     Starts a container from the image.
    push    Push built container to public docker registry hub.docker.com .
    help    This help screen.

## run a fox container

    docker run -d --name my_fox_container -p 4444:4444 rpietzsch/fox:latest

To configure fox at runtime use the following environment variables, set them `-e <Variable>=<Value>[-e ...[]]

- `XMX`: configures the jvm memory settings, default `8G`
- `LNG`: sets the language to be trained, currently `en` `de` are supported, default `de`

A sample of a fully run configuration looks like:

    docker run -d --name=my_fox_container -e XMX=7G -e LNG=en -p 8888:4444 rpietzsch/fox:latest
