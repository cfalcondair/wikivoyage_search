FROM ruby:latest

RUN export LC_ALL=C.UTF-8
RUN export LANG=C.UTF-8
RUN export LANGUAGE=en_US.UTF-8

ADD Gemfile /
RUN bundle install
CMD while [ ! -f /tmp/downloaded_data ]; do sleep 2; done; ruby xml_parse/main.rb; touch /tmp/parsed_data;

