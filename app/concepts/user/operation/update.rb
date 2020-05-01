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
  end
end