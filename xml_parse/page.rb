#!/usr/bin/ruby

require 'csv'

$LOAD_PATH.unshift(__dir__)
require 'point_of_interest'

class Page < Struct.new(:data)
  DUMP_FILE_NAME = 'data/dump.csv'

  def process
    poi_array.each do |poi|
      dump(poi)
    end
  end

  def dump(poi)
    CSV.open(DUMP_FILE_NAME, 'a+', { col_sep:'|'}) do |csv|

      csv << poi.output
    end
  end

  def internal_page?
    !title.text.match(/Wikivoyage:/).nil?
  end

  def relevant?
    contains_see? ||
      contains_do?
  end
  
  def contains_see?
    text.text.include?('see')
  end

  def contains_do?
    text.text.include?('do')
  end

  def poi_array
    see_array + do_array
  end

  def see_array
    text.text.scan(/\*\s\{\{see[^\}]*\n\}\}/).collect do |str|
      PointOfInterest.new(data: str, source_page: self, type: 'see')
    end
  end

  def do_array
    text.text.scan(/\*\s\{\{do[^\}]*\n\}\}/).collect do |str|
      PointOfInterest.new(data: str, source_page: self, type: 'do')
    end
  end
  
  def text
    @text ||= data.at_css('text')
  end

  def title
    @title ||= data.at_css('title')
  end

  def minimal_text?
    data.text.size < 400 
  end

  def long_comment?
    !comment.nil? && 
      comment.text.size > 200
  end

  def comment
    @comment ||= data.at_css('comment')
  end

  def inspect_data
    puts "*"*100
    puts data
  end

  def redirect?
    text.text.size < 200 &&
      !text.text.match(/#REDIRECT\s*[[[^\]]*]]/).nil?
  end
end
