module Rating::Cell
  class Create < Trailblazer::Cell

    def rating
      content_tag(:div, class: 'rating') do
        inner_out = ''
        1.upto(5) do |index|
          inner_out.concat(content_tag(:span, '✪', class: "rating-star-#{index}", data: { reflex: "click->Rating::Reflex::Create#stars", spot_id: spot_id, spots: spots }))
        end
        inner_out
      end
    end

    def spot_id
      options[:spot_id]
    end

    def spots
      options[:spots]
    end

  end
end