#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'nokogiri'

# Gets example data to experiment with

url = 'http://lancasterpa.devnetwedge.com/parcel/view/0205241900000/2020'
page = Nokogiri::HTML(open(url))
page_xml = Nokogiri::XML(open(url))

File.open('example.xml', 'w') do |fo|
    fo.puts page_xml
end

File.open('example.html', 'w') do |fo|
    fo.puts page
end