module Comment::Cell
  class Show < Trailblazer::Cell

    def username
      user.username
    end

    def description
      model.description
    end

    def created_at
      I18n.l(model.created_at)
    end

    def user
      @user ||= model.user
    end

  end
end