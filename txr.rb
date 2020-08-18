#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'nokogiri'

#testing
require 'pry'
require 'jazz_fingers'

# Fetch Real Estate information from public records
## Copies/uses/borrows heavily from 
## https://stackoverflow.com/questions/820066/nokogiri-select-content-between-element-a-and-b
# More specifically, fetch html between two <a> refs, 
# because the records site does not have convenient parent nodes

# Legacy code that I'm keeping, because reasons
# url = 'http://lancasterpa.devnetwedge.com/parcel/view/0205241900000/2020'
# page = Nokogiri::HTML(open(url))
# page = Nokogiri::HTML(File.open("/test/example.html"))
# page_xml = Nokogiri::XML(open(url))
# page_xml = Nokogiri::XML(File.read("/test/example.xml"))

# to do : pass this from global variable
# hard coded for now
tax_id = "0205241900000"
tax_year = "2020"

# not used right now -- this is the address to scrape/parse later
url = "http://lancasterpa.devnetwedge.com/parcel/view/#{tax_id}/#{tax_year}"

target = File.open('example.html')
page = Nokogiri::XML(File.read(target))
get_start = page.at_css("a#SalesHistory")
get_stop = page.at_css("a#BillingCollection")

page_simple = Nokogiri::HTML(File.read(target))
get_start_simple = page.at_css("a#SalesHistory").to_html
get_stop_simple = page.at_css("a#BillingCollection").to_html

# IDK why this actually works without passing it the page variable
def get_portion(start, stop)
  start == stop ? [start] : [start, *get_portion(start.next, stop)]
end

# different technique to get the section of html we need
#sale_history (NO S!) outputs an array, so must be joined to parse or something idk it just works this way
sale_history = get_portion(get_start, get_stop)
puts sale_history
print sale_history.join().split("\n").map{|ele| ele.strip}



