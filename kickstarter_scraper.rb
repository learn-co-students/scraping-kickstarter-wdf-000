# require libraries/modules here
require 'nokogiri'
require 'pry'

  def create_project_hash
    #opening and turning file into html via Nokogiri
    html = File.read('fixtures/kickstarter.html')
    kickstarter = Nokogiri::HTML(html)

    #creating an empty hash called projects where info in html doc will live
    projects = {}

    #Iterate through the projects
    kickstarter.css("li.project.grid_4").each do |project|
      #grabbing title of each project
      title = project.css("h2.bbcard_name strong a").text
      #turning title to symbol
      #putting it into projects hash where title is key
      projects[title.to_sym] = {
        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
        :description => project.css("p.bbcard_blurb").text,
        :location => project.css("ul.project-meta li a span.location-name").text,
        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
      }
    end

    #Return the projects hash
    projects
  end

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta li a span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

