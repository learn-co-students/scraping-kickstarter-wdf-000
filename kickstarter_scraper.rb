require 'nokogiri'
require 'pry'

#projects: kickstarter.css("li.project.grid_4")
#title: project.css("h2.bbcard_name strong a").text
#image: project.css("div.project-thumbnail a img").attribute("src").value
#desc: project.css("p.bbcard_blurb").text
#location: project.css("ul.project-meta li a").attribute("data-location").value.scan(/short_name.{3}(\w+\,\s\w+)/).first[0]
#location: project.css("ul.project-meta span.location-name").text
#%funded: project.css("ul.project-stats li.first.funded strong").text
def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  #binding.pry
  projects
end

#create_project_hash
