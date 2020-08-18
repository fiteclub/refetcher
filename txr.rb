#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'nokogiri'

# Fetch Real Estate information from public records
## Copies/uses/borrows/STEALS heavily from
## https://stackoverflow.com/questions/820066/nokogiri-select-content-between-element-a-and-b
# More specifically, fetch html between two <a> refs.
# The records site does not have usable parent nodes, so grab the html between two css tags.

# Legacy code that I'm keeping, because reasons?
# url = 'http://lancasterpa.devnetwedge.com/parcel/view/0205241900000/2020'
# page = Nokogiri::HTML(open(url))
# page = Nokogiri::HTML(File.open("/test/example.html"))
# page_xml = Nokogiri::XML(open(url))
# page_xml = Nokogiri::XML(File.read("/test/example.xml"))

# IDK why this actually works without passing it the page variable
# all credit to Magnus Holm
def slice_of_css(start, stop)
  start == stop ? [start] : [start, *slice_of_css(start.next, stop)]
end

def txr(tax_id, tax_year)
  url = "http://lancasterpa.devnetwedge.com/parcel/view/#{tax_id}/#{tax_year}"
  page = Nokogiri::XML(URI.open(url))
  puts 
  puts url

  # Uncomment this block for testing/development with a static page
  # target = File.open('example.html')
  # page = Nokogiri::XML(File.read(target))

  page_start = page.at_css("a#SalesHistory")
  page_stop = page.at_css("a#BillingCollection")

  # sale_history outputs an array of random and garbled html, so must be joined and cleaned
  sale_history = slice_of_css(page_start, page_stop).join().split("\n").map{ |ele| ele.strip }.reject{ |ele| ele.empty? }

  # Return the latest deed number
  # Refactor! This is very fragile!
  print "Last deed#: "
  puts sale_history[9]
  sale_history[9]
end
