#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'nokogiri'

# Gets example data to experiment with

url = 'http://lancasterpa.devnetwedge.com/parcel/view/5708080100000/2020'
# url = 'http://lancasterpa.devnetwedge.com/parcel/view/5708080100000/2020'
page = Nokogiri::HTML(URI.open(url))
page_xml = Nokogiri::XML(URI.open(url))

File.open('example.xml', 'w') do |fo|
  fo.puts page_xml
end

File.open('example.html', 'w') do |fo|
  fo.puts page
end
