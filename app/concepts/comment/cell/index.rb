module Comment::Cell
  class Index < Trailblazer::Cell
    include ::Devise::Controllers::Helpers

    def new_comment
      cell(::Comment::Cell::Create, ::Comment.new, spot_id: spot_id, spots: options[:spots], user_site_id: options[:user_site_id], attachment_id: options[:attachment_id]).()
    end

    def spot_id
      options[:spot_id]
    end

    def comments_count
      content_tag(:span, I18n.t(".misc.comments", amount: model.count), class: 'high-z-index')
    end
  end
end
