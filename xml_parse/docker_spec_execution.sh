#!/usr/bin/sh

docker run -it -v "$PWD/..":/usr/src/app -w /usr/src/app ruby_parser:latest ruby xml_parse/spec.rb
