module Comment::Cell
  class Show < Trailblazer::Cell

    def username
      model.user.username
    end

    def description
      model.description
    end

    def created_at
      I18n.l(model.created_at)
    end

  end
end