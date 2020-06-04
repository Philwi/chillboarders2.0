require "selenium-webdriver"
require 'open-uri'
module Crawler::Operation
  class SkateMap < Trailblazer::Operation

    step :crawl_spots
    fail :new_iteration

    # 1859
    def crawl_spots(ctx, skatemap_id:, **)
      link = 'https://skatemap.de/?id='
      browser = Watir::Browser.new(:chrome, headless: true)
      iterate_through_skatemap(skatemap_id, browser, link, ctx)
      browser&.close
    end

    def new_iteration(ctx, actual_id:, **)
      puts 'Restart Crawler!'
      Crawler::Operation::SkateMap.(params: {}, skatemap_id: actual_id + 1)
    end

    def iterate_through_skatemap(start_id, browser, link, ctx)
      actual_id = start_id
      (start_id).upto(5000) do |index|
        begin
          Timeout::timeout(5) {
            actual_id = index
            link_tmp = link + index.to_s
            browser.goto link_tmp
            puts "Skatepark-ID: #{index}"
            if browser.div(:class => 'hinweis').exists?
              lat = browser.input(:name, 'lat').value
              lng = browser.input(:name, 'lng').value
              if lat.blank? || lng.blank?
                puts 'next spot'
                next
              end
              title = browser.title
              desc = browser.div(:class => 'text_desc').text
              category = browser.div(:class => 'text_kat').text
              Spot.create(title: title, description: desc, type: category,
                          lat: lat, lng: lng, user: User.first) unless Spot.where(title: title).exists?
              puts 'saved spot! go to next spot.'
              sleep(1.5)
            end
          }
        rescue => e
          puts e
          sleep(1.5)
          puts 'Exception caught!'
          browser&.close
          ctx[:actual_id] = actual_id
          return Trailblazer::Activity::Left
        end
      end
    end
  end
end