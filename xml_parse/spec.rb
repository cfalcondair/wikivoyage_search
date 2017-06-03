#!/usr/bin/ruby
# encoding: utf-8

require 'csv'

count = 0
no_name_count = 0
CSV.foreach('data/dump.csv', { encoding: 'ISO-8859-1', col_sep:'|'}) do |line|
  lat = line[2].to_f
  lon = line[3].to_f
  name = line[0] || line[1]

  fail "The lon for #{line} is not valid" if !lon.nil? && lon.abs > 180
  fail "The lat for #{line} is not valid" if !lat.nil? && lat.abs > 90
  no_name_count += 1 if name.nil?
  count += 1
end

puts "Have #{no_name_count} points of interest with no name or alternate name."
puts "Total points of interest at #{count}"
