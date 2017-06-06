#!/usr/bin/env ruby

$LOAD_PATH.unshift(__dir__)
require 'page'
require 'nokogiri'

$stdout.sync = true

class Main
  def initialize
    @xml_file_path = 'data/page_articles.xml'
    @count = 0
  end

  def run
    puts "Parsing data"
    stream_xml.each do |node|
      if page_node?(node)
        xml = Nokogiri::XML(node.outer_xml)
        page = Page.new(xml)
        page.process if page.relevant?

        @count += 1
        puts @count if @count % 1000 == 0
      end
    end
    print_dump_descriptor

    puts "done"
  end

  def print_dump_descriptor
    File.open('data/dump_desription', 'w+') do |f|
      f << 'name|alt_name|lat|long|content|page_title|type'
    end
  end

  def page_node?(node)
    node.name == 'page' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
  end

  def stream_xml
    Nokogiri::XML::Reader(File.open(@xml_file_path))
  end
end

if __FILE__ == $PROGRAM_NAME
  Main.new.run
end
