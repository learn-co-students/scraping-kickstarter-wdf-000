# require libraries/modules here
require 'nokogiri'
require 'json'

  # projects: kickstarter.css("div.project-card") flatiron had projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: JSON.parse(project.css('ul.project-meta a').attribute('data-location').value)['displayable_name'] or just project.css('span.location-name').text lol 
  # location: project.css("ul.project-meta span.location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  
  projects = {}

  kickstarter.css('div.project-card').each do |project|
    title = project.css('h2.bbcard_name strong a').text

    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => JSON.parse(project.css('ul.project-meta a').attribute('data-location').value)['displayable_name'],
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects
end

