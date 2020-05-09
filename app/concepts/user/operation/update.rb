module User::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :assign_user
      step Contract::Build(constant: User::Contract::Update)

      def assign_user(ctx, user:, **)
        ctx['model'] = user
      end
    end

    step Subprocess(Present)
    step Contract::Validate(key: 'user')
    step Contract::Persist()
    pass :attach_image_if_present

    def attach_image_if_present(ctx, model:, params:, **)
      if image = params.dig('user', 'image')
        model.avatar.attach(image)
      end
    end
  end
end