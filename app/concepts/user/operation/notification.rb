module User::Operation
  class Notification < Trailblazer::Operation
    step :find_users_with_incomplete_profile
    step :find_users_with_incomplete_user_site
    step :create_notifications_for_already_seen
    step :create_notificaitons_for_new_users

    def find_users_with_incomplete_profile(ctx, **)
      ctx['users_without_complete_profile'] =
        User.joins(:user_site).where("experience_level IS NULL OR city IS NULL OR description IS NULL OR favourite_trick IS NULL")
    end

    def find_users_with_incomplete_user_site(ctx, **)
      ctx['users_without_complete_user_sites'] =
        User.joins(:user_site).where("headline ILIKE 'Board - Headline' OR text ILIKE 'Board - Headline'")
    end

    def create_notifications_for_already_seen(ctx, users_without_complete_user_sites:, users_without_complete_profile:, **)
      [{ model: users_without_complete_user_sites, type: 'incomplete_user_site' },
       { model: users_without_complete_profile, type: 'incomplete_profile' }].each do |notification|
        notification[:model].each do |user|
          if (notifications = user.notifications.where(type: notification[:type]).pluck(:seen).uniq) && notifications.present? && !notifications.include?(false)
            ::Notification.create(type: notification[:type], user: user)
          end
        end
      end
    end

    def create_notificaitons_for_new_users(ctx, users_without_complete_user_sites:, users_without_complete_profile:, **)
      [{ model: users_without_complete_user_sites, type: 'incomplete_user_site' },
       { model: users_without_complete_profile, type: 'incomplete_profile' }].each do |notification|
        notification[:model].includes(:notifications).each do |user|
          unless user.notifications.pluck(:type).uniq.include?(notification[:type])
            ::Notification.create(type: notification[:type], user: user)
          end
        end
      end
    end
  end
end