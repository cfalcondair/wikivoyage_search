#/usr/bin/bash

docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:latest bundle install
docker build -t ruby_parser .
docker run -it -v "$PWD/..":/usr/src/app -w /usr/src/app ruby_parser ruby xml_parse/main.rb

