module Spot::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Spot, :find_by)
      step Contract::Build(constant: Spot::Contract::Update)
    end

    step Subprocess(Present)
    step Contract::Validate(key: 'spot')
    step Contract::Persist()
  end
end