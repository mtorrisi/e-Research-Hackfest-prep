#!/bin/ruby
# Use Awesome Print for JSON output
require "awesome_print"
require "json"
# Use octokit for interacting with GitHub
require "octokit"

client = Octokit::Client.new(:login => 'brucellino', :access_token => ENV['github_token'])

github_org = "AAROC"
github_repo = "e-Research-Hackfest-Prep"

# Use the Github API naming schema for the variables
milestone_title = "Aspring to Addis"
project_name = "Hackfest Drills"
issue_labels = ["todo", "checking", "missing", "done"]


############# milestones ###############################
milestones = client.list_milestones("#{github_org}/#{github_repo}")
puts "There are #{milestones.count} milestones"

# print the milestone titles

milestones.each do |m|
  puts m["title"]
end

# find the milestone with the right title

milestone = milestones.select {|m| m["title"] == "Aspiring to Addis" } # something wierd about how we match the titles here


## /milestones #########################################
############# issues #################################


## /issues ###########################################
############## labels ################################


## /labels ###########################################


## Create the issues.
