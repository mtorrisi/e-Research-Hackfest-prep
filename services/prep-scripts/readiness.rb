# Copyright 2016 Sci-GaIA consortium
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


#!/bin/ruby
# Use Awesome Print for JSON output
require "awesome_print"
require "json"
require  "date"
# Use octokit for interacting with GitHub
require "octokit"

# Use HTTParty to interact with other REST APIs
require "httparty"
# This is for discourse :
discourse_api_url = "http://discourse.sci-gaia.eu"
discourse_api_key = ENV["discourse_api_key"]
discourse_post_uri = discourse_api_url + "/posts"
discourse_options = { :api_key => discourse_api_key, :api_username => 'system', :category => "sandbox"}

post = JSON.parse(File.read("../static-files/post_templates/readiness_post.json"))
# Construct the title
post["title"] = "#{post["title"]}-"
# Get categories

categories = HTTParty.get("#{discourse_api_url}/categories.json")
sandbox_category = categories["category_list"]["categories"].select{ |c| c["slug"] == "sandbox"}
sandbox_category_id = sandbox_category[0]["id"]

# Get the list of topics in that category
topics = HTTParty.get("#{discourse_api_url}/c/#{sandbox_category_id}.json")
# is there a topic with this title ?
if topics["topic_list"]["topics"].any? { |t| t["title"] == "drills" }
  puts "topic is there, updating it"
else
  response = HTTParty.post(discourse_post_uri, body: post, query: options)
end

puts "opening issues on github for the milestone"

octobot = Octokit::Client.new(:login => 'brucellino', :access_token => ENV['github_token'])
github_headers = {"Authorization" => "token #{ENV["github_token"]}",  "User-Agent" => "drillbot", "Accept" => "application/vnd.github.inertia-preview+json"}
github_org = "AAROC"
github_repo = "e-Research-Hackfest-Prep"
# Use the Github API naming schema for the variables
milestone_title = "Aspring to Addis"
project_name = "Hackfest Drills 1"
project_body = "Project to simulate the hackfest"
issue_labels = ["todo", "checking", "missing", "done"]

############# milestones ###############################
milestones = octobot.list_milestones("#{github_org}/#{github_repo}")
puts "There are #{milestones.count} milestones"

# print the milestone titles

milestones.each do |m|
  puts m["title"]
end

# find the milestone with the right title

milestone = milestones.select {|m| m["title"] == "Aspiring to Addis" } # something wierd about how we match the titles here
ap milestone
milestone_number = milestone[0]['number']
puts milestone_number
## /milestones #########################################

#### projects #########################################
# Create the project.
# projects haven't been implemented in octokit yet, so we have to HTTParty

#  first, get the list of projects
projects_list =HTTParty.get("https://api.github.com/repos/#{github_org}/#{github_repo}/projects", :headers => github_headers)
ap projects_list.body
projects_list = JSON.parse(projects_list.body)
# Then check if the drill project has been created
if projects_list.any? { |project|  project["name"] == project_name}
  puts "project already created"
# if not, create the project.
  else
    project = HTTParty.post("https://api.github.com/repos/#{github_org}/#{github_repo}/projects", :body => {"name": project_name, "body": "First drill of the hackfest"}.to_json, :headers => {"Authorization": "token #{ENV["github_token"]}", "User-Agent": "drillbot", "Accept": "application/vnd.github.inertia-preview+json"} )
end
ap project
project_id = project.parsed_response["id"]

# Check columns
columns = HTTParty.get("https://api.github.com/projects/#{project_id}/columns", :headers => github_headers)
# add columns if they are not there
column_titles=["todo","in progress", "checked","done"]
#  add issues to the project

## /projects ###########################################

## /issues ###########################################
############## labels ################################


## /labels ###########################################


############# issues #################################
## Create the issues.

issue_list = JSON.parse(File.read('drill_issues.json'))
ap issue_list
puts "We have to create #{issue_list["issues"].count} issues to create"

issue_list["issues"].each do |issue|
  puts "creating issue #{issue["id"]}"
  puts issue["name"]
  issue_content = JSON.parse(File.read("../static-files/issue_templates/#{issue["template_file"]}"))
  ap issue_content
  issue_body = octobot.markdown('#{issue_content}')
  i = octobot.create_issue("#{github_org}/#{github_repo}",issue_content["title"],issue_content["body"],:milestone => milestone_number)

end

puts "creating the topic"

#ap response
