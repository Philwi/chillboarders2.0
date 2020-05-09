require "selenium-webdriver"
require 'open-uri'
module Crawler::Operation
  class SkateMap < Trailblazer::Operation

    step :crawl_spots

    def crawl_spots(ctx, **)
      link = 'https://skatemap.de/?id='
      (1000).upto(4000) do |index|
        begin
          browser = Watir::Browser.new(:chrome)
          link_tmp = link + index.to_s
          #browser.execute_script("$(document.elementFromPoint(2, 2)).trigger({type: 'mousedown', which: 3});")
          browser.goto link_tmp
          if browser.div(:class => 'hinweis').exists?
            lat = browser.input(:name, 'lat').value
            lng = browser.input(:name, 'lng').value
            next if lat.blank? || lng.blank?
            title = browser.title
            desc = browser.div(:class => 'text_desc').text
            category = browser.div(:class => 'text_kat').text
            pp lat + lng + title + desc + category
            Spot.create(title: title, description: desc, type: category,
                        lat: lat, lng: lng, user: User.first)
          end
          browser.close
        rescue => e
          puts e
        end
      end
    end
  end
end