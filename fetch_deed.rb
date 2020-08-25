require 'rubygems'
require 'watir'
require 'pry'

docid = "6268572"

# With visible browser (headed?)
browser = Watir::Browser.start 'https://searchdocs.lancasterdeeds.com/countyweb/main.jsp?countyname=Lancaster'

# Headless mode!
# browser = Watir::Browser.new :chrome, headless: true
# browser.goto 'https://searchdocs.lancasterdeeds.com/countyweb/main.jsp?countyname=Lancaster'

def humanize
  sleep rand(1.0..3.0)
end

def login(browser)
  
  humanize

  # dismiss logged out dialog if present 
  if
    browser.link(:text =>"Click here to logout").when_present.click
  else
  end

  humanize

  # click login as guest
  browser.element(value: "Login as Guest").click

  humanize

  # click javascript accept button
  browser.iframe(name: "bodyframe")
    .button(name: "accept")
    .click

  humanize

end

# Primary search form begins here

  # def initialize
    
  # end

  # Click "Search public records"
  def click_search(browser)
    browser.iframe(name: "bodyframe")
    .element(:xpath => "/html/body/form/div[3]/div/div/div[2]/div/div/div[1]/div[2]/div/div/div/div[2]/div[2]/table/tbody/tr[1]/td/div/i")
    .click
  end

  # Click "Instrument number"
  # browser.iframe(name: "bodyframe").iframe(name: "dynSearchFrame").element(:xpath => "/html/body/div[1]/div/div[3]/div[2]/div/div[1]/div/div/div/div/div[2]/div[2]/table/tbody/tr[4]/td/div/span").click
  def click_instnum(browser)
  browser.iframe(name: "bodyframe")
    .iframe(name: "dynSearchFrame")
    .element(:xpath => "/html/body/div[1]/div/div[3]/div[2]/div/div[1]/div/div/div/div/div[2]/div[2]/table/tbody/tr[4]/td/div/span")
    .click
  end

  # Clear text field
  # browser.iframe(name: "bodyframe").iframe(name: "dynSearchFrame").element(:xpath => "/html/body/div[1]/div/div[1]/div/div/span[2]/a[1]").fire_event :click
  def clear_instnum(browser)
  browser.iframe(name: "bodyframe")
    .iframe(name: "dynSearchFrame")
    .element(:xpath => "/html/body/div[1]/div/div[1]/div/div/span[2]/a[1]")
    .fire_event :click
  end


  # Fill doc number in text field -- fill with docid variable
  # browser.iframe(name: "bodyframe").iframe(name: "dynSearchFrame").iframe(name: "criteriaframe").text_field(:xpath => "/html/body/form[1]/div[1]/div/table/tbody/tr/td[2]/span/input[1]").set(docid)
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
  
  # Click the first document (row 1, column 2)
  def go_doc(browser)
    browser.iframe(name: "bodyframe")
      .iframe(name: "resultFrame")
      .iframe(name: "resultListFrame")
      .element(:xpath => "/html/body/form/div/div/div/div/div[2]/div[2]/table/tbody/tr/td[2]/div/span[1]/a")
      .click!
  end

  # Click the "save image" option in navbar
  def save_image(browser)
    browser.iframe(name: "bodyframe")
      .iframe(name: "resnavframe")
      .element(:xpath => "/html/body/div/table/tbody/tr[1]/td[2]/a")
      .click!
  end

  # Click download
  def download(browser)
    browser.iframe(name: "dialogframe")
      .element(:xpath => "/html/body/form/div[2]/table/tbody/tr/td[2]/input")
      .click!
  end

login(browser)
humanize
binding.pry

click_search(browser)
humanize
binding.pry

click_instnum(browser)
humanize
binding.pry

search_doc(browser, docid)
humanize
binding.pry

go_doc(browser)
humanize
binding.pry

save_image(browser)
humanize
binding.pry

download(browser)
humanize
binding.pry

puts "you are one step away from exiting."


# Not elegant, but it works -- would rather have this click "Search"


# This doesn't work, it incurrs the pop-up box indicating that the doc id field is empty, even though it was filled in the previous code
# Click "Search"
# This should be a method
# browser.iframe(name: "bodyframe")
#   .iframe(name: "dynSearchFrame")
#   .element(:xpath => "/html/body/div[1]/div/div[1]/div/div/span[2]/a[2]")
#   .fire_event :click
# sleep 1

# binding.pry

####  id="inst0"
# CAN'T DO A SCREENSHOT IF HEADLESS! 

##  browser.iframe(name: "bodyframe").iframe(name: "resultFrame").iframe(name: "resultListFrame").element(:xpath => "/html/body/form/div/div/div/div/div[2]/div[2]/table/tbody/tr/td[2]/div/span[1]/a").present?

browser.screenshot.save 'screenshot.png'
sleep 2

binding.pry