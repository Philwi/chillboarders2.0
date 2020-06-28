module Comment::Operation
  class Create < Trailblazer::Operation

    step :check_params
    step :persist
    pass ->(ctx, description:, spot:, user_site:, active_storage_attachments_id:, user:, **) do
      Notification::Operation::Create.(
        params: nil, description: description, spot: spot,
        user_site: user_site, active_storage_attachments_id: active_storage_attachments_id,
        user: user
      )
    end

    def check_params(ctx, description:, user:, **)
      description.present? && user.present?
    end

    def persist(ctx, description:, spot:, user_site:, active_storage_attachments_id:, user:, **)
      Comment.create(
        description: description,
        user: user,
        spot: spot,
        user_site: user_site,
        active_storage_attachments_id: active_storage_attachments_id
      )
    end
  end
end