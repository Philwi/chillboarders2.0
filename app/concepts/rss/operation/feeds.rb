class Rss::Operation::Feeds < Trailblazer::Operation
  step :get_feeds

  def get_feeds(_ctx, **)
    ::Rss::Util::Helper::RSS_FEED_URLS.each do |url|
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        image_url = feed&.image&.url
        begin
          feed.items.each do |item|
            rss_feed = RssFeed.new
            rss_feed.title = item.title
            rss_feed.link = item.link
            rss_feed.author = item.author
            rss_feed.category = item.category
            rss_feed.guid = item.guid
            rss_feed.pub_date = item.pubDate
            rss_feed.source = item.source
            rss_feed.description = item.description
            rss_feed.image_url = image_url
            next if RssFeed.find_by(description: item.description).present?
            rss_feed.save if RssFeed.find_by(title: item.title).blank?
          end
        end
      rescue StandardError => e
        puts e
        next
      end
    end
  end
end
