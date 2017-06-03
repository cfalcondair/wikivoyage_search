#/usr/bin/bash
set -uxo pipefail

if ! [ -f bundled ]
then
  docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:latest bundle install
  docker build -t ruby_parser .
  touch bundled
fi  
docker run -it -v "$PWD/..":/usr/src/app -w /usr/src/app ruby_parser ruby xml_parse/main.rb


