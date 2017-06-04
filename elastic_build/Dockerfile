FROM docker.elastic.co/elasticsearch/elasticsearch:5.4.1

ADD elasticsearch.yml /usr/share/elasticsearch/config/
USER root
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml
USER elasticsearch
RUN bin/elasticsearch-plugin install analysis-icu

EXPOSE 9200
EXPOSE 9300
