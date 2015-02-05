# Jetty 9.2.7.v20150116 #

## Base Docker Image

* java:7

## How to use this image

### Starting an instance

    docker run --name jetty-instance -p 0.0.0.0:8080:8080 -d ayannah/jetty

An example of running Jetty with additional options:

    docker run --name jetty-instance -p 0.0.0.0:8080:8080 -d ayannah/jetty jetty --help

On first startup, the container will check if `/var/lib/jetty` is empty, and it
will initialize the folder when necessary.

By default, these are the modules enabled:

* http
* deploy
* jsp
* jstl
* annotations
* logging

During startup, the container will update the owner of all files and folders in
`/var/lib/jetty` to the `jetty` user.

### Environment Variables

`JETTY_OPTS`

Used to pass additional JVM options. By default, Jetty will use the JVM
defaults.

### Data volumes

This image declares the JETTY_BASE folder (/var/lib/jetty) as a data volume.

### Deploying a WAR file

To copy a WAR file from your current directory to a running container, you may
opt to do the following:

    docker run \
        -it \
        --rm \
        --volumes-from jetty-instance \
        -v $(pwd):/mnt \
        ayannah/jetty \
        sh -c 'cp /mnt/*.war /var/lib/jetty/webapps'

If your container is running, you will need to restart it to update the
permissions of the WAR file.
