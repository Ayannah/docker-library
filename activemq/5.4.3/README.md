# ActiveMQ 5.4.3 #

## Base Docker Image

* java:7

## How to use this image

### Starting an instance

    docker run --name activemq-instance -p 61616:61616 -p 8161:8161 -d ayannah/activemq

An example of running ActiveMQ with additional options:

    docker run --name activemq-instance -p 61616:61616 -p 8161:8161 -d ayannah/activemq activemq --help

On first startup, the container will check if `/var/lib/activemq` is empty, and
it will initialize the folder when necessary.

During startup, the container will update the owner of all files and folders in
`/var/lib/activemq` to the `activemq` user.

### Environment Variables

There are numerous variables you can set. You will need to check the ActiveMQ
documentation for details.

The most commonly set variable is `ACTIVEMQ_OPTS_MEMORY`, for configuring
the JVM's memory usage.

### Data volumes

This image declares the ACTIVEMQ_BASE folder (`/var/lib/activemq`) as a data
volume.
