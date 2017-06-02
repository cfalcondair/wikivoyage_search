#!/usr/bin/ruby
# encoding: utf-8

$LOAD_PATH.unshift(__dir__)
require 'page'
require 'nokogiri'

class Main
  def initialize
    @xml_file_path = 'data/page_articles.xml'  
  end

  def execute
    stream_xml.each do |node|
      if page_node?(node)
        xml = Nokogiri::XML(node.outer_xml)
        page = Page.new(xml)
        page.process
      end
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
  Main.new.execute
end

