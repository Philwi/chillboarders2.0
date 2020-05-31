module User::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constant: User::Contract::Create)
    end

    step Subprocess(Present)
    step Contract::Validate(key: 'user')
    step Contract::Persist()
    step :create_default_user_site
    step :send_welcome_message_to_user

    def create_default_user_site(ctx, model:, **)
      UserSite.create(
        user: model,
        headline: I18n.t('.user_site.default_headline'),
        text: I18n.t('.user_site.default_text')
      )
    end

    def send_welcome_message_to_user(ctx, model:, **)
      params = ActionController::Parameters.new({
        user_message: {
          body: I18n.t('.user_messages.welcome'),
          for_user_id: model.id,
        }
      })
      UserMessage::Operation::Create.(params: params, user: User.first)
    end
  end
end