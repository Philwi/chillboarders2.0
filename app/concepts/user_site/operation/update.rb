module UserSite::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :assign_model
      step Contract::Build(constant: UserSite::Contract::Update)

      def assign_model(ctx, user:, **)
        ctx['model'] = user.user_site
      end
    end

    step Subprocess(Present)
    step Contract::Validate(key: 'user_site')
    step Contract::Persist()
    pass :attach_image_if_present
    pass :attach_videos_if_present

    def attach_image_if_present(ctx, model:, params:, **)
      if images = params.dig('user_site', 'images')
        images.each do |image|
          model.images.attach(image)
        end
      end
    end

    def attach_videos_if_present(ctx, model:, params:, **)
      if videos = params.dig('user_site', 'videos')
        videos.each do |video|
          model.videos.attach(video)
        end
      end
    end

  end
end