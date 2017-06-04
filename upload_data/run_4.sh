#!/usr/bin/bash

docker run --rm -v "$PWD/..":/usr/src/app -w /usr/src/app ruby:latest bundle install
docker build -t ruby_uploader .

docker run -it -v "$PWD/..":/usr/src/app -w /usr/src/app ruby_uploader ruby upload_data/main.rb

