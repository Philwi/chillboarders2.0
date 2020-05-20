module Rss::Cell
  class Index < Trailblazer::Cell

    def thrasher
      @thrasher ||= model.where("link LIKE ? AND description LIKE ?", "%thrashermagazine%", "%img src=%").order(created_at: :desc)
    end
  end
end