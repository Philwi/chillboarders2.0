class RssFeedsController < ApplicationController
  def index
    @rss_feeds = RssFeed.all
    render html: cell(Rss::Cell::Index, @rss_feeds), layout: 'application'
  end
end