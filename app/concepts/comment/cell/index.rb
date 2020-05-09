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
      content_tag(:div, class: 'icon-with-number') do
        out = ''
        out.concat content_tag(:span, model.count, class: 'high-z-index')
        out.concat content_tag(:i, 'comment', class: 'material-icons')
      end
    end
  end
end
