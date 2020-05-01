require "selenium-webdriver"
require 'open-uri'
module Crawler::Operation
  class SkateMap < Trailblazer::Operation

    step :crawl_spots

    def crawl_spots(ctx, **)
      link = 'https://skatemap.de/?id='
      4000.times.with_index do |index|
        browser = Watir::Browser.new(:chrome)
        link_tmp = link + index.to_s
        #browser.execute_script("$(document.elementFromPoint(2, 2)).trigger({type: 'mousedown', which: 3});")
        browser.goto link_tmp
        if browser.div(:class => 'text_desc').exists?
          lat = browser.input(:name, 'lat').value
          lng = browser.input(:name, 'lng').value
          return if lat.blank? || lng.blank?
          title = browser.title
          desc = browser.div(:class => 'text_desc').text
          category = browser.div(:class => 'text_kat').text
          Spot.create(title: title, description: desc, type: category,
                                lat: lat, lng: lng, user: User.first)
        end
        browser.close
      end
    end
  end
end