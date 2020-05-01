module Spot::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Spot, :new)
      step Contract::Build(constant: Spot::Contract::Create)
    end

    step Subprocess(Present)
    step Contract::Validate(key: 'spot')
    step :assign_user
    step Contract::Persist()

    def assign_user(ctx, model:, user:, **)
      model.user = user
      ctx['model'] = model
    end
  end
end