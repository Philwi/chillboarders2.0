module Comment::Cell
  class Index < Trailblazer::Cell

    def comments
      out = ''
      out.concat(model.map do |comment|
        content_tag(:ul) do
          content_tag(:li, comment.description)
        end
      end.join)
    end

    def new_comment
      cell(::Comment::Cell::Create, ::Comment.new, spot_id: spot_id, spots: options[:spots]).()
    end

    def spot_id
      options[:spot_id]
    end

    def comments_count
      content_tag(:span, I18n.t(".misc.comments", amount: model.count), class: 'high-z-index')
    end
  end
end
