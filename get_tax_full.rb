require 'rubygems'
require 'mechanize'
require 'awesome_print'
require 'pry'
require 'json'

agent = Mechanize.new
puts "Agent Initialized"
page = agent.get('http://lancasterpa.devnetwedge.com/parcel/view/0205241900000/2020')
puts "Agent sucesffully infiltrated parcel. Returned the goods as follows:\n"
tax_record = { property_information: { township: { code: '', name: '' } } }

tax_record[:property_information][:property_id] = page.search(%q|//*[@id="overview-body"]/div/div[1]/div[1]/div[2]|).children.to_s
township = page.search(%q|//*[@id="overview-body"]/div/div[1]/div[3]/div[2]|).children.to_s #020 Akron Boro
puts "Township: #{township}"
tax_record[:property_information][:township][:code] = township[0, 2]
tax_record[:property_information][:township][:name] = township[4..-1]
binding.pry

ap tax_record

# parcel_schema = {
#   property_information: {
#     property_id: "020-52419-0-0000",
#     tax_year: 2012,
#     township: {
#       code: "020",
#       name: "Akron Boro",
#     },
#     site_address: "123 Walnut St",
#     property_use: {
#      code: "100",
#      name: "RESIDENTIAL"
#     },
#     land_use: {
#       code: "113",
#       name: "SINGLE FAMILY DWELLING"
#     },
#     tax_status: true,
#     clean_and_green: false
#   }
# }