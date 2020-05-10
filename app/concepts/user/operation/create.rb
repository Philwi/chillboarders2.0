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

    def create_default_user_site(ctx, model:, **)
      UserSite.create(
        user: model,
        headline: I18n.t('.user_site.default_headline'),
        text: I18n.t('.user_site.default_text')
      )
    end
  end
end