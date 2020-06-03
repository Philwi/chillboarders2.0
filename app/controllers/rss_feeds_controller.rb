class RssFeedsController < ApplicationController
  def index
    meta_tags(title: 'Chillboarders - News from the skateboarding world', description: 'News from the Skateboarding world and contests around the globe', keywords: 'Skateboard, News, Thrasher, Contests, Skateboardcontests')
    @rss_feeds = RssFeed.all
    render html: cell(Rss::Cell::Index, @rss_feeds), layout: 'application'
  end
end