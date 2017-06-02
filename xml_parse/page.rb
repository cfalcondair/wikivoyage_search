#!/usr/bin/ruby

class Page < Struct.new(:data)
  def process
    return unless redirect?

  end

  def text_element
    @text_element ||= data.at_css('text')
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
    text_element.text.size < 100 &&
      !text_element.text.match(/#REDIRECT\s*[[[^\]]*]]/).nil?
  end
end
