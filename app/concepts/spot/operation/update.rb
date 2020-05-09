module Spot::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Spot, :find_by)
      step Contract::Build(constant: Spot::Contract::Update)
    end

    step :check_user
    step Subprocess(Present)
    step Contract::Validate(key: 'spot')
    step Contract::Persist()
    step :attach_new_images

    def attach_new_images(ctx, model:, params:, **)
      params.dig('spot', 'images')&.each do |image|
        model.images.attach(image)
      end
    end
  end
end