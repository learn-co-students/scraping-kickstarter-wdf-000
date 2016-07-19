# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  raw_html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(raw_html)
  projects = {}

  kickstarter.css(".project").each do |project|
    name = project.css(".bbcard_name strong a").text
    image_link = project.css(".project-thumbnail img").attr('src')
    description = project.css(".bbcard_blurb").text
    location = project.css(".project_meta li a .location-name").text
    percent_funded = project.css(".project_stats .funded strong").text
    percent_funded = (percent_funded.scan(/[0-9]+/))[0].to_i

    projects[name] = {
      image_link: image_link,
      description: description,
      location: location,
      percent_funded: percent_funded
    }

    projects
    # binding.pry
  end

  projects
end

create_project_hash
# :projects => {
#   "My Great Project"  => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   },
#   "Another Great Project" => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   }
# }