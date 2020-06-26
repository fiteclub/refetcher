require 'rubygems'
require 'open-uri'
require 'nokogiri'

# Fetches Real Estate information from public records

#url = 'http://lancasterpa.devnetwedge.com/parcel/view/0205241900000/2020'
#page = Nokogiri::HTML(open(url))
#page_xml = Nokogiri::XML(open(url))

page = Nokogiri::HTML(File.read("test/example.html"))
page_xml = Nokogiri::XML(File.read("test/example.xml"))

def title(page)
  puts page.at_css('title').text
  puts "---------------"
end

def header(page)
  puts "This is the header BEFORE the things that I want be having pleez"
  puts page.css("a#SalesHistory").to_html
  puts "--------------"
end

def allstuff(page)
  puts "This is ALL the stuff, not the specific stuff"
  page.css('.panel-info').each do |item|
    puts item.css('td').text
  end
  puts "--------------"
end

title(page)
header(page)
allstuff(page)

puts page.at_xpath('//div[preceding-sibling::a["SalesHIstory"]]')