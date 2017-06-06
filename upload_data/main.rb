#!/usr/bin/ruby

require 'elasticsearch'
require 'csv'

$stdout.sync = true

class Main
  FILE_NAME = '/tmp/dump.csv'

  def run
    puts "Uploading data"
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
    puts "Done"
  end

  def es_connection
    @es_connection ||= Elasticsearch::Client.new(host: ENV['ELASTICSEARCH_IP'], port: '9200')
  end

  def load_file
    CSV.foreach(FILE_NAME, { encoding: 'UTF-8', col_sep:'|'}) do |line|
      name = line[0] || line[1]
      next if name.nil?

      poi = {
        'name' => name
      }
      poi['geography'] = if !line[2].nil?
        {
          lat: line[2],
          lon: line[3]
        }
      end
      next if line[2].nil? != line[3].nil?

      poi['content'] = line[4]
      poi['page_title'] = line[5]
      poi['type'] = line[6]
      poi['name_page_title'] = "#{poi['name']} #{poi['page_title']}"

      yield poi
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Main.new.run
end
