require 'rubygems'
require 'watir'
require 'pry'
require_relative './utils.rb'

include Utils

class DeedSearchLanc
  attr_accessor :docid

  def initialize(docid)
    @@docid = docid
    @@prefs = {
      download: {
        prompt_for_download: false,
        default_directory: "#{Dir.pwd}/temp"
      },
      headless: true
    }
    @@browser = Watir::Browser.new :chrome, 
      download: {
        prompt_for_download: false, 
        default_directory: "#{Dir.pwd}/temp"
      }, 
      headless: true
  end

  def login
    human_call("login_check", @@browser)
    human_call("login_click_guest", @@browser)
    human_call("login_click_accept", @@browser)
  end

  def start_page(browser)
    browser.goto 'https://searchdocs.lancasterdeeds.com/countyweb/main.jsp?countyname=Lancaster'
  end

  def login_check(browser)
    if
      browser.link(:text =>"Click here to logout").when_present.click
    else
    end
  end

  def login_click_guest(browser)
    browser.element(value: "Login as Guest").click
  end

  def login_click_accept(browser)
    browser.iframe(name: "bodyframe")
      .button(name: "accept")
      .click
  end

  def navi_click_search(browser)
    browser.iframe(name: "bodyframe")
      .element(:xpath => "/html/body/form/div[3]/div/div/div[2]/div/div/div[1]/div[2]/div/div/div/div[2]/div[2]/table/tbody/tr[1]/td/div/i")
      .click
  end

  def navi_click_instrument(browser)
    browser.iframe(name: "bodyframe")
      .iframe(name: "dynSearchFrame")
      .element(:xpath => "/html/body/div[1]/div/div[3]/div[2]/div/div[1]/div/div/div/div/div[2]/div[2]/table/tbody/tr[4]/td/div/span")
      .click
  end

  def form_clear_instrument(browser)
    browser.iframe(name: "bodyframe")
      .iframe(name: "dynSearchFrame")
      .element(:xpath => "/html/body/div[1]/div/div[1]/div/div/span[2]/a[1]")
      .fire_event :click
  end

  def form_fill_search(browser, docid)
    browser
      .iframe(name: "bodyframe")
      .iframe(name: "dynSearchFrame")
      .iframe(name: "criteriaframe")
      .text_field(:xpath => "/html/body/form[1]/div[1]/div/table/tbody/tr/td[2]/span/input[1]")
      .set(docid)
    sleep 1
    browser.send_keys :enter
  end

  def result_select(browser)
    browser.iframe(name: "bodyframe")
      .iframe(name: "resultFrame")
      .iframe(name: "resultListFrame")
      .element(:xpath => "/html/body/form/div/div/div/div/div[2]/div[2]/table/tbody/tr/td[2]/div/span[1]/a")
      .click!
end

# http://watir.com/guides/downloads/
  def result_download(browser, docid)
    url = "https://searchdocs.lancasterdeeds.com/countyweb/download/downloadImages.do?cmd=download&isPreview=false&instrID=#{docid}&pdfformat=true"
    browser.goto(url)
  end

# This is where the magic happens
  def get(docid)
    @@docid = docid  
    human_call("start_page", @@browser)
    human_call("login_check", @@browser)
    human_call("login_click_guest", @@browser)
    human_call("login_click_accept", @@browser)
    human_call("navi_click_search", @@browser)
    human_call("navi_click_instrument", @@browser)
    human_call("form_fill_search", @@browser, @@docid)
    human_call("result_select", @@browser)
    human_call("result_download", @@browser, @@docid)
    sleep 3
  end

end

doc = "6176385"
test = DeedSearchLanc.new(doc)
test.get(doc)
