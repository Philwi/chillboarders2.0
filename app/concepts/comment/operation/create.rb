module Comment::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Comment, :new)
      step Contract::Build(constant: Comment::Contract::Create)
    end

    step Subprocess(Present)
    step Contract::Validate(key: 'comment')
    step :assign_associations
    step Contract::Persist()

    def assign_associations(ctx, params:, model:, user:, spot_id: nil, **)
      return false if (spot_id ||= params.dig('comment', 'spot_id')) && spot_id.blank?
      model.user = user
      model.spot = Spot.find(spot_id)
      ctx['model'] = model
    end
  end
end