module UserMessage::Operation
  class Create < Trailblazer::Operation

    class Present < Trailblazer::Operation
      step Model(UserMessage, :new)
      step Contract::Build(constant: UserMessage::Contract::Create)
    end

    step Subprocess(Present)
    step Contract::Validate(key: 'user_message')
    step :assign_user
    step Contract::Persist()

    def assign_user(ctx, user:, **)
      ctx[:model].user = user
    end
  end
end