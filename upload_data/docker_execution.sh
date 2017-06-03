#!/usr/bin/bash

if ! [ -f bundled ]
then
  docker run --rm -v "$PWD/..":/usr/src/app -w /usr/src/app ruby:latest bundle install
  docker build -t ruby_uploader .
  touch bundled
fi

docker run -it -v "$PWD/..":/usr/src/app -w /usr/src/app ruby_uploader ruby upload_data/main.rb

