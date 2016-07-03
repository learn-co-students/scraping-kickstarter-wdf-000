# require libraries/modules here
require 'pry'
require 'nokogiri'
require 'open-uri'

=begin
:projects => {
  "My Great Project"  => {
    :image_link => "Image Link",
    :description => "Description",
    :location => "Location",
    :percent_funded => "Percent Funded"
  },
  "Another Great Project" => {
    :image_link => "Image Link",
    :description => "Description",
    :location => "Location",
    :percent_funded => "Percent Funded"
  }
}
=end

#for title
#kickstarter.css(".list-simple").css(".project").first.css("h2").text.strip.gsub(/\n+/," ")
#kickstarter.css("li.project.grid_4").first.css("h2.bbcard_name strong a").text
#for image link
#kickstarter.css("li.project").first.css("div.project-thumbnail img").attribute("src").value
#description
#kickstarter.css("li.project").first.css("p.bbcard_blurb").text
#location
#kickstarter.css("li.project").first.css("ul.project-meta").text.strip
#percent funded
#kickstarter.css("li.project").first.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
	projects = {}
	html = File.read('fixtures/kickstarter.html')
	kickstarter = Nokogiri::HTML(html)
	#binding.pry
	
	kickstarter.css("li.project").each do | x |
		projects[x.css("h2.bbcard_name strong a").text.to_sym] = {
			image_link: x.css("div.project-thumbnail img").attribute("src").value,
			description: x.css("p.bbcard_blurb").text,
			location: x.css("ul.project-meta").text.strip,
			percent_funded: x.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
		}
	end
	projects
end


