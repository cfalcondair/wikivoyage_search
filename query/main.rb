#!/usr/bin/ruby
# encoding: utf-8

require 'elasticsearch'

class Query
  def run(query_string)
    puts "Querying cluster with:\n#{query_string}\n\n"
    puts "Waiting for response"
    result = es_connection.search(
      body: query_object(query_string)
    )
    puts query_object(query_string).inspect
    print_result(result)
  end

  def print_result(result)
    result["hits"]["hits"].reverse.each do |hit|
      source = hit['_source']
      puts "Score: #{hit['_score']}"
      puts "Place: #{source['name']}"
      puts "Page: #{source['page_title']}"
      puts "#{source['type'].capitalize}: #{source['content']}"
      puts
    end
  end

  def query_object(query_string)
    {
      query: {
        bool: {
          should: [
            {
              multi_match: {
                fields: [
                  "name^2",
                  "page_title",
                  "content.english"
                ],
                type: "cross_fields",
                query: query_string,
                analyzer: "english",
                tie_breaker: 0.5
              }
            },
            {
              match: {
                type: query_string
              }
            }
          ],
          filter: {
            bool: {
              should: [
                {
                  bool: {
                    must: [
                      {
                        query_string: {
                          default_field: "type",
                          query: query_string
                        }
                      },
                      {
                        query_string: {
                          default_field: "name_page_title",
                          query: query_string,
                          analyzer: "english",
                          minimum_should_match: "1"
                        }
                      }
                    ]
                  }
                },
                {
                  bool: {
                    should: [
                      {
                        query_string: {
                          default_field: "name_page_title",
                          query: query_string,
                          minimum_should_match: "2<75%"
                        }
                      },
                      {
                        query_string: {
                          default_field: "name_page_title.english",
                          query: query_string,
                          analyzer: "english",
                          minimum_should_match: "2<75%"
                        }
                      }
                    ]
                  }
                }
              ]
            }
          }

      }
    }                                                                                                                                                                                                                                                                                                                                                                                                              }
  end

  def es_connection
    Elasticsearch::Client.new(host: '10.0.2.15', port: 9200)
  end
end

str = ARGV[0]
Query.new.run(str)
