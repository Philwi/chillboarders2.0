module Chillboarders::Operation::Contact
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Contact, :new)
      step Contract::Build(constant: Chillboarders::Contract::Contact::Create)
    end

    step Subprocess(Present)
    step Contract::Validate(key: 'contact')
    step Contract::Persist()
  end
end