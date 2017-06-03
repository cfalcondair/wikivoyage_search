
printf 'Waiting for Elasticsearch to Start'
until $(curl --output /dev/null --silent --head localhost:9200); do
    printf '.'
    sleep 1
done
printf '\nIts up\n'

curl -XPUT 'localhost:9200/wikivoyage?pretty' -H 'Content-Type: application/json' -d @index.json
curl -XPUT 'localhost:9200/wikivoyage/_mapping/point_of_interest?pretty' -H 'Content-Type: application/json' -d @mapping.json

