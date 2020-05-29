module Rss::Operation
  class Contests < Trailblazer::Operation

    step :scrape_the_boardr

    def scrape_the_boardr(ctx, **)
      url = "https://theboardr.com/eventsindustry"
      doc = Nokogiri::HTML(open(url))
      doc.search('table > tr').each do |contest|
        image_content = contest.search('td').search('img')&.first&.to_h
        next if image_content.blank?
        title = image_content['title']
        src = image_content['src']
        date = contest.search('td').search('h4')&.first&.text&.to_date
        description = contest.search('td')[3].text
        location = contest.search('td').search('strong').text
        link = "https://theboardr.com" + contest.search('td').search('a')&.first&.to_h['href']
        unless Contest.where(description: description).exists?
          Contest.create(title: title, description: description, date: date, src: src, location: location, link: link)
        end
      end
    end
  end
end