require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'mechanize'

# Fetches Real Estate deed from public records

agent = Mechanize.new
agent.get("https://searchdocs.lancasterdeeds.com/countyweb/login.do?countyname=Lancaster")
form = agent.page.forms[1]
form.guest = true
form.public = true
form.scriptsupport = "yes"
