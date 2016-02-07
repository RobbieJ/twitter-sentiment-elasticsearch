# start with a base image
FROM ubuntu:15.10

MAINTAINER Real Python <info@realpython.com>

# initial update
RUN apt-get update -q

# install wget, java, and mini-httpd web server
RUN apt-get install -yq wget
RUN apt-get install -yq default-jre
RUN apt-get install -yq nginx


# install elasticsearch
RUN cd /tmp && \
    wget -nv https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-2.2.0.tar.gz && \
    tar zxf elasticsearch-2.2.0.tar.gz && \
    rm -f elasticsearch-2.2.0.tar.gz && \
    mv /tmp/elasticsearch-2.2.0 /elasticsearch

# install kibana
RUN cd /tmp && \
    wget -nv https://download.elastic.co/kibana/kibana/kibana-4.4.0-linux-x64.tar.gz && \
    tar zxf kibana-4.4.0-linux-x64.tar.gz && \
    rm -f kibana-4.4.0-linux-x64.tar.gz && \
    mv /tmp/kibana-4.4.0-linux-x64 /kibana

# create NGINX Config


# start elasticsearch
CMD /elasticsearch/bin/elasticsearch -Des.logger.level=OFF & mini-httpd -d /kibana -h `hostname` -r -D -p 8000

# expose ports
EXPOSE 8000 9200



