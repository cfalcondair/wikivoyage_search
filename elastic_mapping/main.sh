#!/usr/bin/ruby

echo "Upload mapping to elasticsearch"
echo 'Waiting for Elasticsearch to Start'
until $(curl --output /dev/null --silent --head $ELASTICSEARCH_IP:9200); do
    printf '.'
    sleep 1
done
echo '\nIts up\n'
 
curl -s -XPUT $ELASTICSEARCH_IP':9200/wikivoyage?pretty' -H 'Content-Type: application/json' -d @index.json
curl -s -XPUT $ELASTICSEARCH_IP':9200/wikivoyage/_mapping/point_of_interest?pretty' -H 'Content-Type: application/json' -d @mapping.json

