#!/usr/bin/ruby

require 'elasticsearch'
require 'csv'

class Uploader
  FILE_NAME = 'data/dump.csv'

  def run
    @count = 0
    load_file do |poi|
      @count += 1
      puts @count if @count % 1000 == 0
      es_connection.index(
        index: 'wikivoyage',
        type: 'point_of_interest',
        body: poi
      )
    end
  end

  def es_connection
    @es_connection ||= Elasticsearch::Client.new(host: '172.17.0.1', port: '9200')
  end 

  def load_file
    CSV.foreach('data/dump.csv', { encoding: 'ISO-8859-1', col_sep:'|'}) do |line|
      name = line[0] || line[1]
      next if name.nil?
      
      poi = {
        name: name
      }
      poi['geography'] = if !line[2].nil?
        {
          lat: line[2],
          lon: line[3]
        }
      end
      poi['content'] = line[4]
      poi['page_title'] = line[5]
      poi['type'] = line[6]

      yield poi
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Uploader.new.run
end
