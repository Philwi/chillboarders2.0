module Spot::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :assign_model
      step Contract::Build(constant: Spot::Contract::Update)

      def assign_model(ctx, params:, **)
        ctx['model'] = Spot.find_by(slug: params[:id]) || Spot.find_by(id: params[:id])
      end
    end

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