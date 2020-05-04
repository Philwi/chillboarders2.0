module Comment::Cell
  class Index < Trailblazer::Cell

    def comments
      out = ''
      out.concat content_tag(:h5, "#{model.count} Kommentare")
      out.concat(model.map do |comment|
        content_tag(:ul) do
          content_tag(:li, comment.description)
        end
      end.join)
    end

    def new_comment
      cell(::Comment::Cell::Create, ::Comment.new, spot_id: spot_id).()
    end

    def spot_id
      options[:spot_id]
    end

    def comments_count
      "#{model.count} #{I18n.t('.misc.comments')}"
    end
  end
end
