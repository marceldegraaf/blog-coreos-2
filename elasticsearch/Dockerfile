FROM stackbrew/ubuntu:saucy
MAINTAINER Marcel de Graaf <mail@marceldegraaf.net>

# Install Java
RUN apt-get install -y --force-yes openjdk-7-jre-headless wget

# Install Elasticsearch
RUN mkdir -p /opt/elasticsearch
RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.tar.gz -O /tmp/elasticsearch-1.0.1.tar.gz
RUN tar xfz /tmp/elasticsearch-1.0.1.tar.gz -C /opt/elasticsearch --strip-components=1

# Install plugins
RUN /opt/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf
RUN /opt/elasticsearch/bin/plugin -url http://download.elasticsearch.org/kibana/kibana/kibana-latest.zip -install elasticsearch/kibana3

# Expose port 9200
EXPOSE 9200

# Start Elasticsearch
CMD /opt/elasticsearch/bin/elasticsearch
