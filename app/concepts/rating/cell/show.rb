module Rating::Cell
  class Show < Trailblazer::Cell

    def rating
      content_tag(:div, class: 'filled-rating') do
        inner_out = ''
        1.upto(5) do |index|
          class_name = avaerage_rating <= index ? 'rating-star-filled' : 'rating-star-empty'
          inner_out.concat(content_tag(:span, '✪', class: class_name))
        end
        inner_out
      end
    end

    def avaerage_rating
      ratings = Rating.where(spot_id: options[:spot_id]).pluck(:rating)
      if ratings.present?
        ratings.sum / ratings.count
      else
        6
      end
    end

  end
end