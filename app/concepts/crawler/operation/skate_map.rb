require "selenium-webdriver"
require 'open-uri'
module Crawler::Operation
  class SkateMap < Trailblazer::Operation

    step :crawl_spots

    def crawl_spots(ctx, **)
      link = 'https://skatemap.de/?id='
      browser = Watir::Browser.new(:chrome, headless: true)
      iterate_through_skatemap(1705, browser, link)
      browser&.close
    end

    def iterate_through_skatemap(start_id, browser, link)
      actual_id = start_id
      (start_id).upto(5000) do |index|
        begin
          actual_id = index
          link_tmp = link + index.to_s
          browser.goto link_tmp
          puts "Skatepark-ID: #{index}"
          if browser.div(:class => 'hinweis').exists?
            lat = browser.input(:name, 'lat').value
            lng = browser.input(:name, 'lng').value
            if lat.blank? || lng.blank?
              puts 'sleep'
              sleep(2.5)
              next
            end
            title = browser.title
            desc = browser.div(:class => 'text_desc').text
            category = browser.div(:class => 'text_kat').text
            Spot.create(title: title, description: desc, type: category,
                        lat: lat, lng: lng, user: User.first) unless Spot.where(title: title).exists?
            puts 'sleep'
            sleep(2.5)
          end
        rescue => e
          puts e
          sleep(2.5)
          puts 'restart crawler'
          browser&.close
          browser = Watir::Browser.new(:chrome, headless: true)
          iterate_through_skatemap(actual_id + 1, browser, link)
        end
      end
    end
  end
end