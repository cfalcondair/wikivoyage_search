class PointOfInterest
  attr_reader :data

  def initialize(data:, source_page:, type:)
    @type = type
    @data = data
    @parsed_data = parse_data(data)
    @source_page = source_page
  end

  def output
   [
     name,
     alt_name,
     lat,
     lon,
     content
   ]
  end

  def parse_data(data)
    data.delete!('}}')
    data.scan(/\[\[([^\]]*)\]\]/).each do |link|
      link = link.first
      no_delimiter_link = link.tr('|', ':')
      data.gsub!(link, no_delimiter_link)
    end
    split_data = data.split(/\|\s*/)

    # Ignore the '* {{'
    split_data = split_data[1..-1]

    split_data.each_with_object({}) do |str, h|
      next unless str.include?('=')

      split_index = str.index('=')
      key = str[0..split_index-1].strip
      value = str[split_index+1..-1].strip
      value = nil if value.empty?
      h[key] = value
    end
  end

  def name
    @parsed_data.fetch('name')
  end

  def alt_name
    @parsed_data['alt']

  end

  def lat
    lat = @parsed_data['lat']
    return if lat.nil?

    lat.to_f
  end

  def lon
    lon = @parsed_data['long']
    return if lon.nil?

    lon.to_f
  end

  def content
    @parsed_data['content']
  end

  def page_title
    @source_page.title.text
  end
end
