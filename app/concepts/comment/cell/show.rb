module Comment::Cell
  class Show < Trailblazer::Cell

    def username
      link_to(user.username, user_site_path(user.user_site))
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