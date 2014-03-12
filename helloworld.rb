# This simple Ruby script demonstrates 
# making a simple rest call to
# XigniteGlobalCurrencies -> ListCurrencies. 
# It receives JSON data from the service.
# It parses and displays the data to the console
#

require 'net/http'

#gem install json
require 'rubygems'
require 'json'

require 'yaml'

CONFIG = YAML.load_file("config.yml") unless defined? CONFIG

token = CONFIG['apitoken']
base_url = "http://globalcurrencies.xignite.com/"
action = "xGlobalCurrencies.json/ListCurrencies?_token="
url = base_url + action + token

begin
	response = Net::HTTP.get_response(URI.parse(url))
	data = response.body
	dataObj = JSON.parse(data)

	dataObj['CurrencyList'].each do |country|
		print "\nNext: \n"
		print country['Name'] + "\n"
		print country['Symbol'] + "\n"
	end

rescue
	print "Connection error"
end