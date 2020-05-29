module Rss::Cell
  class Index < Trailblazer::Cell

    def thrasher
      @thrasher ||= model.where("link LIKE ? AND description LIKE ?", "%thrashermagazine%", "%img src=%").order(created_at: :desc)
    end

    def upcoming_contests
      @contests ||= Contest.where("date > '#{Date.today}'").order(date: :asc)
    end
  end
end