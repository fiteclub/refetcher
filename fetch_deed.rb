require 'rubygems'
require 'watir'
require 'pry'

# TO DO : check if logged in


# execute this block if not logged in 
browser = Watir::Browser.start 'https://searchdocs.lancasterdeeds.com/countyweb/main.jsp?countyname=Lancaster'
sleep 1
binding.pry
browser.element(value: "Login as Guest").click
sleep 2
binding.pry
# javascript accept button
browser.iframe(name: "bodyframe").button(name: "accept").click
sleep 2
binding.pry
browser.screenshot.save 'screenshot.png'