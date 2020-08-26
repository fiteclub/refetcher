require 'rubygems'
require 'watir'
require 'pry'
require_relative './utils.rb'

include Utils

def login(browser)
  human_call("login_check", browser)
  human_call("click_login_as_guest", browser)
  human_call("click_login_accept", browser)
end

def login_check(browser)
  if
    browser.link(:text =>"Click here to logout").when_present.click
  else
  end
end

def click_login_as_guest(browser)
  browser.element(value: "Login as Guest").click
end

def click_login_accept(browser)
  browser.iframe(name: "bodyframe")
    .button(name: "accept")
    .click
end

def click_search(browser)
  browser.iframe(name: "bodyframe")
  .element(:xpath => "/html/body/form/div[3]/div/div/div[2]/div/div/div[1]/div[2]/div/div/div/div[2]/div[2]/table/tbody/tr[1]/td/div/i")
  .click
end

def click_instnum(browser)
browser.iframe(name: "bodyframe")
  .iframe(name: "dynSearchFrame")
  .element(:xpath => "/html/body/div[1]/div/div[3]/div[2]/div/div[1]/div/div/div/div/div[2]/div[2]/table/tbody/tr[4]/td/div/span")
  .click
end

def clear_instnum(browser)
browser.iframe(name: "bodyframe")
  .iframe(name: "dynSearchFrame")
  .element(:xpath => "/html/body/div[1]/div/div[1]/div/div/span[2]/a[1]")
  .fire_event :click
end

def search_doc(browser, docid)
  browser
    .iframe(name: "bodyframe")
    .iframe(name: "dynSearchFrame")
    .iframe(name: "criteriaframe")
    .text_field(:xpath => "/html/body/form[1]/div[1]/div/table/tbody/tr/td[2]/span/input[1]")
    .set(docid)
  sleep 1
  browser.send_keys :enter
end

def go_doc(browser)
  browser.iframe(name: "bodyframe")
    .iframe(name: "resultFrame")
    .iframe(name: "resultListFrame")
    .element(:xpath => "/html/body/form/div/div/div/div/div[2]/div[2]/table/tbody/tr/td[2]/div/span[1]/a")
    .click!
end

def save_image(browser)
  browser.iframe(name: "bodyframe")
    .iframe(name: "resnavframe")
    .element(:xpath => "/html/body/div/table/tbody/tr[1]/td[2]/a")
    .click!
end


def download(browser)
  browser.iframe(name: "dialogframe")
    .element(:xpath => "/html/body/form/div[2]/table/tbody/tr/td[2]/input")
    .click!
end

# This is where the magic happens
def magic
  docid = "6268572"
  browser = Watir::Browser.start 'https://searchdocs.lancasterdeeds.com/countyweb/main.jsp?countyname=Lancaster'
  # browser = Watir::Browser.new :chrome, headless: true
  # browser.goto 'https://searchdocs.lancasterdeeds.com/countyweb/main.jsp?countyname=Lancaster'
  
  login(browser)
  human_call("click_search", browser)
  human_call("click_instnum", browser)
  human_call("search_doc", browser, docid)
  human_call("go_doc", browser)
  human_call("save_image", browser)
  human_call("download", browser)
end

magic

# puts "you are one step away from exiting."
# CAN'T DO A SCREENSHOT IF HEADLESS! 
# browser.screenshot.save 'screenshot.png'
