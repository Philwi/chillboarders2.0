class RssFeedsController < ApplicationController
  def index
    meta_tags(title: I18n.t('seo.controller.rss_feed.index.title'), description: I18n.t('seo.controller.rss_feed.index.description'), keywords: I18n.t('seo.controller.rss_feed.index.keywords'))
    @rss_feeds = RssFeed.all
    render html: cell(Rss::Cell::Index, @rss_feeds), layout: 'application'
  end
end