module Notification::Operation
  class Create < Trailblazer::Operation

    pass :persist

    def persist(ctx, description:, spot:, user_site:, active_storage_attachments_id:, user:, **)
      notification = Notification.new
      return true if user.blank?
      if active_storage_attachments_id.present?
        notification.type = 'attachment_comment'
        notification.from_user_id = user.id
        notification.user = User.find_by(id: ActiveStorage::Attachment.find(active_storage_attachments_id).record_id)
        notification.active_storage_attachments_id = active_storage_attachments_id
      elsif spot.present?
        notification.type = 'spot_comment'
        notification.from_user_id = user.id
        notification.user = spot.user
        notification.spot = spot
      elsif user_site.present?
        notification.type = 'user_site_comment'
        notification.from_user_id = user.id
        notification.user = user_site.user
        notification.user_site = user_site
      end
      notification.save if notification.user.id != notification.from_user_id
    end
  end
end