#!/usr/bin/bash

if ! [ -f bundled ]
then
  docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:latest bundle install
  docker build -t ruby_query .
  touch bundled
fi

docker run -it -v "$PWD":/usr/src/app -w /usr/src/app ruby_query ruby main.rb "do Paris"

