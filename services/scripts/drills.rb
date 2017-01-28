#!/bin/ruby
# Use Awesome Print for JSON output
require "awesome_print"
require "json"
require "httparty"

# TODO - flesh out the GitHub class with the github api info
class GitHub
  include HTTParty
  format :json
  def initialize
    @api_url = "https://api.github.com"
  end
end

api_url = "https://api.github.com"
token = ENV['github_token']
# We can store config in a yaml file
# config = YAML.load(File.read(File.join(ENV['HOME'], '.twitter')))

puts "github token is #{token}"
headers = "Authorization: token #{token}"

github_org = "/AAROC"
github_repo = "/e-Research-Hackfest-Prep"

# Use the Github API naming schema for the variables
milestone_title = "Aspring to Addis"
project_name = "Hackfest Drills"


base_uri = api_url + "/repos" + github_org + github_repo
milestones = HTTParty.get(base_uri + "/milestones", :format => :json)
# Use ap to debug json
# ap milestones

# Convert the JSON to a hash
parsed_milestones = JSON.parse(milestones.body)
puts "There are #{parsed_milestones.count} milestones"
# check if there is
if parsed_milestones.any? { |ms| ms["title"] == milestone_title }
  puts "Milestone is present"
else
  puts "couldn't find the milestone"
end


# We use GitHub projects to create the board for the drill. The drill is in fact a project.
# First, see if the project is  there

projects = HTTParty.get(base_uri + "/projects", :headers => {"Authorization" => "token #{token}", "Accept" => "application/vnd.github.inertia-preview+json", "User-Agent" => "drillbot"})

parsed_projects = JSON.parse(projects.body)
puts  "there are #{parsed_projects.count} projects"

if parsed_projects.any? { |p| p["name"] == project_name }
  puts "project is present"
else
  puts "Couldn't find the project"
end
puts "heres you're project !"
project = parsed_projects.select { |p| p["name"] == project_name }

ap project

# Get the list of issues in the project
puts "getting issues"
issues = HTTParty.get(base_uri + "/issues?milestone='#{milestone_title}'", :headers => {"User-Agent" => "drillbot"})
ap issues
