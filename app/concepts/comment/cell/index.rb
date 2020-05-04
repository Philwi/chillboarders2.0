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
  end
end
