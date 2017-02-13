#!/bin/ruby
# A script to construct `participants.yml` from the people registered in the indico event.

# Author:: Bruce Becker (mailto:bbecker@csir.co.za)
# Copyright:: Copyright (c) 2016 C.S.I.R. Meraka Institute
# License:: Apache 2.0


# Get the CSV file from
# {{ site.data.hackfest.agenda }}/manage/registration/users/?disp=Email&disp=Institution&disp=1-0&disp=1-1&OK=apply&operationType=display&order=down&isBookmark=y&accommShowNoValue=--none--&sortBy=Name&accomm=cern&accomm=geneva-hotel&accomm=own-accommodation&sessionShowNoValue=--none--&statusesShowNoValue=--none--&eventShowNoValue=--none--
#  Be sure  to select following fields :
#   * name
#   * institute
#   *  orcid
#   * github
#   *  username
#   *  confirmed (starts with no)
#   * twitter
#   * homepage
#   * email

# Note : indico doesn't expose getting the participants via their API, so you need to authenticate via username/password
# you can't access this with HTTParty or similar.
# In the meantime, log into indico and dowload the file using a browser

require 'csv'
require 'json'
require 'awesome_print'
require 'yaml'
#  The encoding and headers are important to construct  the JSON later
participants = CSV.read('RegistrantsList-Addis.csv',encoding: "bom|utf-8", headers: :first_row).map { |x| x.to_h}
headers =  CSV.read('RegistrantsList-Addis.csv', encoding: "bom|utf-8", headers: :first_row).headers
ap headers

#  Convert the registrant info to the yml that you need to deploy dev-env
json_headers = ["Name","Institute","orcid","username","confirmed","twitter","homepage","email"]
addis = Array.new
ap addis

participants.each do |p|
  participant = {:name => p["Name"], :institute => p["Institution"], :orcid => p["ORCID ID (see http://orcid.org)"], :github => [{:username => p["GitHub account (see http://github.com)"], :confirmed => false}], :email => p["Email"]}
  addis.push(participant)
end

# print the yaml
ap JSON.parse(addis.to_json).to_yaml
File.open('/tmp/test.yml', 'w') {|f| f.write JSON.parse(addis.to_json).to_yaml } #Store
